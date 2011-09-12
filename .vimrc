" my additions
source ~/.vim/ftplugin/xml.vim
source ~/.vim/doc/NERD_tree.vim
source ~/.vim/syntax/ftl.vim
"source ~/.vim/colors/molokai.vim
" source ~/.vim/colors/twilight.vim
autocmd FileType php,js,html,java,c,cpp,chh,h,cc,ruby,erb :set cindent
set incsearch
set hlsearch
set wrap
set gfn=Monaco\ 11
abbr for() for (var i = 0; i < len; i++) {<CR>}<Esc>O<Space><Space>

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

" Set fhtml to xhtml highlighting
au BufRead,BufNewFile *.htmlf setfiletype xhtml
au BufRead,BufNewFile *.htmlf colorscheme pablo
au BufRead,BufNewFile *.ftl setfiletype xhtml
au BufRead,BufNewFile *.zml setfiletype xhtml
au BufRead,BufNewFile *.conf setfiletype nginx
au BufRead,BufNewFile *.go set filetype=go
augroup json
  autocmd BufRead *.json set filetype=javascript
augroup END

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

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.

" search related preferences
set incsearch
set hlsearch

" allows full line wrap
set wrap

imap ,/ </<C-X><C-O>

inoremap <% <%  %><Esc>i
autocmd Syntax ruby,erb inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap %> <c-r>=ClosePair('%>')<CR>
"inoremap  <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>
inoremap #$ <c-r>=DrupalData()<CR>

function DrupalData()
  return "drupal_set_message('<pre>' . print_r(,true) . '</pre>');"
endf

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<Esc>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
  return a:char
    elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<Esc>i"
  endif
endf


