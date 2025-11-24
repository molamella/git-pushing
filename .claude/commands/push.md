Stage all changes, create a conventional commit message, and push to GitHub.

If no git repository exists, initialize one and create a new GitHub repository.

Run the smart commit script:

```bash
bash scripts/smart_commit.sh
```

The script will:
1. Check if git is initialized (if not, set it up)
2. Check if a remote repository exists (if not, create one on GitHub)
3. Stage all your changes
4. Analyze the files to create a meaningful commit message
5. Commit with a conventional format
6. Push to GitHub

You'll be prompted for:
- Repository visibility (public/private) if creating a new repo
- Confirmation before pushing

That's it! No need to know git commands.
