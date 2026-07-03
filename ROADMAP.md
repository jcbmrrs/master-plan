# ROADMAP

> AI-native task tracking. Managed by the [waypoint](https://github.com/jcbmrrs/waypoint) plugin.
>
> **Quick start**: `/waypoint:add` to add a task, `/waypoint:next` to pick one, `/waypoint:done` when finished.

## Project Overview

waypoint is itself an AI-native task management plugin for Claude Code (four skills: `add`, `next`, `save`, `done` operating on a ROADMAP.md file). This is the meta-ROADMAP for the waypoint project's own development.

**Project**: waypoint
**Stack**: Markdown-only Claude Code plugin (no build, no deps)
**Status**: In Development

## Roadmap

| ID | Title | Priority | Status | Dependencies |
|----|-------|----------|--------|--------------|
| ~~**TASK-1**~~ | ✅ **Initial release: AI-native task management plugin** | **P1** | ✅ DONE (2026-02-23) | - |
| ~~**TASK-2**~~ | ✅ **Public release infra (LICENSE, marketplace.json, gitignore)** | **P2** | ✅ DONE (2026-02-24) | TASK-1 |
| ~~**TASK-3**~~ | ✅ **Rewrite README for zero-friction onboarding** | **P2** | ✅ DONE (2026-02-24) | TASK-1 |
| ~~**BUG-4**~~ | ✅ **Fix marketplace source path ('.' vs './')** | **P1** | ✅ DONE (2026-02-24) | TASK-2 |
| ~~**TASK-5**~~ | ✅ **Add and iterate on README cover image** | **P3** | ✅ DONE (2026-07-01) | TASK-3 |
| ~~**TASK-6**~~ | ✅ **Smarter subtask completion with user verification** | **P1** | ✅ DONE (2026-06-30) | - |
| ~~**TASK-7**~~ | ✅ **Ignore local Claude files (gitignore)** | **P3** | ✅ DONE (2026-06-30) | - |
| ~~**TASK-8**~~ | ✅ **Rebrand master-plan → waypoint** | **P1** | ✅ DONE (2026-06-30) | TASK-6 |
| ~~**BUG-9**~~ | ✅ **Remove stale master-plan references from done skill report** | **P2** | ✅ DONE (2026-06-30) | TASK-8 |
| **TASK-10** | **Non-interactive fallback for skills on non-Claude-Code tools** | **P3** | PLANNED | - |

## Active Work

### TASK-10: Non-interactive fallback for skills on non-Claude-Code tools (PLANNED)
**Priority**: P3
**Status**: PLANNED (2026-07-02)

README claims core functionality works across any Agent Skills-compatible tool (Cursor, GitHub Copilot, Windsurf), but all four skills (`add`, `next`, `save`, `done`) rely on `AskUserQuestion`, which is Claude-Code-specific. On tools without it, the interactive info-gathering steps break rather than degrade gracefully. Low priority — this is currently a personal tool built for Claude Code use.

**Tasks**:
- [ ] Decide: add non-interactive fallbacks to skills, or scope the README's cross-platform claim down to what's actually supported

## Completed

### ~~TASK-1~~: Initial release: AI-native task management plugin (✅ DONE)
**Priority**: P1
**Status**: ✅ DONE (2026-02-23)

Shipped the first version of the plugin (then named master-plan) — four skills for AI-native task tracking against a plan file.

**Tasks**:
- [x] Build `task`/`next`/`save`/`done` skills
- [x] Define plan-file format and search order

### ~~TASK-2~~: Public release infra (LICENSE, marketplace.json, gitignore) (✅ DONE)
**Priority**: P2
**Status**: ✅ DONE (2026-02-24)

Added the files needed to distribute the plugin publicly through the Claude Code marketplace.

**Tasks**:
- [x] Add LICENSE
- [x] Add marketplace.json
- [x] Add .gitignore

### ~~TASK-3~~: Rewrite README for zero-friction onboarding (✅ DONE)
**Priority**: P2
**Status**: ✅ DONE (2026-02-24)

Rewrote the README so a new user can install and create their first task with minimal steps.

**Tasks**:
- [x] Rewrite Quick Start flow
- [x] Document skills and ROADMAP format

### ~~BUG-4~~: Fix marketplace source path ('.' vs './') (✅ DONE)
**Priority**: P1
**Status**: ✅ DONE (2026-02-24)

Marketplace install was broken due to an incorrect relative source path.

**Tasks**:
- [x] Change `.` to `./` in marketplace source config

### ~~TASK-5~~: Add and iterate on README cover image (✅ DONE)
**Priority**: P3
**Status**: ✅ DONE (2026-07-01)

Added a cover image to the README and iterated on it across several passes (branding update, link fix, final crop fix).

**Tasks**:
- [x] Add initial cover image to README
- [x] Update cover image to waypoint branding
- [x] Fix cover image link and rendering

### ~~TASK-6~~: Smarter subtask completion with user verification (✅ DONE)
**Priority**: P1
**Status**: ✅ DONE (2026-06-30)

Improved the `done` skill so it verifies each subtask individually (test-covered or user-confirmed) before marking a task complete, instead of assuming completion.

**Tasks**:
- [x] Interview user for unchecked subtasks not covered by tests
- [x] Block moving a task to Completed while any subtask is unchecked

### ~~TASK-7~~: Ignore local Claude files (gitignore) (✅ DONE)
**Priority**: P3
**Status**: ✅ DONE (2026-06-30)

Excluded local Claude Code config/session files from version control.

**Tasks**:
- [x] Add local Claude files to .gitignore

### ~~TASK-8~~: Rebrand master-plan → waypoint (✅ DONE)
**Priority**: P1
**Status**: ✅ DONE (2026-06-30)

Renamed the plugin from master-plan to waypoint: repo/plugin metadata, the `task` skill renamed to `add`, `MASTER_PLAN.md` renamed to `ROADMAP.md`, README tagline added, and attribution to the original project added.

**Tasks**:
- [x] Rename plugin and file format (MASTER_PLAN.md → ROADMAP.md)
- [x] Rename `:task` skill to `:add`
- [x] Rebrand to jcbmrrs/waypoint, add attribution to original project
- [x] Add tagline to README

### ~~BUG-9~~: Remove stale master-plan references from done skill report (✅ DONE)
**Priority**: P2
**Status**: ✅ DONE (2026-06-30)

Cleaned up leftover "master-plan" wording in the `done` skill's completion report that survived the rebrand.

**Tasks**:
- [x] Update done skill's report text to waypoint naming
