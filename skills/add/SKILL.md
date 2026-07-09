---
name: add
description: Add a new waypoint (task) to ROADMAP.md with auto-generated sequential IDs. Supports TASK, BUG, FEATURE, and INQUIRY types. Triggers on "/add", "add task", "new task", "create task", "track this".
---

# Add Waypoint

Quickly add new waypoints (tasks) to ROADMAP.md with automatic sequential ID generation.

## Triggers

- `/waypoint:add` - Main command
- "add task", "new task", "create task", "track this", "log a bug"

## Workflow

### Step 1: Resolve ROADMAP.md Location

Check for a waypoint config file at `.claude/waypoint.json`:

```bash
cat .claude/waypoint.json 2>/dev/null
```

If it exists and has a `"roadmap_path"` key, use that exact path as the plan file for the rest of this workflow (referred to as `ROADMAP.md` below) — skip the search order.

**If no config file (or no `roadmap_path` key)**, search for the plan file in order:
1. `docs/ROADMAP.md`
2. `ROADMAP.md`
3. `roadmap.md`
4. `docs/roadmap.md`

**If not found anywhere**: Ask the user (via `AskUserQuestion`) where they'd like to keep their plan file:
- `docs/ROADMAP.md` (Recommended) — default location
- Custom path — let the user type one, e.g. `.docs/ROADMAP.md` or `notes/PLAN.md`

If the user picks a custom path, write it to `.claude/waypoint.json` (creating the file/directory if needed):
```json
{ "roadmap_path": "[chosen path]" }
```
Then create the plan file at that path using the template structure (see "Initial Setup" section below), creating parent directories as needed.

### Step 2: Generate Next Task ID

Read the ROADMAP.md file and find all existing task IDs:

1. Scan for all occurrences matching `(TASK|BUG|FEATURE|ROAD|IDEA|ISSUE|INQUIRY)-(\d+)`
2. Extract the numeric part from each match
3. Find the highest number
4. Next ID = highest + 1

**CRITICAL**: IDs are sequential across ALL types. If TASK-42 and BUG-43 exist, the next ID is 44 regardless of type.

**Immediately output to user:**
```
Using task number: [ID]
```

This must happen BEFORE asking any questions.

### Step 3: Gather Task Information

Use `AskUserQuestion` to collect:

1. **Task Type** (header: "Type")
   - `TASK` — New feature or improvement
   - `BUG` — Bug fix
   - `FEATURE` — Major new feature
   - `INQUIRY` — Investigation (not a fix, just understanding something)

2. **Priority** (header: "Priority")
   - `P0` — Critical / Blocker
   - `P1` — High priority
   - `P2` — Medium priority (Recommended)
   - `P3` — Low priority / Backlog

Then ask in plain text: "What's the task title? (Keep it concise, under 50 chars)"

Optionally ask: "Any additional description? (Or just press enter to skip)"

### Step 4: Add to ROADMAP.md

#### 4a. Add to Roadmap Table (if one exists)

Look for a markdown table with task IDs. Insert a new row:

```markdown
| **[TYPE]-[ID]** | **[Title]** | **[Priority]** | PLANNED | - |
```

#### 4b. Add Detailed Section

Add a new `###` section at the appropriate place (typically at the end of the active work area, before completed tasks):

```markdown
### [TYPE]-[ID]: [Title] (PLANNED)
**Priority**: [Priority]
**Status**: PLANNED (YYYY-MM-DD)

[Description if provided]

**Tasks**:
- [ ] [First step — infer from context or ask user]
```

For P0/P1 tasks, add a note that this is high priority.

### Step 5: Confirm

Output to user:
```
Task added to ROADMAP.md:
- **ID**: [TYPE]-[ID]
- **Title**: [Title]
- **Priority**: [Priority]
- **Status**: PLANNED

Use `/waypoint:next` to start working on it, or `/waypoint:done` when complete.
```

## Initial Setup

If no ROADMAP.md exists, create it at the resolved path (`.claude/waypoint.json`'s `roadmap_path` if set, otherwise `docs/ROADMAP.md`) with this structure:

```markdown
# ROADMAP

> Project task tracking and roadmap.

## Roadmap

| ID | Title | Priority | Status | Dependencies |
|----|-------|----------|--------|--------------|

## Active Work

<!-- New task sections are added here -->

## Completed

<!-- Done tasks are moved here -->
```

Also create any parent directories that don't exist yet.

## Custom Location Config

`.claude/waypoint.json` lets a project pin its plan file to any path, e.g. to keep it out of a synced notes vault:

```json
{ "roadmap_path": ".docs/ROADMAP.md" }
```

All four waypoint skills (`add`, `next`, `save`, `done`) check this file first. It's a plain JSON file — safe to commit so the whole team shares the same location.

## ID Format Reference

| Prefix | Usage |
|--------|-------|
| `TASK-XXX` | Features and improvements |
| `BUG-XXX` | Bug fixes |
| `FEATURE-XXX` | Major features |
| `ROAD-XXX` | Roadmap items |
| `IDEA-XXX` | Ideas for later |
| `ISSUE-XXX` | Known issues |
| `INQUIRY-XXX` | Investigations |

## Important Rules

1. **NEVER reuse existing task IDs** — Always scan the file first
2. **IDs are global** — Sequential across all types (TASK, BUG, etc.)
3. **Use strikethrough** (`~~ID~~`) only when marking tasks DONE
4. **Keep titles concise** — Under 50 characters
5. **P0 tasks** should always get an immediate detailed section
