# dotfiles (macos branch)

Personal terminal setup: kitty + tmux + Neovim (LazyVim), oriented toward general coding and DevOps work (Kubernetes, Terraform, Ansible, CI/CD, SSH into servers).

This branch targets **macOS**. `main` is the old Linux/`packer.nvim` snapshot from 2023. Future `linux` / `windows-wsl` branches are planned - see [Portability](#portability-future-linux--windows-wsl-branches) below for what's already kept OS-agnostic to make that easier.

See [SHORTCUTS.md](SHORTCUTS.md) for the current keybinding reference across kitty, tmux, and Neovim.

## Install

```sh
./install
```

This runs `brew bundle --file=Brewfile` (installs everything below), then symlinks:

| Source | Target |
|---|---|
| `kitty/` | `~/.config/kitty` |
| `tmux/tmux.conf` | `~/.tmux.conf` |
| `nvim/` | `~/.config/nvim` |
| `scripts/t` | `~/.local/bin/t` |

First launch of `nvim` bootstraps `lazy.nvim` and installs plugins automatically. First launch of `tmux`, run `prefix + I` to install tmux plugins via tpm.

To remove everything: `./uninstall` (does not uninstall brew packages).

## Structure

```
kitty/kitty.conf     - terminal: font, theme, opacity, macOS Option-as-Alt fix
tmux/tmux.conf       - multiplexer: vi-mode, vim-aware pane nav, plugins
nvim/                - LazyVim config
scripts/t            - tmux session picker/creator (fzf-driven)
Brewfile             - macOS package list
```

## What's installed (Brewfile)

- **Core**: git, neovim, tmux, fzf, ripgrep, fd, node (needed by several LSP servers)
- **Terminal**: kitty
- **Companion DevOps TUIs** (standalone apps, *not* Neovim plugins - see [Why Neovim stays lean](#why-neovim-stays-lean)): `lazygit`, `k9s`, `lazydocker`
- **DevOps CLIs**: `kubectl`, `terraform`, `ansible`
- **Docker runtime**: not managed here - uses an existing Docker Desktop install. (Deliberately not adding Colima alongside it: both spin up their own VM and fight over the active `docker` CLI context; pick one runtime.)

Launch the TUIs manually for now (`lazygit`, `k9s`, `lazydocker` in any pane/tmux window). tmux popup bindings to launch them with a keystroke are a planned addition, not done yet.

## Why Neovim stays lean

DevOps tooling splits across three layers here, on purpose:

1. **Neovim**: only LSP/schema awareness for infra file types (Terraform, Docker, YAML/k8s manifests, JSON, Ansible, Bash) - editing only, no dashboards or embedded git UIs.
2. **tmux**: session multiplexing - persistent sessions across SSH drops, multi-pane workflows.
3. **Standalone TUIs**: `lazygit`/`k9s`/`lazydocker` run alongside Neovim as separate panes, not inside it.

## Extending Neovim

Base is [LazyVim](https://www.lazyvim.org/). Config lives in `nvim/lua/config/`, custom plugins in `nvim/lua/plugins/` (auto-loaded).

- **Toggle official LazyVim extras**: `:LazyExtras` inside nvim. Currently enabled explicitly in `nvim/lua/config/lazy.lua` (kept as explicit `import` lines rather than the interactively-generated `lazyvim.json`, so they're reproducible from a fresh clone):
  - `lang.terraform`, `lang.docker`, `lang.yaml` (ships SchemaStore - k8s manifests, GH Actions, etc.), `lang.json`
- **Add a language with no official extra** (pattern used for Ansible/Bash in `nvim/lua/plugins/devops-lsp.lua`):
  ```lua
  return {
    { "neovim/nvim-lspconfig", opts = { servers = { <lsp_name> = {} } } },
    { "williamboman/mason.nvim", opts = { ensure_installed = { "<mason-package-name>" } } },
  }
  ```
- **Add any other plugin**: drop a new file in `nvim/lua/plugins/`, return a standard lazy.nvim spec table.
- **Remote editing**: `nvim/lua/plugins/remote-nvim.lua` sets up [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim) for boxes you SSH into regularly (auto-bootstraps nvim + syncs this config there). For one-off/ad-hoc SSH boxes, don't bother - just install bare nvim there if you need to edit something.

## Extending tmux

Plugin manager is [tpm](https://github.com/tmux-plugins/tpm), bootstrapped at the bottom of `tmux/tmux.conf`.

- Add a plugin: `set -g @plugin '<repo>'` in the plugins block, then `prefix + I`.
- Currently installed: `tmux-sensible`, `tmux-yank` (clipboard), `tmux-resurrect` + `tmux-continuum` (session persistence across reboots/SSH drops).
- Existing keybindings (vi-mode, vim-aware `Ctrl+h/j/k/l` pane nav, window swap/cycle, the `t` sessionizer) are untouched - this pass didn't redesign bindings, see [Deferred](#deferred) below.

## Known macOS gotchas

- **Option key does nothing for Alt-binds by default.** Fixed via `macos_option_as_alt yes` in `kitty/kitty.conf` - without it, Alt+j/Alt+k (line move in nvim) and any tmux `M-` binds silently no-op.
- **tmux prefix `Ctrl+Space` collides with macOS's "Select next input source" shortcut.** If pressing the prefix switches your keyboard input source instead of reaching tmux, disable that shortcut: System Settings → Keyboard → Keyboard Shortcuts → Input Sources.

## Portability (future linux / windows-wsl branches)

Kept OS-agnostic on purpose so a future fork only needs to touch a small surface:

- `nvim/lua/config/keymaps.lua`'s `<Leader>x` (open file in default program) already branches on `vim.fn.has('mac')` / `has('unix')` / else, so it works unmodified on Linux/WSL too.
- The tmux clipboard bind uses `tmux-yank`, which auto-detects `pbcopy`/`xclip`/`wl-copy` per OS - no manual swap needed.
- What *will* need OS-specific handling on a new branch: `kitty.conf` (macOS-specific options like `macos_option_as_alt`), the `Brewfile` (swap for apt/pacman/scoop as appropriate), and re-verifying `install`'s symlink targets.

## Deferred

Not part of this pass, intentionally:
- New/redesigned keybindings and macros (next session)
- tmux popup launchers for lazygit/k9s/lazydocker
- Creating the `linux`/`windows-wsl` branches themselves
