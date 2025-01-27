"""""""""""""""""""""""""""
"" PERSONAL VIM SETTINGS "
"""""""""""""""""""""""""""
filetype plugin on
syntax on
set shiftwidth=4
set tabstop=4
set number
set ignorecase
set hlsearch
hi Search ctermbg=LightYellow
hi Search ctermfg=DarkRed
set noswapfile
set autoindent
set path=.,**,,

"" colorscheme
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai
set t_Co=256

" set background=dark

" makes number column transparent
highlight clear LineNr

" sets line number to grey
highlight LineNr ctermfg=239

" Spell check for markdown
autocmd FileType markdown setlocal spell

" CTAGS
set tags=~/.tags

" Rerun CTAGS
command Ctags :!ctags -R -o ~/.tags ~/work

" PERSONAL CUSTOM HELPERS
" Whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Open current file in sublime
command Subl :!subl %

" Toggle line numbers
command Num :set invnumber

"""""""""""""""""""""""""""""
""                          "
"" VIM PLUGIN CONFIGURATION "
""                          "
"""""""""""""""""""""""""""""
" Package management
execute pathogen#infect()

"""""""""""""""""
" YouCompleteMe "
"""""""""""""""""
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1

"vim-python
let g:python_highlight_all=1
