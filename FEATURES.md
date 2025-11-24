# Complete Feature List

Everything this skill can do, in one place.

## Core Automation

### 1. One-Command Git Workflow
```bash
bash scripts/smart_commit.sh
```
Replaces:
```bash
git add .
git commit -m "feat: update files"
git push
```

### 2. Auto-Detect Everything
- ✅ No git? → Initializes it
- ✅ No remote? → Creates GitHub repo
- ✅ New branch? → Pushes with `-u` flag
- ✅ Existing branch? → Just pushes
- ✅ No changes? → Exits gracefully

### 3. Branch-Aware Pushing
**Pushes to whatever branch you're currently on:**
- On `main` → Pushes to `origin/main`
- On `feature-x` → Pushes to `origin/feature-x`
- On `bugfix-login` → Pushes to `origin/bugfix-login`

**How it works:**
```bash
git rev-parse --abbrev-ref HEAD  # Gets current branch
git push origin $CURRENT_BRANCH   # Pushes to that branch
```

**Smart upstream tracking:**
- Branch exists on remote → `git push`
- New branch → `git push -u origin $BRANCH` (sets upstream)

## Commit Message Generation

### 4. Auto-Generated Conventional Commits

Analyzes your changes to create proper conventional commit messages.

**Commit Types (Auto-Detected):**

| Type | Trigger | Example |
|------|---------|---------|
| `feat:` | Default for code changes | `feat: update 3 file(s)` |
| `fix:` | Diff contains "fix" or "bug" | `fix: resolve login issue` |
| `docs:` | .md, .txt, .rst files | `docs: update 2 file(s)` |
| `test:` | Filename contains "test" | `test: update 1 file(s)` |
| `chore:` | package.json, requirements.txt | `chore: update dependencies` |
| `refactor:` | Diff contains "refactor" | `refactor: update 1 file(s)` |

**Scope Detection (Auto-Extracted from directories):**

| Directory | Result |
|-----------|--------|
| `plugin/file.js` | `feat(plugin): update 1 file(s)` |
| `skill/docs.md` | `docs(skill): update 1 file(s)` |
| `agent/test.py` | `test(agent): update 1 file(s)` |
| `auth/login.ts` | `feat(auth): update 1 file(s)` |
| Root files | `feat: update 2 file(s)` |

### 5. Custom Commit Messages

Override auto-generation:
```bash
bash scripts/smart_commit.sh "fix: resolve authentication bug"
bash scripts/smart_commit.sh "feat(api): add new endpoint"
```

### 6. Claude Code Attribution

Every commit includes:
```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Repository Management

### 7. Initialize Git Repository
```bash
# No .git folder? Runs automatically:
git init
```

### 8. Create GitHub Repository

Uses GitHub CLI to create repos:
```bash
gh repo create [name] --public/--private --source=. --remote=origin
```

**Features:**
- ✅ Prompts for public/private
- ✅ Uses directory name as default
- ✅ Accepts custom name
- ✅ Sets up remote automatically

**Usage:**
```bash
# Auto-named (uses directory name)
bash scripts/init_and_push.sh

# Custom name
bash scripts/init_and_push.sh my-awesome-project
```

### 9. Remote Configuration
- ✅ Checks if `origin` remote exists
- ✅ Creates GitHub repo if missing
- ✅ Sets remote URL automatically

## Smart Behaviors

### 10. No Changes Detection
```bash
⚠ No changes to commit
# Exits gracefully, no error
```

### 11. New Branch Handling
First push to new branch:
```bash
git push -u origin feature-new
⚠ Create PR: https://github.com/user/repo/pull/new/feature-new
```

Shows PR creation link for GitHub repos!

### 12. Diff Statistics
After successful push:
```
 2 files changed, 47 insertions(+), 3 deletions(-)
```

### 13. Colored Output
- 🟢 Green → Info/success
- 🟡 Yellow → Warnings
- 🔴 Red → Errors
- 🔵 Blue → Step indicators

### 14. Error Handling
- `set -e` - Exits on any command failure
- Clear error messages
- Non-zero exit codes on failure

## Claude Code Integration

### 15. Slash Commands

**`/push`** - Save and push changes
```
/push
→ Current branch: main
→ Staging all changes...
→ Generated commit message: feat: update 2 file(s)
✅ Done!
```

**`/new-repo`** - Create new repository
```
/new-repo
What should we name the repository? my-project
→ Creating GitHub repository: my-project
✅ Done!
```

### 16. Natural Language Triggers

Skill auto-activates when you say:
- "push my changes"
- "save to github"
- "commit and push"
- "create a new repository"
- "backup my work"
- "push this"
- "save my changes"

### 17. Skill Auto-Activation

When installed in `.claude/skills/`, Claude automatically:
- Detects when you want to push
- Runs the appropriate script
- Handles everything end-to-end

## File Analysis

### 18. Staged File Analysis
```bash
git diff --cached --name-only  # Lists changed files
git diff --cached --stat       # Shows statistics
```

Used to:
- Determine commit type
- Extract scope
- Generate description
- Count files changed

### 19. Pattern Matching

Checks for:
- File extensions (`.md`, `.txt`, `.py`, etc.)
- Directory names (`plugin/`, `test/`, etc.)
- Diff content (`fix`, `refactor`, etc.)
- Dependency files (`package.json`, etc.)

## What It Doesn't Do

For transparency, here's what's NOT included:

❌ **Branch switching** - Use current branch only
❌ **Pull/fetch** - Doesn't sync before push
❌ **Merge conflicts** - Won't resolve
❌ **Interactive staging** - Always `git add .`
❌ **Commit amending** - New commits only
❌ **Rebase/squash** - Linear history
❌ **Multiple remotes** - `origin` only
❌ **Submodules** - Not handled
❌ **Git hooks** - Bypasses them
❌ **Force push** - Never uses `-f`

## Use Cases by User Type

### Engineers
- ⚡ **Speed:** One command instead of three
- 📝 **Lazy messaging:** Auto-generated conventional commits
- 🔄 **Consistency:** Same format every time
- 🚀 **Quick prototyping:** Fast iteration on feature branches

### Non-Engineers
- 🎯 **Simple:** No git commands to learn
- 💬 **Natural:** "Save my changes" just works
- 🆘 **Safe:** Auto-detects and fixes setup
- 📚 **Educational:** See what git does behind the scenes

### Teams
- 📐 **Standards:** Enforced conventional commits
- 🎓 **Onboarding:** New members just run one script
- 🤖 **CI/CD:** Same script in automation
- 📊 **Changelogs:** Easy to auto-generate from history

### Solo Developers
- 🏃 **Faster:** Save time on repetitive tasks
- 🧠 **Less thinking:** Auto commit messages
- 📦 **Portable:** Share workflow as code
- 🔧 **Customizable:** Edit scripts as needed

## Requirements

### Must Have
- ✅ Git installed
- ✅ GitHub CLI (`gh`) for creating repos
- ✅ GitHub account
- ✅ Authentication set up (`gh auth login`)

### Optional
- Claude Code (for skill integration)
- Existing git repository (or we create one)
- Remote configured (or we create one)

## Summary

**Total Features: 19**
- 9 core automation features
- 4 commit message features
- 3 repository management features
- 3 Claude Code integration features

**One script. Complete workflow. Any branch. Engineers and non-engineers.**
