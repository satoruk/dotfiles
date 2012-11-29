set nocompatible " be iMproved
filetype off     " required!

""""""""""""""""""""""""
" Vundle
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" original repos on github
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nathanaelkane/vim-indent-guides'

" vim-scripts repos
Bundle 'molokai'


""""""""""""""""""""""""

syntax on
filetype plugin indent on

""""""""""""""""""""""""
" Color Scheme
"
set t_Co=256
colorscheme molokai
set background=dark " dark or light

if 'dark' == &background
  hi Normal guibg=black ctermbg=black
  hi Cursor ctermbg=233
"  autocmd VimEnter,Colorscheme * :hi Normal guibg=black ctermbg=black
  autocmd VimEnter,Colorscheme * :hi Cursor ctermbg=233
endif



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

""""""""""""""""""""""""
" vim-indent-guides
"
set ts=2 sw=2 et
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
if 'dark' == &background
  if &t_Co > 255
    hi IndentGuidesOdd  guibg=red   ctermbg=234
    hi IndentGuidesEven guibg=green ctermbg=236
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=234
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236
  else
    hi IndentGuidesOdd  guibg=red   ctermbg=Blue
    hi IndentGuidesEven guibg=green ctermbg=DarkBlue
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
  endif
endif


au BufNewFile,BufRead *.ejs set filetype=html


