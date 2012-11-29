""""""""""""""""""""""""
" basic.vimrc
"

syntax on
filetype plugin indent on

set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:%
set list
set number
set laststatus=2
set cursorline

set autowrite
set hidden
set nowrap

function! GetStatusEx()
  let str = ''
  if &ft != ''
    let str = str . '[' . &ft . ']'
  endif
  if has('multi_byte')
    if &fenc != ''
      let str = str . '[' . &fenc . ']'
    elseif &enc != ''
      let str = str . '[' . &enc . ']'
    endif
  endif
  if &ff != ''
    let str = str . '[' . &ff . ']'
  endif
  return str
endfunction
set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}\ \ %l,%c%V%8P


au BufNewFile,BufRead *.ejs set filetype=html

""""""""""""""""""""""""
" vim-indent-guides
"
set ts=2 sw=2 et
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

""""""""""""""""""""""""
" neocomplcache
"
let g:neocomplcache_enable_at_startup = 1



