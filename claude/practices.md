# Working practices (all machines)

Machine-specific rules live in each machine's `~/.claude/CLAUDE.md`, next to the import of this file.

## Plans

Ask initial scoping questions BEFORE drafting a plan — constraints arrive up front,
not bolted on mid-review. Every plan states: its assumptions, what will NOT be
touched, and how the result gets verified. Then ask questions to build shared
understanding about the plan before sharing it.

## Debugging discipline

Trace the actual invocation path (desktop file → wrapper → symlink → binary;
or unit → env → command) before hypothesizing missing libraries or packages.
State the evidence for a diagnosis before proposing the fix, then re-verify
through the exact same path the user uses. (Origin: the ITK-SNAP
libxcb-cursor0 misdiagnosis — the launch wrapper was at fault.)

## Claims and verification

No analytical or empirical conclusion without a control comparison or the
reproducible command that produced it. Label inferred-not-measured claims
UNVERIFIED. When re-deriving prior conclusions, say which earlier claims are
being retracted.

## Scope limits

Never change retention settings, system-wide config, or long-lived defaults
without explicit approval; propose them separately and default to the most
conservative value. Bulk or destructive file moves write a manifest and go to
a reversible attic location first.

## Changes must be disclosed

No hidden flags, options, or config keys — end every multi-file change with a
short "Changes made:" list of files and new options. Prefer the minimal
change; try the simplest configuration path empirically before reaching for
containers or shims.

## Data privacy

Never dump raw logs, DICOM headers, or filenames containing patient
identifiers into the transcript. Redact subject IDs (`sub-XXX`); grep only the
relevant lines. If interaction with data is needed, ask the user to provided redacted
targeted information without any personal information.

## Long-running and background jobs

Verify resource limits actually took effect (read back cgroup/affinity —
systemd CPUQuota can be silently ignored). Confirm required symlinks and
settings files exist, then do a ~60-second smoke run before the full run.
Never bare `pgrep <pattern>` (it matches your own command line) — use
`pgrep -f` plus self-filtering, PID files, or joblog exit codes; treat
instant `exit=0` joblog entries as a failure signal, not success. Sort inputs
before `join`.

## Config lives in the shared repo

Fixes to shell/editor/terminal config belong in
`/fileserver/external/body/liam/configs` (branch `wombat`) — after any config
fix, confirm the real file is tracked AND committed (the alacritty theme was
lost for years because it never was), and note whether the change still needs
rollout to the other machines.

## Python/GPU environments

Conda envs: activate explicitly and verify imports before use; never
`pip install` into a read-only env (clone it instead). Check `nvcc` and disk
space before launching GPU or long batch jobs.

## Session endings

When a session is about to end with work in flight, write a short handoff
note (state, next step, open questions) rather than letting findings
evaporate.
