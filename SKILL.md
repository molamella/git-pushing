---
name: git-pushing
description: Automate git workflows - one command to stage, commit (with auto-generated conventional commits), and push to current branch. Creates repos if needed. For anyone wanting quick git workflows. Activates on "push changes", "save to github", "create repo", /push, /new-repo commands.
---

# Git Push Automation

One command to stage, commit with conventional messages, and push to your current branch. Creates GitHub repos automatically when needed.

**For everyone:** Engineers who want speed, non-engineers who want simplicity.

## When to Use

Automatically activate when the user:
- Wants to quickly push changes ("push this", "commit and push", "save to github")
- Uses `/push` or `/new-repo` slash commands
- Wants to create a new git repository ("create a repo", "new repository")
- Wants conventional commits without thinking ("just push with a good message")
- Is working on current branch and wants to push
- Needs to create a GitHub repo from scratch
- Asks about version control ("how do I save this?", "backup to github")

**Use cases:**
- **Engineers:** Quick workflow, no thinking about commit messages
- **Non-engineers:** Git without learning commands
- **Teams:** Consistent conventional commit format
- **Anyone:** Fast push to current branch

## Slash Commands (Easiest!)

User can type these commands directly:

### `/push`
Saves all changes and pushes to GitHub. If no repository exists, creates one automatically.

### `/new-repo`
Creates a new GitHub repository with a custom name.

## Workflow

When user wants to save/push their work, run:

```bash
bash scripts/smart_commit.sh
```

### What It Does Automatically

Think of it as a "Save to GitHub" button that:
1. **First time?** → Sets up everything (git + GitHub repo)
2. **Already set up?** → Just saves and uploads your changes

No git knowledge required!

### Behind the Scenes

The script is smart and checks:
1. **No .git folder?** → Shows "No git repository found" → Creates new repo
2. **No remote configured?** → Shows "No remote repository configured" → Creates new repo
3. **Everything set up?** → Commits and pushes normally

When creating a new repository, it will:
- Initialize git
- Create GitHub repository (prompts for public/private)
- Set up remote origin
- Commit and push changes

### Requirements

**One-time setup:**
- GitHub CLI: `brew install gh` (macOS) or see https://cli.github.com
- Authenticate: `gh auth login`

**Then you're done!** No need to learn git commands.

### For Custom Repository Names

If user wants to name their repository:

```bash
bash scripts/init_and_push.sh my-custom-repo-name
```

Or use the `/new-repo` slash command and ask them for the name.
