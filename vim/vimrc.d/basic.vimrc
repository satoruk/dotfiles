""""""""""""""""""""""""
" basic.vimrc
"

syntax on
filetype plugin indent on

set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,default,latin1
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:$
set list
set number
set laststatus=2
set cursorline
set backspace=2


" Mode line
set modeline
set modelines=5

set mouse=a

set autoread
set autowrite
set hidden
set nowrap

" Disable backup and swap files
set nowritebackup
set nobackup
set noswapfile

" Fold
set foldmethod=manual
autocmd FileType ruby :set foldmethod=indent
autocmd FileType ruby :set foldlevel=99
autocmd FileType ruby :set foldnestmax=99
autocmd FileType coffee :set foldmethod=indent
autocmd FileType coffee :set foldlevel=99
autocmd FileType coffee :set foldnestmax=99
autocmd FileType yaml :set foldmethod=indent
autocmd FileType yaml :set foldlevel=99
autocmd FileType yaml :set foldnestmax=99

" ウィンドウの移動の度に自動読み込み
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

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

" 拡張子毎の設定

" Javascript
au BufNewFile,BufRead *.ejs set filetype=html

" PHP
au BufNewFile,BufRead *.php set tabstop=4 shiftwidth=4

" Digdag
au BufNewFile,BufRead *.dig set filetype=yaml

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
"起動時に有効
let g:neocomplcache_enable_at_startup = 1
"自動補完を行う入力数を設定。初期値は2
let g:neocomplcache_auto_completion_start_length = 2
"手動補完時に補完を行う入力数を制御。値を小さくすると文字の削除時に重くなる
let g:neocomplcache_manual_completion_start_length = 3


