# Shortcuts

Current keybindings across kitty, tmux, and Neovim (LazyVim), as actually configured on the `macos` branch. Verified against the live config, not recalled from memory — pulled from kitty's own default definitions, tmux's plugin docs, and a real `nvim --headless` keymap dump.

This is a reference, not a design doc — see [Deferred](README.md#deferred) in the README for planned keybinding work.

**Leader key (Neovim): `Space`** — press it and wait to open which-key, which shows every mapping live and is more current than this file will ever be. `<leader>` below means Space.

## Kitty (terminal)

No custom binds — these are kitty's own defaults. `kitty_mod` = `Ctrl+Shift` (works cross-platform); macOS also layers native `Cmd`-based equivalents on top, both work.

| Action | macOS (Cmd) | kitty_mod |
|---|---|---|
| New OS window | `Cmd+Enter` | `Ctrl+Shift+Enter` |
| Close window | `Shift+Cmd+D` | `Ctrl+Shift+W` |
| New tab | `Cmd+T` | `Ctrl+Shift+T` |
| Close tab | `Cmd+W` | `Ctrl+Shift+Q` |
| Next / prev tab | `Shift+Cmd+]` / `Shift+Cmd+[` | `Ctrl+Shift+Right` / `Ctrl+Shift+Left` |
| Next / prev kitty split | — | `Ctrl+Shift+]` / `Ctrl+Shift+[` |
| Increase / decrease font size | `Cmd+=` / `Cmd+-` | `Ctrl+Shift+=` / `Ctrl+Shift+-` |
| Reset font size | `Cmd+0` | `Ctrl+Shift+Backspace` |
| Copy / paste | — | `Ctrl+Shift+C` / `Ctrl+Shift+V` (`Cmd+V` also works) |
| Show scrollback in pager | — | `Ctrl+Shift+H` |
| Search scrollback | `Cmd+F` | — |
| Toggle fullscreen | `Ctrl+Cmd+F` | `Ctrl+Shift+F11` |
| Edit / reload kitty.conf | `Cmd+,` / `Ctrl+Cmd+,` | — |

We don't use kitty's own window splits/layouts — tmux owns that (see below).

## tmux

**Prefix: `Ctrl+Space`** (not the tmux default `Ctrl+b`). ⚠️ collides with macOS's default "Select next input source" shortcut — see [README known gotchas](README.md#known-macos-gotchas).

| Action | Keys |
|---|---|
| Send prefix to nested session | `prefix Ctrl+Space` |
| Reload config | `prefix r` |
| Split horizontal / vertical | `prefix \|` / `prefix -` |
| New window (in cwd) | `prefix c` |
| New window via sessionizer (`t` script) | `prefix F` |
| Jump to `~/Documents/Codes` session | `prefix D` |
| Detach (session keeps running in background) | `prefix Q` — **not** the tmux-default `prefix d`, which is reassigned below |
| Switch pane (vim-aware — falls through to nvim splits if focused pane is running vim) | `Ctrl+h/j/k/l` (no prefix needed) |
| Switch pane (always tmux, repeatable) | `prefix h/j/k/l` |
| Switch window | `prefix C-h` / `prefix C-l` (repeatable), or `prefix n` / `prefix p` |
| Move window position | `prefix N` / `prefix P` |
| Last window / last session | `prefix Space` / `prefix ^` |
| Enter copy mode, start selection | `prefix [`, then `v` to select (vi-style) |
| Copy selection to system clipboard | `y` while selecting in copy mode (via tmux-yank) |
| Install / update plugins (tpm) | `prefix I` / `prefix U` |
| Save session layout | `prefix Ctrl+s` (tmux-resurrect) |
| Restore session layout | `prefix Ctrl+r` (tmux-resurrect) |
| Lazygit | `prefix g` |
| k9s | `prefix K` |
| Lazydocker | `prefix d` |

tmux-continuum auto-restores the last saved layout on tmux start — no keybind needed. The companion-tool binds above each open in a 90%-sized popup over the current pane, start in that pane's cwd, and close automatically on exit.

Resurrect's process-relaunch allowlist is extended with `claude` (`@resurrect-processes`), so a running Claude Code session in a pane gets relaunched (not just the empty pane layout) after a full tmux-server restart/reboot — on top of the default surviving plain detach/reattach with zero extra config either way.

## Neovim (LazyVim)

Only the highlights are listed here — press `<leader>` (Space) and wait for the full, live, searchable which-key menu.

### Windows & buffers
| Action | Keys |
|---|---|
| Move between splits | `Ctrl+h/j/k/l` |
| Resize splits | `Ctrl+Up/Down/Left/Right` |
| Prev / next buffer | `Shift+H` / `Shift+L`, or `[b` / `]b` |
| Delete buffer | `<leader>bd` |
| Split below / right | `<leader>-` / `<leader>\|` |
| Move line up/down | `Alt+j` / `Alt+k` (needs `macos_option_as_alt` in kitty) |

### Find & search (Snacks picker)
| Action | Keys |
|---|---|
| Find files (root dir) | `<leader><space>` or `<leader>ff` |
| Find files (cwd) | `<leader>fF` |
| Recent files | `<leader>fr` |
| File explorer | `<leader>e` |
| Live grep (root dir) | `<leader>/` or `<leader>sg` |
| Grep word/selection under cursor | `<leader>sw` |
| Buffers | `<leader>fb` or `<leader>,` |
| Search everything (`<leader>s...`) | `<leader>s` then wait — diagnostics, help, keymaps, marks, todo, undo history, etc. |

### LSP / code (once a language server is attached)
| Action | Keys |
|---|---|
| Go to definition / references | `gd` / `gr` |
| Go to implementation / type def / declaration | `gI` / `gy` / `gD` |
| Hover docs | `K` |
| Signature help | `gK` (normal), `Ctrl+k` (insert) |
| Code action | `<leader>ca` |
| Rename symbol | `<leader>cr` |
| Format buffer | `<leader>cf` |
| Line diagnostics | `<leader>cd` |
| Next / prev diagnostic | `]d` / `[d` |
| Next / prev error | `]e` / `[e` |

Applies to all attached servers, including the custom ones we added (`ansiblels`, `bashls`, plus the `lang.terraform`/`lang.docker`/`lang.yaml`/`lang.json` extras).

### Git
| Action | Keys |
|---|---|
| Lazygit (root dir) | `<leader>gg` |
| Git status / log / diff (pickers) | `<leader>gs` / `<leader>gl` / `<leader>gd` |
| Blame current line | `<leader>gb` |

### Custom additions (ported from the pre-LazyVim config)
These are ours, not LazyVim defaults — see `nvim/lua/config/keymaps.lua`.

| Action | Keys |
|---|---|
| Reselect visual selection after indent | `<` / `>` (in visual mode) |
| Yank without moving cursor | `y` (in visual mode) |
| Paste over selection without clobbering register | `p` (in visual mode) |
| Trailing `;` / `,` from insert mode | `;;` / `,,` |
| Clear search highlight | `<leader>k` |
| Prev / next buffer | `<leader>,` / `<leader>.` |
| Open file in OS default program | `<leader>x` |

### Remote & devops-specific
| Action | Keys / Command |
|---|---|
| Remote SSH session (remote-nvim.nvim) | `:RemoteStart` (no default keybind yet) |
