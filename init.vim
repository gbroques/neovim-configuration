"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set hybrid relative line numbers
" Hybrid line numbering is the same as the relative line numbering with the
" only difference being that the current line instead of showing 0 shows its
" absolute line number.
set number relativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key to comma ','
let mapleader = ","

" Map leader s to save
noremap <Leader>s :update<CR>

" Map 'jk' to the Esc key
inoremap jk <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug - A minimalist Vim plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')

Plug 'joshdick/onedark.vim' " Theme
Plug 'itchyny/lightline.vim' " Status Line
Plug 'sheerun/vim-polyglot' " Better syntax high-lighting
Plug 'uiiaoo/java-syntax.vim' " Java syntax high-lighting not supported in vim-polygot

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to 1 if you want to hide end-of-buffer filler lines (~) for a cleaner look
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
syntax on
colorscheme onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

