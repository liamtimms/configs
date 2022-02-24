" Title: neovim .init.vim file
" Author: Liam Timms
" OS: Arch Linux

" TODO: add file type checking so that different settings are loaded for python, latex or anything else I end up doing.
"
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

" Autocomplete:
" " deoplete (neovim autocompletion)
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" " jedi (python completion)
" Plug 'davidhalter/jedi-vim'
" " deoplete-jedi (connects them)
" Plug 'deoplete-plugins/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
" COC:
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linter:
" code linter
Plug 'dense-analysis/ale'

" Tags:
" tag bar to show variables and functions from ctags
Plug 'majutsushi/tagbar'

" Statusline:
" airline and associated theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git:
" git integration that works wiht airline
Plug 'tpope/vim-fugitive'

" Godly TPope:
" easier parenthesis, etc.
Plug 'tpope/vim-surround'
" session saving
Plug 'tpope/vim-obsession'
" easier commenting
Plug 'tpope/vim-commentary'

" FZF:
" powerful functionality from fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Align:
" easier table formatting?
Plug 'junegunn/vim-easy-align'

" Jupyter:
" integration with Jupyter consoles
Plug 'jupyter-vim/jupyter-vim'

" Prose:
" this plug helps navigation and writing of prose (paragraphs
" instead of lines of code)
" Plug 'reedes/vim-pencil'
" replaced by prose mode function defined at the bottom of this
" Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'markdown' }

" Aesthetic:
" Color Theme
" Plug 'drewtempelmeyer/palenight.vim'
" " Color Theme Alt
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'marko-cerovac/material.nvim'
" My custom nord with extra pandoc syntax:
Plug 'liamtimms/nord-vim'

" Goyo and limelight (zen mode)
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'

" LaTeX:
" this plug contains a bunch of LaTeX support stuff
Plug 'lervag/vimtex', { 'for': 'tex' }
" this plug allows a live preview of LaTeX
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Snippets:
" this plug provides snippet support
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine.
Plug 'honza/vim-snippets'

" TMUX:
" tmux-vim integration
Plug 'christoomey/vim-tmux-navigator'

" Treesitter:
" k i s s i n g
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Firenvim:
" browser embedds
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

" Install plugins on new install:
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

source $CUSTOM_CONFIG_HOME/nvim/basic_settings.vim
source $CUSTOM_CONFIG_HOME/nvim/coc_settings.vim
source $CUSTOM_CONFIG_HOME/nvim/plug_settings.vim
source $CUSTOM_CONFIG_HOME/nvim/prose_mode.vim

" Firenvim:
"
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
  set laststatus=0
  let g:material_style = "darker"
  colorscheme material
  autocmd BufNew,BufEnter *.py execute "silent! CocDisable"
else
  colorscheme nord
  set laststatus=2
endif


