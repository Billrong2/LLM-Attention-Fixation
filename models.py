#!/usr/bin/env python3
# models.py
# Class-based wrapper for Hugging Face causal LMs (e.g., CodeLlama, Qwen2.5)
# with attention capture, pooled-attention summaries, and optional steering.
#
# Notes:
# - Only HUGGINGFACE_TOKEN is read from the environment (optional).
# - All other settings are hard-coded defaults; change them via llama.config(...).
# - Keep attn_implementation="eager" so attention tensors are exposed.
# - 70B BF16 typically needs large VRAM (e.g., 4x80GB). Set use_4bit=True to experiment on smaller GPUs.
# - Attention tensors scale ~O(L^2); long prompts or large max_new_tokens increase memory.

from __future__ import annotations
import os
import json
import pprint
from typing import Dict, Any, List, Tuple, Optional, Sequence

from huggingface_hub import login
import torch
from transformers import (
    AutoTokenizer,
    AutoModelForCausalLM,
    GenerationConfig,
)
from transformers.generation.logits_process import LogitsProcessor, LogitsProcessorList
from steering import SteeringConfig
from steering.backends import install_steering_hooks
from steering.pointer import PointerBiasProcessor, StepAdvanceProcessor
from steering.runtime import SteeringRuntime, create_runtime
from attn_postprocess import POOLING_STRATEGIES, postprocess_generation_attentions

# ----------------------------
# Hard-coded defaults (change via llama.config(...))
# ----------------------------
DEFAULT_MODEL_NAME = "codellama/CodeLlama-70b-Instruct-hf"
DEFAULT_CACHE_DIR  = "/data/xxr230000/model_cache/codellama_70b"
DEFAULT_USE_4BIT   = False
DEFAULT_MAX_NEW    = 256
DEFAULT_TEMP       = 0.7
DEFAULT_TOP_P      = 1.0
DEFAULT_TOP_K      = 7
DEFAULT_TOP_ATTN_K = 10
DEFAULT_ATTN_DIR   = "attn_viz"
DEFAULT_MEM_FRAC   = 0.90
DEFAULT_KEY_SCOPE  = "prompt"   # "prompt" | "all"
DEFAULT_RENORMAL   = True
DEFAULT_MAX_DEVICES: Optional[int] = None

class _SanitizeLogitsProcessor(LogitsProcessor):
    """
    Guardrail against rare NaN/Inf logits causing `torch.multinomial` failures during sampling.

    This is especially useful for fp16 inference on some checkpoints. It does not change
    behavior when logits are already finite.
    """

    def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor) -> torch.FloatTensor:
        if not torch.isfinite(scores).all():
            # Replace NaN/Inf with large finite values so softmax stays well-defined.
            scores = torch.nan_to_num(scores, nan=-1e9, posinf=1e9, neginf=-1e9)
        # Avoid extreme magnitudes that can still destabilize softmax on some stacks.
        return scores.clamp(min=-1e9, max=1e9)

class SteeredCausalLM:
    """
    Generic HF causal LM wrapper with attention capture and optional steering.

    Usage:
        lm = SteeredCausalLM()
        lm.login_hf()  # optional; reads HUGGINGFACE_TOKEN if set
        lm.config(
            model_name="codellama/CodeLlama-70b-Instruct-hf",
            cache_dir="/path/to/cache",
            use_4bit=True,
            max_new_tokens=128,
            temperature=0.7,
            top_p=1.0,
            top_k=7,
            top_attended_k=10,
            attn_dump_dir="attn_dumps",
            mem_fraction=0.90,
            key_scope="prompt",   # or "all"
            renormalize=True,
        )
        lm.build()
        result = lm.run_llama("def two_sum(...): ...", language="python")
        lm.save_dump(result, "attn_dumps/attn_summary.json")
        lm.free()
    """



    # ----------------------------
    # Construction / Configuration
    # ----------------------------
    def __init__(self):

        # hard-coded defaults (no env reads here)
        self.model_name: str = DEFAULT_MODEL_NAME
        self.cache_dir:  str = DEFAULT_CACHE_DIR
        self.use_4bit:   bool = DEFAULT_USE_4BIT
        self.max_new_tokens: int = DEFAULT_MAX_NEW
        self.temperature: float  = DEFAULT_TEMP
        self.top_p: float        = DEFAULT_TOP_P
        self.top_k: int          = DEFAULT_TOP_K
        self.top_attended_k: int = DEFAULT_TOP_ATTN_K
        self.attn_dump_dir: str  = DEFAULT_ATTN_DIR
        self.mem_fraction: float = DEFAULT_MEM_FRAC
        self.key_scope: str      = DEFAULT_KEY_SCOPE
        self.renormalize: bool   = DEFAULT_RENORMAL
        self.max_devices: Optional[int] = DEFAULT_MAX_DEVICES

        # internals
        self.model: Optional[AutoModelForCausalLM] = None
        self.tokenizer: Optional[AutoTokenizer] = None
        self.steering_config: Optional[SteeringConfig] = None
        self._steering_runtime: Optional[SteeringRuntime] = None
        self._current_code_snippet: str = ""
        self._current_vocab_tokens: Sequence[dict] = []

    def config(
        self,
        *,
        model_name: Optional[str] = None,
        cache_dir: Optional[str] = None,
        use_4bit: Optional[bool] = None,
        max_new_tokens: Optional[int] = None,
        temperature: Optional[float] = None,
        top_p: Optional[float] = None,
        top_k: Optional[int] = None,
        top_attended_k: Optional[int] = None,
        attn_dump_dir: Optional[str] = None,
        mem_fraction: Optional[float] = None,
        key_scope: Optional[str] = None,           # "prompt" | "all"
        renormalize: Optional[bool] = None,
        max_devices: Optional[int] = None,
    ) -> "SteeredCausalLM":
        """Programmatic configuration (no environment variables used)."""
        if model_name is not None:     self.model_name = model_name
        if cache_dir is not None:      self.cache_dir = cache_dir
        if use_4bit is not None:       self.use_4bit = use_4bit
        if max_new_tokens is not None: self.max_new_tokens = max_new_tokens
        if temperature is not None:    self.temperature = temperature
        if top_p is not None:          self.top_p = top_p
        if top_k is not None:          self.top_k = top_k
        if top_attended_k is not None: self.top_attended_k = top_attended_k
        if attn_dump_dir is not None:  self.attn_dump_dir = attn_dump_dir
        if mem_fraction is not None:   self.mem_fraction = mem_fraction
        if key_scope is not None:      self.key_scope = key_scope.lower()
        if renormalize is not None:    self.renormalize = renormalize
        if max_devices is not None:    self.max_devices = max_devices
        return self

    def set_steering_config(self, config: SteeringConfig) -> None:
        self.steering_config = config

    # ----------------------------
    # Auth (only HUGGINGFACE_TOKEN allowed from env)
    # ----------------------------
    def login_hf(self, token: Optional[str] = None):
        """
        Login to Hugging Face Hub. If token not provided explicitly,
        falls back to the HUGGINGFACE_TOKEN environment variable.
        """
        tok = token or os.getenv("HUGGINGFACE_TOKEN")
        if tok:
            login(token=tok)

    # ----------------------------
    # Build / Load
    # ----------------------------
    @staticmethod
    def _auto_max_memory_dict(fraction: float = 0.90) -> Dict[int, str]:
        """
        Build a max_memory dict for all visible GPUs using a fraction of total VRAM.
        Example return: {0: '71GiB', 1: '71GiB', 2: '71GiB', 3: '71GiB'}
        """
        if not torch.cuda.is_available():
            return {}
        n = torch.cuda.device_count()
        mm: Dict[int, str] = {}
        for i in range(n):
            props = torch.cuda.get_device_properties(i)
            allowed = int(props.total_memory * fraction)
            mm[i] = f"{allowed // (1024**3)}GiB"
        return mm

    def build(self):
        """Load tokenizer + model with attention enabled configuration."""
        print(f"Loading model: {self.model_name}")
        print(f"USE_4BIT={self.use_4bit}  |  GPUs visible={torch.cuda.device_count() if torch.cuda.is_available() else 0}")
        max_memory = self._auto_max_memory_dict(self.mem_fraction)
        selected_devices = None
        if torch.cuda.is_available() and max_memory:
            if self.max_devices is not None:
                visible = torch.cuda.device_count()
                use = max(1, min(self.max_devices, visible))
                selected_devices = list(range(use))
                max_memory = {k: v for k, v in max_memory.items() if k in selected_devices}
                print(f"Limiting to {use} GPU(s) (of {visible}).")
            print("Per-GPU max_memory cap:", max_memory)

        tok = AutoTokenizer.from_pretrained(self.model_name, cache_dir=self.cache_dir)
        for k in ["hidden_size","num_hidden_layers","num_attention_heads","num_key_value_heads",
          "intermediate_size","rms_norm_eps","rope_theta","max_position_embeddings",
          "vocab_size","tie_word_embeddings"]:
            print(k, "=", getattr(tok, k, None))
        if tok.pad_token is None:
            tok.pad_token = tok.eos_token
            tok.pad_token_id = tok.eos_token_id

        common = dict(
            device_map="auto",
            cache_dir=self.cache_dir,
            attn_implementation="eager",
        )
        if max_memory:
            common["max_memory"] = max_memory

        force_4bit = self.use_4bit or bool(int(os.environ.get("LLM_FORCE_4BIT", "0")))
        model = None
        if force_4bit:
            try:
                model = AutoModelForCausalLM.from_pretrained(
                    self.model_name,
                    load_in_4bit=True,
                    bnb_4bit_use_double_quant=True,
                    bnb_4bit_quant_type="nf4",
                    bnb_4bit_compute_dtype=torch.bfloat16,
                    **common,
                )
                print("[Steering] Loaded model in 4-bit NF4 mode.")
            except (ImportError, AttributeError, RuntimeError) as err:
                print(f"[WARN] 4-bit load failed ({err}); falling back to full precision.")

        if model is None:
            if torch.cuda.is_available():
                dtype = torch.bfloat16 if torch.cuda.is_bf16_supported() else torch.float16
            else:
                dtype = torch.float32
            model = AutoModelForCausalLM.from_pretrained(
                self.model_name,
                torch_dtype=dtype,
                low_cpu_mem_usage=True,
                **common,
            )
            print(f"[INFO] Loaded model with torch_dtype={dtype}.")

        model.eval()
        self.model = model
        self.tokenizer = tok

        # ensure model config pad/eos are set (required for HF >=4.38 generation)
        if model.config.pad_token_id is None:
            model.config.pad_token_id = tok.pad_token_id
        if model.config.eos_token_id is None:
            model.config.eos_token_id = tok.eos_token_id

        if self.steering_config and self.steering_config.enabled_levels:
            self._install_steering_hooks()

        # Optional: print device map
        try:
            print("\n=== Device map (layer -> GPU) ===")
            pprint.pprint(model.hf_device_map)
        except Exception:
            pass

    # ----------------------------
    # Utilities
    # ----------------------------
    # ----------------------------
    # Core: generate with attention
    # ----------------------------
    def _generate_with_attn(
        self,
        prompt: str,
        *,
        overrides: Optional[Dict[str, Any]] = None,
    ) -> Dict[str, Any]:
        assert self.model is not None and self.tokenizer is not None, "Call .build() first."

        enc = self.tokenizer(prompt, return_tensors="pt")
        enc = {k: v.to(self.model.device) for k, v in enc.items()}
        input_ids = enc["input_ids"]
        prompt_len = input_ids.shape[-1]

        overrides = overrides or {}
        temperature = overrides.get("temperature", self.temperature)
        top_p = overrides.get("top_p", self.top_p)
        top_k = overrides.get("top_k", self.top_k)
        max_new_tokens = overrides.get("max_new_tokens", self.max_new_tokens)
        record_layers = bool(overrides.get("record_layers", True))
        record_attention = bool(overrides.get("record_attention", record_layers))
        record_layers = record_layers and record_attention
        do_sample = overrides.get("do_sample")
        if do_sample is None:
            do_sample = temperature > 0

        runtime: Optional[SteeringRuntime] = None
        logits_processor = LogitsProcessorList()
        if self.steering_config:
            prompt_ids = input_ids[0].tolist()
            prompt_tokens = self.tokenizer.convert_ids_to_tokens(prompt_ids)
            code_text = getattr(self, "_current_code_snippet", "")
            runtime = create_runtime(
                self.steering_config,
                prompt_token_ids=prompt_ids,
                prompt_tokens=prompt_tokens,
                code_text=code_text,
                vocab_tokens=self._current_vocab_tokens,
            )
            runtime.start(max_new_tokens)
            self._steering_runtime = runtime
            if 5 in self.steering_config.enabled_levels:
                logits_processor.append(PointerBiasProcessor(runtime))
            else:
                logits_processor.append(StepAdvanceProcessor(runtime))
        logits_processor.append(_SanitizeLogitsProcessor())

        gen_cfg = GenerationConfig(
            max_new_tokens=max_new_tokens,
            do_sample=do_sample,
            temperature=temperature,
            top_p=top_p,
            top_k=None if (top_k or 0) <= 0 else top_k,
            cache_dir=self.cache_dir,
            pad_token_id=self.tokenizer.pad_token_id,
            eos_token_id=self.tokenizer.eos_token_id,
        )

        with torch.no_grad():
            out = self.model.generate(
                **enc,
                generation_config=gen_cfg,
                return_dict_in_generate=True,
                output_attentions=record_attention,   # capture attention only when requested
                output_scores=False,
                use_cache=True,
                logits_processor=logits_processor,
            )

        sequences = out.sequences  # [batch, prompt_len + gen_len]

        if runtime:
            self._steering_runtime = None
        full_text = self.tokenizer.decode(sequences[0], skip_special_tokens=True)
        prompt_text = self.tokenizer.decode(sequences[0][:prompt_len], skip_special_tokens=True)
        generated_completion = self.tokenizer.decode(sequences[0][prompt_len:], skip_special_tokens=True)

        total_len = sequences.shape[-1]
        num_generated = total_len - prompt_len
        ids_all = sequences[0].tolist()
        tokens_all = self.tokenizer.convert_ids_to_tokens(ids_all)

        if not record_attention:
            return {
                "model": self.model_name,
                "use_4bit": self.use_4bit,
                "prompt_length_tokens": prompt_len,
                "num_generated_tokens": num_generated,
                "tokens_all": tokens_all,
                "token_ids_all": ids_all,
                "generated_text": full_text,
                "prompt_text": prompt_text,
                "generated_completion": generated_completion,
                "attention_by_generated_token": [],
                "pooled_attention_by_generated_token": [],
                "global_pooled_attention_over_prompt": {},
                "pooling_strategies": dict(POOLING_STRATEGIES),
                "key_scope": self.key_scope,
                "renormalized": self.renormalize,
                "layer_prompt_stats": None,
                "record_layers": False,
                "record_attention": False,
            }

        attn_summaries = postprocess_generation_attentions(
            attentions=getattr(out, "attentions", None),
            tokens_all=tokens_all,
            prompt_len=prompt_len,
            num_generated=num_generated,
            key_scope=self.key_scope,
            renormalize=self.renormalize,
            top_attended_k=self.top_attended_k,
            record_layers=record_layers,
            model=self.model,
        )

        return {
            "model": self.model_name,
            "use_4bit": self.use_4bit,
            "prompt_length_tokens": prompt_len,
            "num_generated_tokens": num_generated,
            "tokens_all": tokens_all,
            "token_ids_all": ids_all,
            "generated_text": full_text,
            "prompt_text": prompt_text,
            "generated_completion": generated_completion,
            # per-layer diagnostic (kept)
            "attention_by_generated_token": attn_summaries.attention_by_generated_token if record_layers else [],
            # per-step per-pool top-K
            "pooled_attention_by_generated_token": attn_summaries.pooled_attention_by_generated_token,
            # global per-pool distribution over prompt tokens (only when KEY_SCOPE='prompt')
            "global_pooled_attention_over_prompt": attn_summaries.global_pooled_attention_over_prompt,
            "pooling_strategies": dict(POOLING_STRATEGIES),
            "key_scope": self.key_scope,
            "renormalized": self.renormalize,
            "layer_prompt_stats": attn_summaries.layer_prompt_stats,
            "record_layers": record_layers,
            "record_attention": record_attention,
        }

    # ----------------------------
    # Public interface
    # ----------------------------
    def run_llama(
        self,
        code_snippet: str,
        instruction: Optional[str] = None,
        *,
        language: str = "java",
        max_new_tokens: Optional[int] = None,
        temperature: Optional[float] = None,
        top_p: Optional[float] = None,
        top_k: Optional[int] = None,
        do_sample: Optional[bool] = None,
        record_layers: Optional[bool] = None,
        record_attention: Optional[bool] = None,
        vocab_tokens: Optional[Sequence[dict]] = None,
    ) -> Dict[str, Any]:
        """
        Generate with the configured causal LM using a caller-provided instruction.
        """
        if instruction is None:
            instruction = "Summarize what this Java function does. Be concise and accurate."

        prompt = (
            f"{instruction}\n\n"
            f"```{language}\n{code_snippet}\n```"
        )

        overrides: Dict[str, Any] = {}
        if max_new_tokens is not None:
            overrides["max_new_tokens"] = max_new_tokens
        if temperature is not None:
            overrides["temperature"] = temperature
        if top_p is not None:
            overrides["top_p"] = top_p
        if top_k is not None:
            overrides["top_k"] = top_k
        if do_sample is not None:
            overrides["do_sample"] = do_sample
        if record_layers is not None:
            overrides["record_layers"] = record_layers
        if record_attention is not None:
            overrides["record_attention"] = record_attention

        self._current_code_snippet = code_snippet
        self._current_vocab_tokens = vocab_tokens or []
        try:
            return self._generate_with_attn(prompt, overrides=overrides)
        finally:
            self._current_code_snippet = ""
            self._current_vocab_tokens = []

    # Steering integration -------------------------------------------------

    def _install_steering_hooks(self) -> None:
        assert self.model is not None
        assert self.steering_config is not None

        def runtime_getter():
            return self._steering_runtime

        backend = install_steering_hooks(self.model, runtime_getter, self.steering_config)
        print(f"[Steering] Installed backend={backend}.")

    def save_dump(self, result: Dict[str, Any], json_path: str) -> str:
        """Persist a result to JSON and return the path."""
        os.makedirs(os.path.dirname(json_path) or ".", exist_ok=True)
        with open(json_path, "w", encoding="utf-8") as f:
            json.dump(result, f, ensure_ascii=False, indent=2)
        return json_path

    def free(self):
        """Release model and VRAM."""
        self.model = None
        self.tokenizer = None
        if torch.cuda.is_available():
            torch.cuda.empty_cache()


# Backwards-compatible aliases (the codebase historically used `llama70b()` as
# the entrypoint for any causal LM; keep it to avoid touching other modules).
ModelRunner = SteeredCausalLM
llama70b = SteeredCausalLM
