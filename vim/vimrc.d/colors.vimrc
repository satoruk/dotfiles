""""""""""""""""""""""""
" colors.vimrc
"

""""""""""""""""""""""""
" Color Scheme
"
set t_Co=256
set background=dark " dark or light

if 'dark' == &background
  hi Normal  ctermbg=black guibg=black
  hi Cursor  ctermbg=233
  hi NonText ctermbg=233 ctermfg=239
  hi Visual  ctermbg=236
"  autocmd VimEnter,Colorscheme * :hi Normal guibg=black ctermbg=black
"  autocmd VimEnter,Colorscheme * :hi Cursor ctermbg=233
endif


if 'dark' == &background
  if &t_Co > 255
    hi IndentGuidesOdd  ctermbg=235 guibg=red
    hi IndentGuidesEven ctermbg=237 guibg=green
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235 guibg=red
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237 guibg=green
  else
    hi IndentGuidesOdd  ctermbg=Blue     guibg=red
    hi IndentGuidesEven ctermbg=DarkBlue guibg=green
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=3 guibg=red
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=4 guibg=green
  endif
endif




