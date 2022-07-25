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

" turn on mode change text wrapping and movement that's better suited to prose
nnoremap <leader>p :call ToggleProse() <CR>

" turn on and off spell check
nnoremap <leader>s :setlocal spell! spelllang=en_us <CR>

" zoom in and out kind of like tmux
nnoremap <leader>zz <c-w>_ \| <c-w>\|
nnoremap <leader>zo <c-w>=


" pressing F7 shows tabs and the end of the line more explicitly
nnoremap <F7> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>

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
