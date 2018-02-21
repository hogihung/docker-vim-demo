

RESOURCES:

More Insanely Better Vim:  https://www.youtube.com/watch?v=aHm36-na4-4
Practical Vim Book, by Drew Neil: http://vimcasts.org/publications/
Vimcasts:                  http://vimcasts.org/episodes/page/8/
Vim-Airline:               https://github.com/vim-airline/vim-airline
Vim-Solarized:             https://vimawesome.com/plugin/solarized-8


# STEP ONE - Initial Vim Configuration

```
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
```



# STEP TWO - TWEAKING OUR SETTINGS

```
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
```


# STEP THREE - WINDOW NAVIGATION & SPACING FOR FILE TYPES 

```
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
```


# STEP FOUR - ADD OUR FIRST FUNCTION

```
" Relative line number toggle
nnoremap <C-n> :call NumberToggle()<cr>

" PUT FUNCTIONS FROM HERE DOWN
" ----------------------------
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
```


# STEP FIVE - MORE FUNCTIONS

```
" http://vimcasts.org/episodes/tabs-and-spaces/
" Set tabstop, softabstop and shiftwidth to the same value
" To use, type:  :Stab
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' shofttabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon 'noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

"Support Tabularize
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
```



# STEP SIX - SPLASH OF COLOR

```
# Exit vim -> :wq!
# Clone the Solarized repo:
git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8

# Edit the .vimrc file again:
" Configure color theme
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

# Edit your .vimrc file to see the theme
vim .vimrc
```


# STEP SEVEN - VUNDLE & GOOEY 

```
# NOTE: We are now adding a Plug-in Manager, Vundle, and the order of things
        matters.  Be sure to follow along closely.

# The following goes DIRECTLY after the line:   filetype off

" set the runtime path to include Vundle and initialize
" url: https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call bundle #begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" Plugin on GitHub repo

" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

# Save and exit vim -> :wq!
# Open your .vimrc file again ->  vim .vimrc
# Run the plugin installer:
:PluginInstall


# Now will add the Airline tools (put after Plugin on GitHub repo and BEFORE " All of your Plugins....
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

# Save and exit vim -> :wq!
# Open your .vimrc file again ->  vim .vimrc
# Run the plugin installer:
:PluginInstall
```


# STEP EIGHT - PLUGINS GALORE

```
# vim .vimrc  (Add the following in the Plugin section)
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elixir-lang/vim-elixir'


# Save file, run 
:source%
:PluginInstall

# NOTE: one of the plugins required me to enter my Github creds.
# Save and exit vim -> :wq!
```


# QUICK EXAMPLE USING VIM  (maybe do this before we customize vim)

```
vim ~/example.rb

class SomeClass
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end
end
```





# COMPLETED FILE:

```
jfhogarty@ruby-dev:~$ cat .vimrc
" Author:       John F. Hogarty
" Email:        hogihung@gmail.com
" --------------------------------------
set nocompatible		" be iMproved, required
filetype off  			" required

" set the runtime path to include Vundle and initialize
" url: https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call bundle #begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" Plugin on GitHub repo
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elixir-lang/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()		" required
filetype plugin indent on	" required

" Set basic setup
syntax on
set encoding=utf-8
set shell=bash
set number
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

" Relative line number toggle
nnoremap <C-n> :call NumberToggle()<cr>


" Configure color theme
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized8

" Customization for vim-airline
" Use :help airline for info on configuring vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Change color scheme for lightline (vim status bar)
"let g:lightline = { 'colorscheme': 'wombat', }


" PUT FUNCTIONS FROM HERE DOWN
" ----------------------------
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

" http://vimcasts.org/episodes/tabs-and-spaces/
" Set tabstop, softabstop and shiftwidth to the same value
" To use, type:  :Stab
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' shofttabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon 'noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

"Support Tabularize
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

jfhogarty@ruby-dev:~$
```

