" === Specific Plugin Settings ===
" covers vimscript plugin settings

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Vimtex: -------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
" vim-latex-live-preview ---------------
" let g:livepreview_previewer = 'zathura'


" Pandoc: ------------------------------
"
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
"
let g:pandoc#syntax#conceal#use =  0

" Vimwiki: ----------------------------
let g:vimwiki_list = [{'path': '~/Documents/LaptopSync/wiki/',
                      \ 'syntax': 'markdown',
                      \ 'ext': '.md',
                      \ 'auto_diary_index': 1,
                      \ 'diary_caption_level': -1}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
" let g:vimwiki_key_mappings = { 'table_mappings': 0 }
let g:vimwiki_hgader_type = '#'     " set to '=' for wiki syntax
nmap <Leader>wf <Plug>VimwikiFollowLink

au BufNewFile */diary/[0-9]*.md
  \ call append(0,[
  \ "# Shiplog " . split(expand('%:r'),'/')[-1], "",
  \ "## Dailies", "",
  \ "- [ ] Meds Morning -", 
  \ "- [ ] Meds Afternoon -",
  \ "- [ ] Workout", 
  \ "- [ ] Therapy Walk", "",
  \ "## Plans",  "",
  \ "1.",  "2.",  "3.",  "",  
  \ "## Things I did",  "",
  \ "1.",  "2.",  "3.",  "",  
  \ "## Near Future",  "",
  \ "## Scratch"]) 

" Copilot: ----------------------------
let g:copilot_filetypes = { 'markdown': v:false }
let g:copilot_no_tab_map = v:true
nnoremap <leader>ce :Copilot enable<CR>
nnoremap <leader>cd :Copilot disable<CR>
nnoremap <leader>cp :Copilot panel<CR>
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" ALE: ---------------------------------
" define linters and fixers
" from https://www.vimfromscratch.com/articles/vim-for-python/
let g:ale_enabled = 0
let g:ale_linters = {
      \   'python': ['ruff', 'pydocstyle', 'mypy'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \   'markdown': ['proselint'],
      \   'sh': ['shellcheck'],
      \}

" note ruff may be a good overall replacement fixer for python in the future
let g:ale_fixers = {
      \    'python': ['black', 'yapf', 'isort', 'remove_trailing_lines', 'trim_whitespace'], 
      \    'c': ['clang-format'],
      \    'json': ['prettier'],
      \    'markdown': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \    'vimwiki': ['prettier'],
      \    'javascript': ['prettier'],
      \    'sh': ['shfmt'],
      \    'rust': ['rustfmt'],
      \    'lua': ['stylua'],
      \    'latex': ['latexindent'],
      \    'tex': ['latexindent'],
      \}
nnoremap <leader>al :ALEToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap ]e   :ALENextWrap<CR>
nnoremap [e   :ALEPreviousWrap<CR>

" let g:ale_disable_lsp = 1

let g:ale_fix_on_save = 1

" Quickscope: --------------------------
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Ultisnip: -----------------------------
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Tagbar: -----------------------------
nnoremap <F6> :TagbarToggle

" " fzf-lua: -----------------------------
" nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<CR>
" nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<CR>
" nnoremap <leader>fg <cmd>lua require('fzf-lua').live_grep()<CR>
"
" fugitive: -----------------------------
nnoremap <leader>gw :Gwrite
nnoremap <leader>gc :Git commit
nnoremap <leader>gp :Git push
nnoremap <leader>gpl :Git pull

" NvimTree: ----------------------------
nnoremap <leader>e :NvimTreeToggle<cr>

" Undotree: ----------------------------
nnoremap <leader>ut :UndotreeToggle<cr>

