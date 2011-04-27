" This is my .vimrc...I use gvim on linux, macvim on Mac OS. 7.3 required.
" Note that there's no particular ordering here (except pathogen stuff comes first).

" Pathogen == teh awesomes.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax on
filetype plugin indent on

" Text-wrapping stuff. (Also check out my cursorcolumn setting in .gvimrc.)
set textwidth=110 " 80-width lines is for 1995
let &wrapmargin= &textwidth
set formatoptions=croql " Now it shouldn't hard-wrap long lines as you're typing (annoying), but you can gq
                        " as expected.

set hidden "This allows vim to put buffers in the bg without saving, and then allows undoes when you fg them again.
set history=1000 "Longer history
set number
set hlsearch
set autoindent
set smartindent
set expandtab
set wildmenu
set wildmode=list:longest
set scrolloff=3 " This keeps three lines of context when scrolling
set title
set expandtab
set smarttab
set ts=2
set sw=2
set sts=2
set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set linespace=3
set incsearch

let mapleader = ","

" Mappings:
map <F6> :b#<CR>
map <C-n> :noh<CR>
map <C-Space> <C-x><C-o>
" I don't use s and S in normal mode much. Let's make them do something useful
" * s will break the line at the current spot and move it down.
" * S is the same, but moves it up.
nnoremap s i<CR><ESC>==
nnoremap S d$O<ESC>p==

" Colorscheme bullshittery:
set t_Co=16
set background=dark
colorscheme lucius

" Adjust colors as necessary
hi ColorColumn     guibg=#444444
hi ColorColumn     ctermbg=0
hi IncSearch       guifg=NONE   guibg=#353E44
hi IncSearch       ctermfg=NONE ctermbg=67
hi Search          guifg=NONE guibg=#545449
hi Search          ctermfg=NONE ctermbg=22

" latex build + evince ps view
"nmap <leader>tex :!(texbuildps.py %)<CR><CR>

" Gundo settings
nnoremap <leader>g :GundoToggle<CR>

" NERDTree settings
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nmap <leader>t :NERDTreeToggle<CR>

" Stupid NERDCommenter warning
let NERDShutUp=1

" Make it easier to move around through blocks of text:
noremap <C-J> gj
noremap <C-k> gk
noremap U 30k
noremap D 30j

" Ack >> grep
nnoremap <leader>a :Ack

" Audio bell == annoying
set vb t_vb=

" Textmate-style invisible char markers
set list
set listchars=tab:▸\ ,eol:¬

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:

" For some reason I accidentally hit this shortcut all the time...let's disable it. (I usually don't look at
" man pages from within vim anyway.)
map K <Nop>

" Preview the current markdown file:
map <leader>m :%w ! markdown_doctor \| bcat<CR><CR>

" Close a buffer without messing with the windows (vim-bclose)
nmap <leader>q <Plug>Kwbd

" Macvim default clipboard interaction is bullshit
set clipboard=unnamed

" Ensure the temp dirs exist
call system("mkdir -p ~/.vim/tmp/blah")
call system("mkdir -p ~/.vim/tmp/backup")
call system("mkdir -p ~/.vim/tmp/undo")
" Change where we store swap/undo files
set dir=~/.vim/tmp/swap//
set backupdir=~/.vim/tmp/backup//
set undodir=~/.vim/tmp/undo/

" Toggle colorcolumn
function! ToggleColorColumn()
  if &colorcolumn == 0
    " Draw the color column wherever wrapmargin is set
    let &colorcolumn = &wrapmargin
  else
    let &colorcolumn = 0
  endif
endfunction
command! ToggleColorColumn call ToggleColorColumn()
map <leader>l :ToggleColorColumn<CR>

" TODO: move all the language-specific settings to ftplugins

" Nice ruby settings
let ruby_space_settings = 1

" Go specific settings
augroup golang
  au!
  au FileType go set noexpandtab
augroup END

" Markdown settings
augroup markdown
  au!
  au FileType markdown set comments=b:*,b:-,b:+,n:>h
augroup END
