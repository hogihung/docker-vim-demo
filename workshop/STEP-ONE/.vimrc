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
