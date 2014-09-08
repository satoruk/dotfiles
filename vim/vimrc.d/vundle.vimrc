set nocompatible " be iMproved
filetype off     " required!

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" original repos on github
Plugin 'The-NERD-tree'
Plugin 'gmarik/vundle'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Shougo/neocomplcache'
Plugin 'elzr/vim-json'

" JavaScript
" mustache js template
Plugin 'juvenn/mustache.vim'


" git plugin
Plugin 'tpope/vim-fugitive'

" vim-scripts repos
"Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
"Bundle 'unite.vim'
colorscheme solarized

call vundle#end()


