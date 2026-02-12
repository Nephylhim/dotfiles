# Git worktree navigation functions
# Add these to your ~/.zshrc

# Helper function to find the main git repository root (not worktree root)
_git_root() {
    local git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
    [[ -z "$git_common_dir" ]] && return 1
    # git-common-dir points to .git in main repo
    cd "$git_common_dir/.." && pwd
}

# Navigate to worktree or main directory
za() {
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    cd "$root/.worktrees/za" || echo "Worktree za not found"
}

zb() {
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    cd "$root/.worktrees/zb" || echo "Worktree zb not found"
}

zc() {
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    cd "$root/.worktrees/zc" || echo "Worktree zc not found"
}

# Go back to main project (git root)
zz() {
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    cd "$root"
}

# List all worktrees
zwl() {
    git worktree list
}

# Create a new worktree in .worktrees/
zwc() {
    local name=$1
    local branch=$2
    [[ -z "$name" ]] && echo "Usage: zwc <name> <branch>" && return 1
    [[ -z "$branch" ]] && echo "Usage: zwc <name> <branch>" && return 1
    
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    
    mkdir -p "$root/.worktrees"
    git worktree add "$root/.worktrees/$name" "$branch"
}

# Remove a worktree
zwr() {
    local name=$1
    [[ -z "$name" ]] && echo "Usage: zwr <name>" && return 1
    
    local root=$(_git_root)
    [[ -z "$root" ]] && echo "Not in a git repository" && return 1
    
    git worktree remove "$root/.worktrees/$name"
}
