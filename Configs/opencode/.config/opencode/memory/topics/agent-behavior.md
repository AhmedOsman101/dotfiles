# Agent Behavior

- id: review-gate-pass-gui
  date: 2026-11-19
  tags: [human-review,commit-gate,issue-close,pass-gui,delegation]
  core: true
  fact: In pass-gui, never commit or close an issue without explicit human review approval — present the diff first. Exception granted for issues #27 and #28 only: user explicitly authorized the agent to commit, push and close after a senior-reviewer subagent finishes with zero findings. Other tickets still require human approval.
