# Excluded Wave 1 path-rebase startup attempt

This directory preserves an excluded startup attempt from 2026-07-13.  The
frozen launch plan was invoked from `PromptSteering` with an output argument
already prefixed by `long-code-sample-work/`.  Because the registered runner
rebases every relative output root beneath its own `long-code-sample-work`
directory, the attempt landed at a duplicated nested path.

The four tmux sessions were stopped immediately after 21 total records
(`6 + 3 + 6 + 6`) and before any monitoring outcome was used to select or
change cases.  The entire directory was moved here intact.  It is excluded
from every audit, trigger, selection, and final package.  A corrected launch
plan must resolve its working directory, script, manifest, and output roots
exactly before Wave 1 is restarted from empty result roots.
