
syntax on
colorscheme greens

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


