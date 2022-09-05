""""""""""""""""""""""""""
"" PERSONAL VIM SETTINGS "
""""""""""""""""""""""""""
filetype plugin on
syntax on
set shiftwidth=4
set tabstop=4
set number
set ignorecase
set hlsearch
set noswapfile
set autoindent

"" colorscheme
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai
set t_Co=256
"set background=dark
"makes number column transparent
highlight clear LineNr
"sets line number to grey
highlight LineNr ctermfg=239

"" Spell check for markdown
autocmd FileType markdown setlocal spell

""""""""""""""""""""""""""""
"" PERSONAL CUSTOM HELPERS "
""""""""""""""""""""""""""""
"" whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"" Show name of function you're currenly in!
noremap <F10> :call ShowFuncName() <CR>
fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

"open current file in sublime
command Subl :!subl %

"toggle line numbers
command Num :set invnumber

"""""""""""""""""""""""""""""
""                          "
"" VIM PLUGIN CONFIGURATION "
""                          "
"""""""""""""""""""""""""""""

"""""""""""
"" VIM-GO "
"""""""""""
" settings
set autowrite "vim-go takes advantage of this
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'gopls'
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'
let g:go_fmt_fail_silently = 1
let g:go_auto_sameids = 1

" show info under cursor every <updatetime>ms
let g:go_auto_type_info = 1
set updatetime=100

" Golang Syntax highlighting
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

"" vim-go shortcuts
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" build/run/compile/test/info shortcuts
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" error (quickfix) naviation shortcuts
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" GoAlternate shortcuts
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
