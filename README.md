# Git Made Simple

**Version control for non-engineers.** Save your work to GitHub without learning git commands.

Perfect for designers, writers, PMs, data scientists, researchers, and anyone who needs version control but doesn't want to become a git expert.

## Why This Exists

Git is powerful but intimidating:
```bash
git add .
git commit -m "???"  # What do I write?
git push             # Where? How?
```

This skill makes it simple:
```bash
/push
# Done! ✅
```

## Features

- 🎯 **No git knowledge needed** - Just type `/push` in Claude Code
- 🚀 **Auto-creates GitHub repos** - First time? We'll set it up
- 📝 **Auto-generates commit messages** - No need to think about format
- ⚡ **One command** - Replaces 5+ git commands
- 🤖 **Works with Claude Code** - Natural language or slash commands

## Quick Start (For Non-Engineers)

1. **One-time setup** (5 minutes):
   ```bash
   # Install GitHub CLI
   brew install gh

   # Login to GitHub
   gh auth login

   # Install this skill in Claude Code
   mkdir -p ~/.claude/skills/git-pushing
   # Copy the files (see Installation section)
   ```

2. **Every time you want to save your work:**
   - Open Claude Code in your project
   - Type: `/push`
   - Done! Your work is saved to GitHub ✅

That's it! No git commands to memorize.

## Slash Commands

Once installed, you can use these commands in Claude Code:

- **`/push`** - Save all changes and push to GitHub
  - First time? Creates the repository automatically
  - Already set up? Just saves your changes

- **`/new-repo`** - Create a new GitHub repository with a custom name
  - Claude will ask you what to name it
  - Sets everything up for you

## Installation

### 1. Install GitHub CLI (Required for new repos)

```bash
# macOS
brew install gh

# Authenticate with GitHub
gh auth login
```

Follow the prompts to authenticate with your GitHub account.

### 2. Install the Skill in Claude Code

**Recommended: Personal installation (works in all your projects)**

```bash
# Create the skills directory
mkdir -p ~/.claude/skills/git-pushing

# Copy all the files
cp SKILL.md ~/.claude/skills/git-pushing/
cp -r scripts ~/.claude/skills/git-pushing/
cp -r .claude/commands ~/.claude/skills/git-pushing/

# Make scripts executable
chmod +x ~/.claude/skills/git-pushing/scripts/*.sh
```

**Alternative: Project-specific (only works in this project)**
```bash
mkdir -p .claude/skills/git-pushing
cp SKILL.md .claude/skills/git-pushing/
cp -r scripts .claude/skills/git-pushing/
cp -r .claude/commands .claude/skills/git-pushing/
chmod +x .claude/skills/git-pushing/scripts/*.sh
```

**What gets installed:**
- ✅ Skill (teaches Claude when to help with git)
- ✅ Scripts (does the actual git work)
- ✅ Slash commands (`/push` and `/new-repo`)

## Usage

### For Non-Engineers (Easiest!)

Just use the slash commands in Claude Code:

**Save your work:**
```
/push
```

**Create a new repository:**
```
/new-repo
```

That's it! No git commands needed.

### Alternative: Talk to Claude

You can also just ask Claude naturally:
- "Save my changes to GitHub"
- "Push these changes"
- "Create a new repository for this project"
- "Back up my work"

Claude will automatically run the right commands.

### For Advanced Users: Direct Commands

If you prefer running commands directly:

```bash
# Save and push changes
bash scripts/smart_commit.sh

# Create new repo with custom name
bash scripts/init_and_push.sh my-project-name
```

### What Happens Automatically

The scripts are smart and check your project state:

1. **No git initialized?**
   - Shows: `⚠ No git repository found`
   - Shows: `▸ Creating new repository...`
   - Runs `git init` and creates GitHub repo

2. **No remote configured?**
   - Shows: `⚠ No remote repository configured`
   - Shows: `▸ Creating new repository...`
   - Creates GitHub repo and sets up remote

3. **Everything already set up?**
   - Shows: `→ Current branch: main`
   - Commits and pushes normally

So whether it's a brand new project or existing repo, just run the same command!

### Custom Options

**With custom message:**
```bash
bash scripts/smart_commit.sh "feat: add user authentication"
```

**With custom repo name:**
```bash
bash scripts/init_and_push.sh my-awesome-project
```

**Both:**
```bash
bash scripts/init_and_push.sh my-project "feat: initial implementation"
```

## Conventional Commit Types

The skill auto-detects commit types based on file changes:

- `feat:` - New features (default)
- `fix:` - Bug fixes (detects "fix" or "bug" in diff)
- `docs:` - Documentation (.md, .txt, .rst files)
- `test:` - Test files (files with "test" in name)
- `chore:` - Dependencies (package.json, requirements.txt, etc.)
- `refactor:` - Refactoring (detects "refactor" in diff)

## Scope Detection

Automatically adds scope based on file paths:

- Files in `plugin/` → `feat(plugin):`
- Files in `skill/` → `feat(skill):`
- Files in `agent/` → `feat(agent):`
- First directory name → `feat(dirname):`

## Examples

### Example 1: Brand New Project (Auto-Detected)

```bash
$ cd my-new-project
$ bash scripts/smart_commit.sh

⚠ No git repository found
▸ Creating new repository...
→ Git not initialized in this directory
→ Initializing git repository...
→ Git initialized!
▸ No remote repository configured
→ Creating GitHub repository: my-new-project
Make repository public or private? [public/private] (default: public): public
▸ Creating repository on GitHub...
→ Repository created successfully!
→ Remote set to: git@github.com:yourusername/my-new-project.git
→ Proceeding to initial commit and push...
→ Current branch: main
→ Staging all changes...
→ Generated commit message: feat: update 5 file(s)
→ Created commit: abc1234
→ Pushing to origin/main...
→ Successfully pushed new branch to origin/main

→ 🎉 Repository successfully created and pushed!
View at: https://github.com/yourusername/my-new-project
```

### Example 2: Existing Repo (Auto-Detected)

```bash
$ bash scripts/smart_commit.sh

→ Current branch: main
→ Staging all changes...
→ Generated commit message: feat(skill): update 2 file(s)
→ Created commit: def5678
→ Pushing to origin/main...
→ Successfully pushed to origin/main
 2 files changed, 47 insertions(+), 3 deletions(-)
```

### Example 3: Custom Message (Any Project State)

```bash
$ bash scripts/smart_commit.sh "fix: resolve authentication bug"

→ Current branch: feature-auth
→ Staging all changes...
→ Using provided message: fix: resolve authentication bug
→ Created commit: ghi9012
→ Pushing to origin/feature-auth...
→ Successfully pushed to origin/feature-auth
```

### Example 4: Explicit Repo Name (Advanced)

```bash
$ bash scripts/init_and_push.sh cool-project-name

→ Git not initialized in this directory
→ Initializing git repository...
→ Git initialized!
→ Creating GitHub repository: cool-project-name
...
```

## How to Trigger (Non-Engineers)

The skill auto-activates when you:

**Use slash commands:**
- `/push` - Save and upload your work
- `/new-repo` - Create a new repository

**Or just ask naturally:**
- "Save my changes to GitHub"
- "Back up my work"
- "Push these changes"
- "Create a new repository"
- "How do I save this to GitHub?"
- "I need version control"

## Requirements

- Git installed
- GitHub CLI (`gh`) for creating new repositories
- GitHub account
- SSH keys or HTTPS authentication configured

## Troubleshooting

### "GitHub CLI (gh) is not installed"
```bash
brew install gh
gh auth login
```

### "Not authenticated with GitHub"
```bash
gh auth login
```

### "Permission denied (publickey)"
Set up SSH keys:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub
# Add the output to https://github.com/settings/keys
```

### Script not executable
```bash
chmod +x scripts/*.sh
```

## How It Works

### smart_commit.sh (Main Entry Point)

This is the smart script you always call:

1. **Checks git status**
   - No `.git` folder? → Delegates to `init_and_push.sh`
   - No remote configured? → Delegates to `init_and_push.sh`
   - Everything ready? → Continues with commit

2. **Commits and pushes**
   - Stages all changes with `git add .`
   - Analyzes files and diffs to determine commit type
   - Detects scope from directory structure
   - Creates conventional commit with Claude Code footer
   - Pushes to remote (uses `-u` for new branches)
   - Shows PR link for GitHub repos

### init_and_push.sh (Auto-Called When Needed)

Only called when creating a new repository:

1. Runs `git init` if no `.git` folder
2. Creates GitHub repo via `gh` if no remote
3. Sets up remote origin
4. Calls back to `smart_commit.sh` to finish the job

**You rarely need to call this directly** - `smart_commit.sh` calls it automatically!

## License

MIT
