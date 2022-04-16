" === Specific Plugin Settings ===

" lua based configs:
"
lua << END
-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
-- lualine
require('lualine').setup {
  options = {
      icons_enabled = true,
      theme = 'auto',
      -- component_separators = { left = '', right = ''},
      -- section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'g:coc_status', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
  }

-- git signs
require('gitsigns').setup()

--comments
require('Comment').setup()

--fzf
-- require('fzf-lua').setup()

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

-- explorer
require('nvim-tree').setup()

END

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

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
      \    'python': ['black', 'yapf', 'isort', 'remove_trailing_lines', 'trim_whitespace'],
      \    'c': ['clang-format'],
      \    'json': ['prettier'],
      \    'markdown': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \    'javascript': ['prettier'],
      \}
nnoremap <leader>al :ALEToggle<CR>
nnoremap <leader>af :ALEFix<CR>
nnoremap ]e   :ALENextWrap<CR>
nnoremap [e   :ALEPreviousWrap<CR>

let g:ale_fix_on_save = 1

" Quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"
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

" fzf-lua: -----------------------------
nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>fg <cmd>lua require('fzf-lua').grep()<CR>

" fugitive: -----------------------------
nnoremap <leader>gw :Gwrite
nnoremap <leader>gc :Git commit
nnoremap <leader>gp :Git push
nnoremap <leader>gpl :Git pull

" NvimTree
nnoremap <leader>e :NvimTreeToggle<cr>
