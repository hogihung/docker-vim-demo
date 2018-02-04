" Author:       John F. Hogarty
" Email:        hogihung@gmail.com
" --------------------------------------
set nocompatible		" be iMproved, required
filetype off  			" required

" Set basic setup
syntax on                    " Enable syntax highlighting
set encoding=utf-8           " Add support for Unicode characters (used in listchars below)
set shell=bash               " Can switch to zsh if you use z-shell
set number                   " Enables line numbering
set t_Co=256                 " Set terminal colors to 256
set listchars=tab:▸\ ,eol:¬  " Use same symbols as TextMate for tabstops and EOLs
set laststatus=2             " Display vim status bar
set updatecount=0            " Disable swap files
set splitright               " Put new file to right on vertical split
set splitbelow               " Put new file to bottom on horizontal split
set relativenumber           " Set relative numbering (set rnu / set nornu)

" Change leader, which defaults as backslash, to the comma key
let mapleader = ","

" Swap the less used semi-colon for colon
nnoremap ; :

" Auto save files when switching focus
autocmd FocusLost * silent! wall

" Adjusting tab spacing, use softtabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Set Vim Explorer to display like NERDTree
let g:netrw_liststyle=3

" Add some column when exceeding the 80th column
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" use below line instead of the above for a solid column
"set colorcolumn=81

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Shortcut for rapid toggle 'set list'
nmap <leader>sl :set list!<CR>

" Disable vim auto-paste (corrects too much identing)
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Shortcut for identing entire page
map <leader>i mmgg=G`m<CR>

" Search configuration
set incsearch     " Highlight while searching
set hlsearch      " Highlight all matches after entering search pattern
" Toggle highlighting off
nmap <leader>h :nohlsearch<cr>

set ignorecase    " Case insensitive pattern matching
set smartcase     " Overrides ignorecase if pattern contains upcase

" Map Vim Window navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Handle whitespace based on file type
if has("autocmd")
  " enable file type detection
  filetype on

  " Languages which are picky about tabs vs. spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customization based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  "autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType perl setlocal ts=4 sts=4 sw=4 noexpandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " Remove trailing whitespace automatically while a file
  " is saved, for the defined file extensions:
  autocmd BufWritePre *.txt,*.rb,*.erb :call <SID>StripTrailingWhitespaces()
endif

" Turn on ruby compiler for vim
autocmd FileType ruby compiler ruby