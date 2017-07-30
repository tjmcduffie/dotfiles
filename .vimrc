set nocompatible

"----------------------------------------------
""/ -------------- EDITING  --------------------
"----------------------------------------------

set wrap
set linebreak "wrap lines at convenient points
set textwidth=80 "hard line breaks at this number
" Make me aware of long lines
set colorcolumn=+1
" Hightlight the 101st character
call matchadd('ColorColumn', '\%101v')
"
filetype plugin indent on

set smarttab " insert tabs line according to shiftwidth, not tabstop
set autoindent
set smartindent "Indents smartly for c-like languages
set copyindent " copy the previous indentation on autoindenting

set backspace=indent,eol,start " allow backspacing over everything in insert
" mode
set shiftround "use multiple of shiftwidth when indenting with '<' and '>'

set expandtab     " expant tabs to spaces
set tabstop=2     " tab width (<tab>)
set softtabstop=2 " Generally a good idea to keep this the same as shiftwidth
set shiftwidth=2  " amount of columns for indentation


"---------------------------------------------
""/ -------- GENERAL GUI SETTINGS -------------
"---------------------------------------------

syntax enable

" enable mouse usage
if has('mouse')
  set mouse=a
endif

set undolevels=1000   " number of undos stored
set viminfo='50,"50   " '=marks for x files, "=registers for x files

set modelines=0       " modelines are bad for your health

set ruler "Shows colums, rows, percentage of location in file. Like g-Ctrl-G

set showcmd " Show the current command
set showmode " Show the current mode
set showmatch " flash matching delimiters
set visualbell "Removes beeping
set cmdheight=1 "The command-line bar height (default = 1)
set laststatus=2 "Always display status line

set number
set numberwidth=1 "min line number width

set ignorecase " case insensitive
set smartcase  " use case if any caps used

set hlsearch " highlight search matches
set incsearch " ignore case in search

" Scrolling.
set scrolljump=5    " scroll five lines at a time vertically
set sidescroll=10   " minumum columns to scroll horizontally
set scrolloff=12 "Viewport scroll X lines before cursor hits a side
set scroll=9 "Scroll up and down by how many lines using CTRL-D and CTRL-U
set helpheight=29
set winminheight=1 " windows can be 0 line high

" open splits to the right and bottom
set splitright
set splitbelow

"Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="


"---------------------------------------------
""/ ----------- PLUGIN SETTINGS-----------------
"---------------------------------------------

execute pathogen#infect()

" syntastic
let g:syntastic_javascript_checkers=['flow']
let g:syntastic_php_checkers=['hack']


"--------------------------------------------
""/ ----------- OTHER SETTINGS-----------------
"---------------------------------------------

" Switch syntax highlighting on, when the terminal can support colors
"
if &t_Co > 2 || has("gui_running")
 :syntax on
 " Change the highlight color for Comment and Special
 " to Cyan.  Blue is too dark for a black background.
 "
 :highlight Comment  term=bold ctermfg=cyan guifg=cyan
 :highlight Special  term=bold ctermfg=cyan guifg=cyan
 :highlight Constant term=bold ctermfg=red guifg=cyan
endif

" Kill any trailing whitespace on save.
if !exists("g:tm_kill_whitespace") | let g:tm_kill_whitespace = 1 | endif
if g:tm_kill_whitespace
	fu! <SID>StripTrailingWhitespaces()
	  let l = line(".")
	  let c = col(".")
	  %s/\s\+$//e
	  call cursor(l, c)
  endfu
  au FileType html,javascript,php,python,ruby,sass,scss,readme,tex,text
      \ au BufWritePre <buffer>
      \ :call <SID>StripTrailingWhitespaces()
endif
