" neovim .init.vim file
" Author: Liam Timms
" Arch

" TODO: add file type checking so that different settings are loaded for
" python, latex or anything else I end up doing.
" TODO: add file type specifc key bindings, i.e. one short cut to create a
" comment in markdown, laTeX, python, MATLAB, etc. with the appropiate syntax
" for that file type (or find a plugin that does this)

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

" code linter
Plug 'dense-analysis/ale'

" tags
Plug 'majutsushi/tagbar'

" easier parenthesis, etc.
Plug 'tpope/vim-surround'

" Statusline:
" airline and associated theming
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git:
" git integration that works wiht airline
Plug 'tpope/vim-fugitive'

" FZF:
" powerful functionality from fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Aesthetic:
" Color Theme
Plug 'drewtempelmeyer/palenight.vim'
" Color Theme Alt
Plug 'dracula/vim', { 'as': 'dracula' }
" Goyo and limelight (zen mode)
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" LaTeX:
" this plug contains a bunch of LaTeX support stuff
Plug 'lervag/vimtex'
" this plug allows a live preview of LaTeX
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Prose:
" this plug helps navigation and writing of prose (paragraphs
" instead of lines of code)
Plug 'reedes/vim-pencil'

call plug#end()

" Install plugins on new install:
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ======= General Settings ======
"
" show line numbers
" set nu
set number relativenumber

" make splits behave in a more natural way
set splitbelow splitright

" make autocompletion behave better
set wildmode=list:longest
set completeopt+=noinsert

" make mouse do more
set mouse=a

" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" change color scheme
" colorscheme palenight
" colorscheme dracula
" let g:airline_theme = 'palenight' " palenight hasn't been added to airline
" yet

" delete all extra whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" change tabs into spaces
set tabstop=4 shiftwidth=4 expandtab

" remap Escape to get out of terminal mode
tnoremap <Esc> <C-\><C-n>

" pressing F7 shows tabs and the end of the line more explicitly
nnoremap <F7> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>

" pressing F3 turns on spell
nnoremap <F3> :setlocal spell! spelllang=en_us <CR>

" pressing F2 toggles on prose mode
nnoremap <F2> :call ToggleProse() <CR>

" === Specific Plugin Settings ===

" Deoplete -----------------------------
" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'ignore_case' : v:true,
\ 'smart_case': v:true,
\ })

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

" Airline -----------------------------
" I want to have the little arrows in airline instead of flat blocks
" Apparently this requires Installing powerline symbols so I'm not
" bothering right now
let g:airline_powerline_fonts = 1

" hi! Normal ctermbg=NONE guibg=NONE
"
" vimtex -------------------------------
let g:vimtex_view_method = 'zathura'
" vim-latex-live-preview ---------------
let g:livepreview_previewer = 'zathura'

" ALE ---------------------------------
" define linters and fixers
" from https://www.vimfromscratch.com/articles/vim-for-python/
let g:ale_enabled = 0
let g:ale_linters = {
      \   'python': ['flake8'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \}

nnoremap <F4> :ALEToggle
nnoremap <F5> :ALEFix
"let g:ale_fix_on_save = 1

" Tagbar -----------------------------
nnoremap <F6> :TagbarToggle
"""""
"function! LinterStatus() abort
"  let l:counts = ale#statusline#Count(bufnr(''))
"
"  let l:all_errors = l:counts.error + l:counts.style_error
"  let l:all_non_errors = l:counts.total - l:all_errors
"
"  return l:counts.total == 0 ? '✨ all good ✨' : printf(
"        \   '😞 %dW %dE',
"        \   all_non_errors,
"        \   all_errors
"        \)
"endfunction
"
"set statusline=
"set statusline+=%m
"set statusline+=\ %f
"set statusline+=%=
"set statusline+=\ %{LinterStatus()}
"""""

" BLAH
" TODO: alias 'gj' to 'j' in .tex
"au BufNewFile,BufRead *.tex
" solution: Prose Mode from github:
" 'LukeSmithxyz/vimling/master/plugin/prose.vim'

let g:ProseOn=0

function! ToggleProse()
    if !g:ProseOn
        call Prose()
    else
        call ProseOff()
    endif
endfunction

function! Prose()
    echo "Prose: On"
    let g:ProseOn=1

    noremap j gj
    noremap k gk
    noremap 0 g0
    noremap $ g$
    noremap A g$a
    noremap I g0i
    setlocal linebreak nonumber norelativenumber t_Co=0 foldcolumn=2
    hi! link FoldColumn Normal

endfunction

function! ProseOff()
    echo "Prose: Off"
    let g:ProseOn=0

    noremap j j
    noremap k k
    noremap 0 0
    noremap $ $
    noremap A A
    noremap I I
    setlocal nolinebreak number relativenumber t_Co=256 foldcolumn=0

endfunction

