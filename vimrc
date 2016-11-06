" vimrc

" Flags {{{
let s:use_dein = 1
" }}}

" Dein {{{
let s:vimdir = $HOME . '/.vim'
let s:dein_dir = s:vimdir . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = "Shougo/dein.vim"
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
let s:rsense_dir = $HOME . '/.rbenv/shims/rsense'

"  Install dein automatically
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if &compatible
  set nocompatible
endif

let &runtimepath = &runtimepath . "," . s:dein_repo_dir

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#add('Shougo/dein.vim')

  " Plugin async loader
	call dein#add('Shougo/vimproc.vim', {
		\ 'build' : {
		\     'windows' : 'tools\\update-dll-mingw',
		\     'cygwin' : 'make -f make_cygwin.mak',
		\     'mac' : 'make -f make_mac.mak',
		\     'unix' : 'make -f make_unix.mak',
		\    },
		\ })

  " Completion
	call dein#add('Shougo/neocomplete.vim')

	call dein#add('cohama/lexima.vim')

  " Linter
	call dein#add('vim-syntastic/syntastic')

  " Syntax highlight
	call dein#add('othree/yajs.vim')
	call dein#add('othree/javascript-libraries-syntax.vim')

  " Statusline
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')

	" Filer
	call dein#add('Shougo/vimfiler.vim',
			\ { 'depends': 'unite.vim' })
	call dein#add('ctrlpvim/ctrlp.vim')

  " Git
	call dein#add('airblade/vim-gitgutter')
	call dein#add('tpope/vim-fugitive')

  " Util
	call dein#add('tomtom/tcomment_vim')
	call dein#add('vim-scripts/YankRing.vim')

  " Unite
	call dein#add('Shougo/unite.vim')
	call dein#add('ujihisa/unite-colorscheme')

	" Rails
	call dein#add('tpope/vim-rails')

	" Colorscheme
	call dein#add('flazz/vim-colorschemes')

	"TODO Reinstall denite.nvim when it is stable
	" Denite.nvim
	" call dein#add('Shougo/denite.nvim')

	call dein#end()
endif
" }}}

" Plugin settings {{{

" ctrlp.vim
if dein#tap('ctrlp.vim')
  let g:ctrlp_map = '<c-t>'
endif

" denite.nvim
" let g:denite_enable_start_insert=1
" let s:python_dir = '/Users/shun/.pyenv/shims/python3'
" let g:python3_host_prog = expand(s:python_dir)
"
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'final_opts', [])
" call denite#custom#var('grep', 'separator', [])
" call denite#custom#var('grep', 'default_opts',
"   \ ['--nocolor', '--nogroup'])
" call denite#custom#var('file_rec', 'command',
" 	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
"
" nnoremap <silent> ,g :<C-u>Denite grep:. -buffer-name=search-buffer<CR>
" nnoremap <silent> ,cg :<C-u>Denite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>

" unite.vim
if dein#tap('unite.vim')
	let g:unite_enable_start_insert=1
	let g:unite_enable_ignore_case = 1
	let g:unite_enable_smart_case = 1

	if executable('ag')
		let g:unite_source_grep_command = 'ag'
		let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
		let g:unite_source_grep_recursive_opt = ''
	endif

	nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
	nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
	nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
endif

" neocomplete
if dein#tap('neocomplete.vim')
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
			  \ 'default' : '',
			  \ 'vimshell' : $HOME.'/.vimshell_hist',
			  \ 'scheme' : $HOME.'/.gosh_completions'
			  \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
	  let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
	  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	  " For no inserting <CR> key.
	  "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
	  let g:neocomplete#sources#omni#input_patterns = {}
  endif
endif

" syntastic
if dein#tap('syntastic')
  let g:syntastic_javascript_checkers = ['eslint']
endif

" vim-airline
if dein#tap('vim-airline')
	let g:airline_theme='murmur'
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_detect_paste=0
	let g:airline#extensions#hunks#enabled=0
	let g:airline#extensions#tabline#excludes = ['vimfiler:default']
	let g:airline#extensions#tabline#fnamemod = ':t'

	let g:airline_left_sep = ''
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_sep = ''

	let g:airline#extensions#branch#enabled=1
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_symbols.branch = '⭠'
endif

" vimfiler

if dein#tap('vimfiler.vim')
	let g:vimfiler_as_default_explorer = 1
	let g:vimfiler_restore_alternate_file = 1
	let g:vimfiler_tree_indentation = 1
	let g:vimfiler_tree_leaf_icon = '¦'
	let g:vimfiler_tree_opened_icon = '▼'
	let g:vimfiler_tree_closed_icon = '▷'
	let g:vimfiler_file_icon = '-'
	let g:vimfiler_readonly_file_icon = '*'
	let g:vimfiler_marked_file_icon = '√'

	nnoremap <silent> <C-\> :<C-u>VimFilerExplorer -split -simple -winwidth=30 -toggle -no-quit<CR>
	autocmd VimEnter * VimFilerExplorer -split -simple -winwidth=30 -toggle -no-quit
	autocmd FileType vimfiler call s:vimfilerinit()
	function! s:vimfilerinit()
		set nonumber
		set norelativenumber
	endfunction
endif

" }}}

" Basic settings {{{

" Set statusline
set laststatus=2

" Display line number
set nu

" Highlight a matching opening or closing parenthesis, square bracket or a curly brace
set showmatch

" Display ruler
set ruler

" Enable incsearch
set incsearch 

" Set default indent width
set tabstop=2
set shiftwidth=2

" Accessing the system clipboard
set clipboard=unnamed,autoselect

" Avoid automatic indentation 
autocmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

"set nowrap
syntax enable

" Switch on highlighting the last used search pattern
set hlsearch

" Encode
set encoding=utf-8

" gui configuration
highlight Pmenu ctermbg=33 ctermfg=255
highlight PmenuSel ctermbg=255 ctermfg=0

" Fastest way to move buffer
nnoremap <silent><Left> :bp<CR>
nnoremap <silent><Right> :bn<CR>
nnoremap <silent><C-Space> :bd<CR>
if !has('gui_running')
	augroup term_vim_c_space
		autocmd!
		autocmd VimEnter * map <Nul> <C-Space>
		autocmd VimEnter * map! <Nul> <C-Space>
	augroup END
endif

" Enable plugin, indent
filetype plugin indent on

" Display another buffer when current buffer isn't saved.
set hidden

" Colorscheme
colorscheme maui

" }}}

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
