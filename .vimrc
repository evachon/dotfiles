" evachon's vimrc
" Etienne Vachon <vachonetienne@gmail.com>
"
"
"

" Pathogen plugin 
call pathogen#infect()

" General
set nocompatible
let mapleader = ","

" Display
syntax on                   " Syntax highlight
color blackboard            " Good color!
set background=dark         " Background style
set number                  " Show line number.
set backspace=2             " Allow backspacing over autoindent, line breaks, start of insert.
set laststatus=2            " The status line is always visible
set nowrap                  " Don't wrap line

" Behavior and particular configurations
set autoread                " When a file has been changed outside of Vim, automatically read it again.
set history=50              " Number of command line history
set undolevels=1000         " A lot of undo 
set scrolloff=3             " Minimal number of screen lines to keep above and below the cursor.
set sidescroll=1            " Minimal number of columns to scroll horizontally.
set sidescrolloff=10        " Minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
set showmatch               " When a bracket is inserted, briefly jump to the matching one.
set wildmenu                " Command-line completion operates in an enhanced mode.

" File options
filetype on                 " Enable filetype detection
filetype plugin on          " Enable filetype-specific plugins
filetype indent on          " Enable loading the indent file for specific file type.
set encoding=utf8
set fileformat=unix


" Search options
set hlsearch                " When there is a previous search pattern, highlight all its matches.
set incsearch               " While typing a search command, show where the pattern, as it was typed so far, matches.  The matched string is highlighted.
set ignorecase              " Ignore case in search patterns
set smartcase               " Disable ignorecase if uppercase are in the search pattern

" Cursor
set ruler                   " Show the potition (line and colum) of the cursor.
set cursorline              " Highlight the screen line of the cursor

" Indent
set shiftwidth=2            " Number of spaces to use for each step of (auto)indent.
set tabstop=2               " Number of spaces that a <Tab> in the file counts for.
set indentexpr=2            " Expression which is evaluated to obtain the proper indent for a line. 
set autoindent              " Copy indent from current line when starting a new line.
set expandtab               " In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
set smarttab		            " Insert tabs on the start of a line according to context
set formatoptions=tcroqn    " This is a sequence of letters which describes how automatic formatting is to be done.

" Other

" If wrap is set, the following lines allow to move from screen line from screen line
noremap k gk
noremap j gj
map <up> k
map <down> j
imap <up> <C-o>k
imap <down> <C-o>j

" When you hit <leader> + l, Tab and EOL is shown
nnoremap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" status line {
set laststatus=2
set statusline=%10(%f%)%15([%{&ff}/%Y]%)%<%20(%{hostname()}:%{CurDir()}%)\%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
  let curdir = substitute(getcwd(), $HOME, "~", "")
  return curdir
endfunction

" Plugin mapping
nnoremap <leader>u :GundoToggle<CR>
let g:EasyMotion_leader_key = '<Leader>m'
let g:CommandTMaxHeight = 15
