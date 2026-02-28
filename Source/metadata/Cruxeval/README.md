---
dataset_info:
  features:
  - name: id
    dtype: int16
  - name: code
    dtype: string
  - name: input_reasoning
    dtype: string
  - name: output_reasoning
    dtype: string
  splits:
  - name: Java
    num_bytes: 636477
    num_examples: 698
  - name: Cpp
    num_bytes: 524869
    num_examples: 733
  - name: Go
    num_bytes: 1154928
    num_examples: 699
  - name: CS
    num_bytes: 611052
    num_examples: 670
  - name: D
    num_bytes: 389856
    num_examples: 629
  - name: Julia
    num_bytes: 337192
    num_examples: 680
  - name: JavaScript
    num_bytes: 479501
    num_examples: 743
  - name: PHP
    num_bytes: 591950
    num_examples: 755
  - name: Perl
    num_bytes: 592538
    num_examples: 728
  - name: Python
    num_bytes: 437450
    num_examples: 799
  - name: R
    num_bytes: 442165
    num_examples: 699
  - name: Lua
    num_bytes: 547513
    num_examples: 741
  - name: Ruby
    num_bytes: 505435
    num_examples: 748
  - name: Racket
    num_bytes: 486918
    num_examples: 681
  - name: Rust
    num_bytes: 420501
    num_examples: 690
  - name: Scala
    num_bytes: 486392
    num_examples: 712
  - name: Shell
    num_bytes: 401829
    num_examples: 674
  - name: Swift
    num_bytes: 753755
    num_examples: 654
  - name: TypeScript
    num_bytes: 549683
    num_examples: 726
  download_size: 2560598
  dataset_size: 10350004
configs:
- config_name: default
  data_files:
  - split: Java
    path: data/Java-*
  - split: Cpp
    path: data/Cpp-*
  - split: Go
    path: data/Go-*
  - split: CS
    path: data/CS-*
  - split: D
    path: data/D-*
  - split: Julia
    path: data/Julia-*
  - split: JavaScript
    path: data/JavaScript-*
  - split: PHP
    path: data/PHP-*
  - split: Perl
    path: data/Perl-*
  - split: Python
    path: data/Python-*
  - split: R
    path: data/R-*
  - split: Lua
    path: data/Lua-*
  - split: Ruby
    path: data/Ruby-*
  - split: Racket
    path: data/Racket-*
  - split: Rust
    path: data/Rust-*
  - split: Scala
    path: data/Scala-*
  - split: Shell
    path: data/Shell-*
  - split: Swift
    path: data/Swift-*
  - split: TypeScript
    path: data/TypeScript-*
---
<h1 align="center"> CRUXEVAL-X: A Benchmark for Multilingual Code Reasoning, Understanding and Execution </h1>

<p align="center">
    <a href="https://arxiv.org/pdf/2408.13001">📃 Paper</a> •
    <a href="https://huggingface.co/spaces/xhwl/cruxeval-x">🤗 Space </a> •
    <a href="https://cruxeval-x.github.io/leaderboard.html">🏆 Leaderboard</a> •
    <a href="https://github.com/CRUXEVAL-X/cruxeval-x">🔎 Github Repo</a>
</p>

## Dataset Description
CRUXEVAL-X stands as a multi-lingual code reasoning benchmark, encompassing 19 programming languages and built upon the foundation of CRUXEVAL. This comprehensive resource features a minimum of 600 subjects per language, collectively contributing to a robust total of 19,000 content-consistent tests.
## Dataset Structure
### Data Instances
A data point corresponds to a Java problem:
```
{
  'id': 0,
  'code': 'import java.io.*;\nimport java.lang.reflect.*;\nimport java.math.*;\nimport java.security.*;\nimport java.util.*;\nimport java.util.stream.*;\nimport org.javatuples.*;\nimport org.javatuples.Pair;\nimport java.util.*;\n\n\nclass Problem {\n    public static ArrayList<Pair<Long, Long>> f(ArrayList<Long> nums) {\n        ArrayList<Pair<Long, Long>> output = new ArrayList<>();\n        for (Long n : nums) {\n            output.add(new Pair<>((long) Collections.frequency(nums, n), n));\n        }\n        output.sort((a, b) -> b.getValue0().compareTo(a.getValue0()));\n        return output;\n    }\n    public static void main(String[] args) {\n    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)3l, (long)1l, (long)3l, (long)1l)))).equals((new ArrayList<Pair<Long, Long>>(Arrays.asList((Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(2l, 3l), (Pair<Long, Long>)Pair.with(2l, 3l))))));\n    }\n\n}\n',
  'input_reasoing': '    }\n    public static void main(String[] args) {\n    assert(f(????).equals((new ArrayList<Pair<Long, Long>>(Arrays.asList((Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(4l, 1l), (Pair<Long, Long>)Pair.with(2l, 3l), (Pair<Long, Long>)Pair.with(2l, 3l))))));\n    }\n\n}\n',
  'output_reasoing': '    }\n    public static void main(String[] args) {\n    assert(f((new ArrayList<Long>(Arrays.asList((long)1l, (long)1l, (long)3l, (long)1l, (long)3l, (long)1l)))).equals(????));\n    }\n\n}\n'
}
```
### Data Fields

- `id`: The id of each problem, which is in consistent with the cruxeval benchmark. Different languanges with the same id means the same problem.
- `code`: The code which model need to understand the execution process 
- `input_reasoing`: the check function which replace the input to '????'
- `output_reasoing`:  the check function which replace the output to '????'

## Citation Information

```bibtex
@misc{xu2024cruxevalxbenchmarkmultilingualcode,
      title={CRUXEval-X: A Benchmark for Multilingual Code Reasoning, Understanding and Execution}, 
      author={Ruiyang Xu and Jialun Cao and Yaojie Lu and Hongyu Lin and Xianpei Han and Ben He and Shing-Chi Cheung and Le Sun},
      year={2024},
      eprint={2408.13001},
      archivePrefix={arXiv},
      primaryClass={cs.AI},
      url={https://arxiv.org/abs/2408.13001}, 
}

```