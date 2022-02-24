
" === Specific Plugin Settings ===

" Treesitter: -----------------------------
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

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
let g:pandoc#syntax#conceal#use =  0

" ALE: ---------------------------------
" define linters and fixers
" from https://www.vimfromscratch.com/articles/vim-for-python/
let g:ale_enabled = 0
let g:ale_linters = {
      \   'python': ['flake8'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \   'markdown': ['proselint'],
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \    'c': ['clang-format'],
      \    'json': ['prettier'],
      \    'markdown': ['prettier'],
      \    'javascript': ['prettier'],
      \}
nnoremap <leader>al :ALEToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap ]e   :ALENextWrap<CR>
nnoremap [e   :ALEPreviousWrap<CR>

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



