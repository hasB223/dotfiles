# macOS package list for this dotfiles branch.
# Install everything:   brew bundle
# Check without installing: brew bundle check

# --- core ---
brew "git"
brew "neovim"
brew "tmux"
brew "fzf"
brew "ripgrep"
brew "fd"
brew "node" # required by several Mason-installed LSP servers (yaml/bash/docker)

# --- terminal ---
cask "kitty"

# --- git / devops TUIs (companion tools, launched standalone - not nvim plugins) ---
brew "lazygit"
brew "k9s"
brew "lazydocker"

# --- devops CLIs ---
brew "kubectl"
brew "ansible"

# terraform was pulled from homebrew-core after HashiCorp's BSL license
# change - it now lives in HashiCorp's own tap.
tap "hashicorp/tap"
brew "hashicorp/tap/terraform"

# Docker runtime: using existing Docker Desktop install, not managed here.
# (Don't add Colima alongside it - both spin up their own VM and fight over
# the active `docker` CLI context; pick one runtime, not both.)
