" Title: neovim/init.vim
" Author: Liam Timms

" TODO: add file type checking so that different settings are loaded for python, latex or anything else I end up doing.
if exists('g:vscode')
" empty for now to avoid crashes
else
" ====== Vim-plug Install =======
" taken from:
" raw.githubusercontent.com/fisadev/fisa-nvim-config/master/init.vim
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ======== Plugin Installs =========
" specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

    " Speed up lua even more
    Plug 'lewis6991/impatient.nvim'

    " extra lua functions required by some other plugins
    Plug 'nvim-lua/plenary.nvim'
    Plug 'dstein64/vim-startuptime'

    " Indentation Guides:
    Plug 'lukas-reineke/indent-blankline.nvim'

    " explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " COC:
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Wiki:
    " this plug allows you to edit a wiki in vim
    Plug 'vimwiki/vimwiki'

    " Copilot:
    Plug 'github/copilot.vim'

    " Linter:
    " code linter
    Plug 'dense-analysis/ale'

    " Autogenerated documentation
    Plug 'danymat/neogen'

    " Bacon rust compiler linter
    Plug 'Canop/nvim-bacon'

    " Temp igor pro
    Plug 't-b/igor-pro-vim'

    " Tags:
    " tag bar to show variables and functions from ctags
    " Plug 'majutsushi/tagbar'

    " Statusline:
    Plug 'nvim-lualine/lualine.nvim'
    " If you want to have icons in your statusline choose one of these
    Plug 'kyazdani42/nvim-web-devicons'

    " Git:
    " git integration
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'

    " Godly TPope:
    " easier parenthesis, etc.
    " Plug 'tpope/vim-surround'
    " session saving
    Plug 'tpope/vim-obsession'
    " easier commenting
    " Plug 'tpope/vim-commentary'

    " Comments:
    Plug 'numToStr/Comment.nvim'

    " FZF:
    " powerful functionality from fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " Plug 'junegunn/fzf.vim'
    Plug 'ibhagwan/fzf-lua'

    " Align:
    " easier table formatting?
    " Plug 'junegunn/vim-easy-align'

    " Prose:
    " replaced by prose mode function defined at the bottom of this
    Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

    " Aesthetic:
    " themes
    Plug 'marko-cerovac/material.nvim'
    " Plug 'liamtimms/dracula.nvim'
    " Using Vim-Plug:
    Plug 'Mofiqul/dracula.nvim'
    " start screen
    " Plug 'goolord/alpha-nvim'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

    Plug 'liamtimms/prosemode.nvim'

    " LaTeX:
    " this plug contains a bunch of LaTeX support stuff
    Plug 'lervag/vimtex', { 'for': 'tex' }
    " this plug allows a live preview of LaTeX
    " Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

    " Snippets:
    " this plug provides snippet engine support
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine.
    Plug 'honza/vim-snippets'

    " easier f movement
    Plug 'unblevable/quick-scope'       " Plug

    " TMUX:
    " tmux-vim integration
    Plug 'christoomey/vim-tmux-navigator'

    " Treesitter:
    " k i s s i n g
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Undotree:
    Plug 'mbbill/undotree'

    " Firenvim:
    " browser embedding of full nvim
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

lua require('impatient')

" Install plugins on new install:
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ======== Settings =========
" slowly moving to lua
luafile $CUSTOM_CONFIG_HOME/nvim/basic_settings.lua
luafile $CUSTOM_CONFIG_HOME/nvim/plug_lua_settings.lua
luafile $CUSTOM_CONFIG_HOME/nvim/coc_settings.lua
" vimscript plugin settings
" source $CUSTOM_CONFIG_HOME/nvim/coc_settings.vim
source $CUSTOM_CONFIG_HOME/nvim/plug_settings.vim

" Find out syntax stack under cursor for adding it to color scheme
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map ga :call SynStack()<CR>

" Firenvim settings to determine which way we go:
let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }


if exists('g:started_by_firenvim')
  let g:material_style = "darker"
  colorscheme material
  autocmd BufNew,BufEnter *.py execute "silent! CocDisable"
  autocmd BufNew,BufEnter *.txt execute "ProseOn"
  set laststatus=0
  set showtabline=0
else
  let g:dracula_transparent_bg = v:true
  colorscheme dracula
  " colorscheme material
  set laststatus=3
endif
endif

" if exists('g:vscode')
"     imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
"     
" else
"     " ordinary Neovim
" endif
"
