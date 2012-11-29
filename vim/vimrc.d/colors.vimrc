""""""""""""""""""""""""
" colors.vimrc
"

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
"  autocmd VimEnter,Colorscheme * :hi Cursor ctermbg=233
endif


if 'dark' == &background
  if &t_Co > 255
    hi IndentGuidesOdd  guibg=red   ctermbg=235
    hi IndentGuidesEven guibg=green ctermbg=237
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=235
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=237
  else
    hi IndentGuidesOdd  guibg=red   ctermbg=Blue
    hi IndentGuidesEven guibg=green ctermbg=DarkBlue
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
  endif
endif




