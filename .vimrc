" my additions
source ~/.vim/syntax/ftl.vim
autocmd FileType php,js,html,java,c,cpp,chh,h,cc,ruby,erb :set cindent
set incsearch
set hlsearch
set wrap
set gfn=Monaco\ 11

" install pathogen
call pathogen#infect()

" tab related
map <C-t> :tabe .<CR>
map <C-q> :tabclose<CR>
map <C-p> :tabprevious<CR>
map <C-n> :tabnext<CR>

set t_co=256
set number

" tab spacing
set softtabstop=2
set shiftwidth=2
set ts=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" File types
filetype plugin indent on

" Start NERDTree by default
autocmd vimenter * NERDTree

" Syntax highlighting for nginx and general server configurations
au BufRead,BufNewFile *.conf set filetype nginx
" Syntax highlighting for JSON files.
au BufRead,BufNewFile *.json set filetype=javascript
" Syntax highlighting for Go
au BufRead,BufNewFile *.go set filetype=go

" Set for drupal related files types
augroup module
  autocmd BufRead *.module set filetype=php
augroup END
augroup inc
  autocmd BufRead *.inc set filetype=php
augroup END
augroup test
  autocmd BufRead *.test set filetype=php
augroup END
augroup install
  autocmd BufRead *.install set filetype=php
augroup END
augroup info
  autocmd BufRead *.info set filetype=php
augroup END

" turn syntax highlighting on by default
syntax on

" set auto-indenting on for programming
set ai

" turn off compatibility with the old vi
set nocompatible

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" search related preferences
set incsearch
set hlsearch

" allows full line wrap
set wrap

inoremap <% <%  %><Esc>i
autocmd Syntax ruby,erb inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap %> <c-r>=ClosePair('%>')<CR>
inoremap #$ <c-r>=DrupalData()<CR>

function DrupalData()
  return "drupal_set_message('<pre>' . print_r(,true) . '</pre>');"
endf

