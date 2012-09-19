
filetype off
"call pathogen#runtime_append_all_bundles()
call pathogen#infect()
syntax on
"filetype on
filetype plugin indent on

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

hi IndentGuidesOdd  guibg=red   ctermbg=Blue
hi IndentGuidesEven guibg=green ctermbg=DarkBlue


set ts=2 sw=2 et
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

