#!/bin/bash
# Initialize Git Repository and Push to Remote
# Handles git init, GitHub repo creation, and first push

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
info() { echo -e "${GREEN}→${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1" >&2; }
step() { echo -e "${BLUE}▸${NC} $1"; }

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Step 1: Check if git is initialized
if [ ! -d .git ]; then
    step "Git not initialized in this directory"
    info "Initializing git repository..."
    git init
    info "Git initialized!"
else
    info "Git repository already initialized"
fi

# Step 2: Check if remote exists
if git remote get-url origin >/dev/null 2>&1; then
    REMOTE_URL=$(git remote get-url origin)
    info "Remote already exists: $REMOTE_URL"

    # Skip to commit and push
    info "Proceeding to commit and push..."
    bash "$SCRIPT_DIR/smart_commit.sh" "$@"
    exit 0
fi

# Step 3: No remote exists - need to create GitHub repo
step "No remote repository configured"

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    error "GitHub CLI (gh) is not installed"
    echo ""
    echo "Install it with:"
    echo "  macOS:   brew install gh"
    echo "  Linux:   See https://github.com/cli/cli#installation"
    echo ""
    echo "After installing, run: gh auth login"
    exit 1
fi

# Check if authenticated with GitHub
if ! gh auth status >/dev/null 2>&1; then
    error "Not authenticated with GitHub"
    echo ""
    echo "Run: gh auth login"
    echo ""
    exit 1
fi

# Get repository name (default to current directory name)
DEFAULT_REPO_NAME=$(basename "$PWD")

if [ -n "$1" ] && [[ "$1" != *":"* ]]; then
    # First argument is repo name if it doesn't look like a commit message
    REPO_NAME="$1"
    shift  # Remove repo name from arguments
else
    REPO_NAME="$DEFAULT_REPO_NAME"
fi

info "Creating GitHub repository: $REPO_NAME"

# Default to public (no prompt)
VISIBILITY_FLAG="--public"

step "Creating repository on GitHub..."
if gh repo create "$REPO_NAME" $VISIBILITY_FLAG --source=. --remote=origin; then
    info "Repository created successfully!"

    # Get the remote URL
    REMOTE_URL=$(git remote get-url origin)
    info "Remote set to: $REMOTE_URL"
else
    error "Failed to create repository"
    exit 1
fi

# Step 4: Now commit and push using smart_commit.sh
info "Proceeding to initial commit and push..."
bash "$SCRIPT_DIR/smart_commit.sh" "$@"

# Show success message with repo URL
echo ""
info "🎉 Repository successfully created and pushed!"
if echo "$REMOTE_URL" | grep -q "github.com"; then
    REPO=$(echo "$REMOTE_URL" | sed -E 's/.*github\.com[:/](.*)\.git/\1/')
    echo -e "${BLUE}View at:${NC} https://github.com/$REPO"
fi

exit 0
