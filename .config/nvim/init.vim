" Title: neovim .init.vim file
" Author: Liam Timms
" OS: Arch Linux

" TODO: add file type checking so that different settings are loaded for python, latex or anything else I end up doing.

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
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linter:
" code linter
Plug 'dense-analysis/ale'

" Tags:
" tags
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

" " Aesthetic:
" " Color Theme
" Plug 'drewtempelmeyer/palenight.vim'
" " Color Theme Alt
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'

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
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" TMUX:
" tmux-vim integration
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" Install plugins on new install:
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ======= In-built Settings ======
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
colorscheme nord

" let g:airline_theme = 'distinguished'

" delete all extra whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" change tabs into spaces
set tabstop=4 shiftwidth=4 expandtab

" Fix LaTeX math formatting in markdown
" (stackoverflow q: vim-syntax-and-latex-math-inside-markdown)
autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'

" remap Escape to get out of terminal mode
tnoremap <Esc> <C-\><C-n>

" pressing F2 toggles on prose mode
nnoremap <F2> :call ToggleProse() <CR>

" pressing F3 turns on spell
nnoremap <F3> :setlocal spell! spelllang=en_us <CR>

" pressing F7 shows tabs and the end of the line more explicitly
nnoremap <F7> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>



" === Specific Plugin Settings ===

" " Deoplete: -----------------------------
" " let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({
" \ 'ignore_case' : v:true,
" \ 'smart_case': v:true,
" \ })

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" " Jedi-vim ------------------------------
" " Disable autocompletion (using deoplete instead)
" let g:jedi#completions_enabled = 0
" " All these mappings work only for python code:
" " Go to definition
" let g:jedi#goto_command = ',d'
" " Find ocurrences
" let g:jedi#usages_command = ',o'
" " Find assignments
" let g:jedi#goto_assignments_command = ',a'
" " Go to definition in new tab
" nmap ,D :tab split<CR>:call jedi#goto()<CR>

" " Goyo and Limelight--------------------
" " turn on limelight only while in goyo
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
" " Color name (:help cterm-colors) or ANSI code
" let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_ctermfg = 240

" Airline: -----------------------------
" I want to have the little arrows in airline instead of flat blocks
" Apparently this requires Installing powerline symbols so I'm not
" bothering right now
let g:airline_powerline_fonts = 1

" hi! Normal ctermbg=NONE guibg=NONE

" Vimtex: -------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
" vim-latex-live-preview ---------------
let g:livepreview_previewer = 'zathura'


" Pandoc: ------------------------------
"
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
"
set conceallevel=0

" ALE: ---------------------------------
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
      \    'c': ['clang-format'],
      \}
nnoremap <F4> :ALEToggle
nnoremap <F5> :ALEFix
"let g:ale_fix_on_save = 1
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

" Ultisnip: -----------------------------
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Tagbar: -----------------------------
nnoremap <F6> :TagbarToggle

" ====== Prose Mode! =======
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
    set conceallevel=0
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

" CoC:
let g:coc_global_extensions =  [
            \ 'coc-snippets',
            \ 'coc-prettier',
            \ 'coc-json',
            \ ]

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <NUL> coc#refresh()


" copy and pasted from neoclide/coc.nvim


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
