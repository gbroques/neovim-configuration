"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set hybrid relative line numbers
" Hybrid line numbering is the same as the relative line numbering with the
" only difference being that the current line instead of showing 0 shows its
" absolute line number.
set number relativenumber

" Enable filetype plugin and indentation detection
filetype plugin indent on
" https://www.youtube.com/watch?v=Gs1VDYnS-Ac&list=PLesiP49zG6snB_Wp3wTeD5u8bc7sDuS5O&t=337s
set backspace=indent,eol,start

let $RTP=split(&runtimepath, ',')[0]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key to comma ','
let mapleader = ","

" Map leader s to save
noremap <Leader>s :update<CR>

" Map 'hh' to the Esc key
inoremap hh <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Install Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplug_exists=stdpath('config') . '/autoload/plug.vim'

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug - A minimalist Vim plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')

let $GIT_SSL_NO_VERIFY = 'true'
Plug 'joshdick/onedark.vim' " Theme
Plug 'itchyny/lightline.vim' " Status Line
Plug 'sheerun/vim-polyglot' " Better syntax high-lighting
Plug 'tpope/vim-surround'
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

