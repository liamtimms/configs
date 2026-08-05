# Neovim Keymaps Reference

**Leader key: `Space`**

## Navigation

| Key | Description | Source |
|-----|-------------|--------|
| `Ctrl-h/j/k/l` | Navigate between splits | keymaps.lua |
| `Ctrl-Up/Down` | Resize split vertically (±2) | keymaps.lua |
| `Ctrl-Left/Right` | Resize split horizontally (±2) | keymaps.lua |
| `Shift-l` | Next buffer (bufferline) | keymaps.lua |
| `Shift-h` | Previous buffer (bufferline) | keymaps.lua |
| `<` / `>` (visual) | Indent/dedent and stay in visual mode | keymaps.lua |

## LSP

| Key | Description | Source |
|-----|-------------|--------|
| `gd` | Go to definition | lsp.lua |
| `gy` | Go to type definition | lsp.lua |
| `gi` | Go to implementation | lsp.lua |
| `gr` | Find references | lsp.lua |
| `K` | Hover documentation | lsp.lua |
| `Space a` | Code action (normal & visual) | lsp.lua |
| `Space rn` | Rename symbol | lsp.lua |
| `[g` | Previous diagnostic | lsp.lua |
| `]g` | Next diagnostic | lsp.lua |
| `Space e` | Show diagnostic float | lsp.lua |
| `\a` | Diagnostics list (loclist) | lsp.lua |
| `\o` | Document symbols (fzf-lua) | lsp.lua |
| `\s` | Workspace symbols (fzf-lua) | lsp.lua |

## Completion & Snippets (nvim-cmp + LuaSnip)

| Key | Description | Source |
|-----|-------------|--------|
| `Ctrl-Space` | Trigger completion | lsp.lua |
| `Ctrl-e` | Abort completion | lsp.lua |
| `CR` | Confirm selection | lsp.lua |
| `Tab` | Next item / expand or jump snippet | lsp.lua |
| `Shift-Tab` | Previous item / jump snippet backward | lsp.lua |

## Fuzzy Finding (fzf-lua)

| Key | Description | Source |
|-----|-------------|--------|
| `Space ff` | Find files | editor.lua |
| `Space fb` | Find buffers | editor.lua |
| `Space fg` | Live grep | editor.lua |

## File Explorer (nvim-tree)

| Key | Description | Source |
|-----|-------------|--------|
| `Space e` | Toggle file explorer | editor.lua |

> **Note:** `Space e` is mapped to both the diagnostic float (LSP-attached buffers) and nvim-tree toggle. The LSP mapping is buffer-local and takes precedence when an LSP is attached.

## Git (fugitive)

| Key | Description | Source |
|-----|-------------|--------|
| `Space gw` | Git write (stage current file) | misc.lua |
| `Space gc` | Git commit | misc.lua |
| `Space gp` | Git push | misc.lua |
| `Space gpl` | Git pull | misc.lua |
| `Space gd` | Git vertical diff split | misc.lua |

## Formatting & Linting

| Key | Description | Source |
|-----|-------------|--------|
| `Space af` | Format buffer (conform.nvim) | misc.lua |
| `Space al` | Trigger linting (nvim-lint) | misc.lua |

## Copilot

| Key | Description | Source |
|-----|-------------|--------|
| `Space ce` | Enable Copilot | misc.lua |
| `Space cd` | Disable Copilot | misc.lua |
| `Space cp` | Open Copilot panel | misc.lua |
| `Ctrl-j` (insert) | Accept Copilot suggestion | misc.lua |

## Toggles

| Key | Description | Source |
|-----|-------------|--------|
| `Space id` | Toggle LSP diagnostics visibility | keymaps.lua |
| `Space ih` | Toggle inlay hints (buffer) | lsp.lua |
| `Space ut` | Toggle undotree | editor.lua |

## Writing

| Key | Description | Source |
|-----|-------------|--------|
| `Space wf` | Follow wiki link (vimwiki) | writing.lua |
| `Space ww` | Open wiki index (vimwiki) | writing.lua |
| `Space wt` | Open wiki index in new tab (vimwiki) | writing.lua |
| `Space wi` | Open diary index (vimwiki) | writing.lua |
| `Space w Space w` | Open today's diary note (vimwiki) | writing.lua |
| `Space w Space t` | Open today's diary note in new tab (vimwiki) | writing.lua |
| `Space w Space y` | Open yesterday's diary note (vimwiki) | writing.lua |
| `Space w Space m` | Open tomorrow's diary note (vimwiki) | writing.lua |
| `Space w Space i` | Regenerate diary index links (vimwiki) | writing.lua |
| `Space ng` | Generate documentation (neogen) | writing.lua |

## Miscellaneous

| Key | Description | Source |
|-----|-------------|--------|
| `ga` | Show syntax highlight stack under cursor | keymaps.lua |
