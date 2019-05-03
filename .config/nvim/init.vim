" neovim .init.vim file 
" Author: Liam Timms
" Date: 5/3/19 
" Version: 1.1

" ====== Vim-plug install =======
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

" ======== Plugin Setup =========
" specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Autocomplete:
" deoplete (neovim autocompletion) 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" jedi (python completion)
Plug 'davidhalter/jedi-vim'
" deoplete-jedi (connects them)
Plug 'deoplete-plugins/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }

" Statusline:
" airline and associated theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Aesthetic:
" Color Theme
Plug 'drewtempelmeyer/palenight.vim'

" Goyo and limelight (zen mode)
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" LaTeX:
" this plug contains a bunch of LaTeX support stuff
Plug 'lervag/vimtex'

call plug#end()

" Install plugins on new install:
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ======= General Settings ======
"
" show line numbers
set nu

" make autocompletion behave better
set wildmode=list:longest
set completeopt+=noinsert

" change color scheme
colorscheme palenight
" let g:airline_theme = 'palenight' " palenight hasn't been added to airline
" yet

" === Specific Plugin Settings ===

" Deoplete -----------------------------
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Goyo and Limelight--------------------
" turn on limelight only while in goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" hi! Normal ctermbg=NONE guibg=NONE
