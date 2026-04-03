# Joern Slicing Quick Start

This repo supports Joern-backed program slicing through:

- `steering/joern_slice.py`
- `tools/extract_joern_variable_slices.py`
- `tools/joern_slice_experiment.py`

Joern is expected at:

```bash
JOERN_CLI_DIR=/path/to/joern/joern-cli
```

## 1. Single-file slicing

Use the repo wrapper for normal use:

```bash
python3 tools/extract_joern_variable_slices.py /path/to/file.c --direction backward
```

Forward slicing:

```bash
python3 tools/extract_joern_variable_slices.py /path/to/file.c --direction forward
```

Useful options:

```bash
--language c|cpp|java|python
--timeout-sec 45
--slice-depth 20
--include-control on
--include-post-dominance off
--output /tmp/slices.json
```

Backward slicing is the default and is usually the better choice for vulnerability detection.

## 2. What the wrapper does

The wrapper:

1. infers the language from the file extension,
2. builds a CPG with the correct Joern frontend,
3. runs `joern-slice data-flow`,
4. groups the graph by variable,
5. builds per-variable forward or backward slices,
6. returns a JSON summary with:
   - graph size,
   - number of variable slices,
   - per-variable slice lines,
   - metadata about the run.

## 3. Raw Joern usage

If you want the raw Joern artifacts, run the frontend directly.

C/C++:

```bash
$JOERN_CLI_DIR/c2cpg.sh file.c --output cpg.bin
```

Java:

```bash
$JOERN_CLI_DIR/javasrc2cpg file.java --output cpg.bin
```

Python:

```bash
$JOERN_CLI_DIR/pysrc2cpg /path/to/source_dir --output cpg.bin
```

Then run slicing:

```bash
$JOERN_CLI_DIR/bin/joern-slice \
  -J-XX:+UseG1GC \
  -J-XX:CompressedClassSpaceSize=128m \
  -Dlog4j.configurationFile=$JOERN_CLI_DIR/conf/log4j2.xml \
  data-flow cpg.bin -o slices --slice-depth 20
```

This produces:

```text
cpg.bin
slices.json
```

## 4. Notes

- The raw `data-flow` slicer can be slow. Small files are fine; larger files may need a higher timeout.
- A very narrow `--sink-filter` can produce an empty slice. If that happens, generate the full slice graph first and filter later in Python.
- Python is special: `pysrc2cpg` expects a source directory, not just a single file.
- The wrapper caches Joern slice graphs under `.cache/joern_slice`.

## 5. Corpus experiments

To test a random sample from a corpus:

```bash
python3 tools/joern_slice_experiment.py \
  --source-root /path/to/corpus \
  --pattern '*.cpp' \
  --sample-size 50 \
  --directions backward,forward \
  --timeout-sec 45 \
  --output /tmp/joern_experiment.json
```

The experiment output records:

- success or error for each file and direction,
- timing,
- graph size,
- number of variable slices,
- top-scoring lines from the aggregated slice.
