let mapleader=" "
nnoremap <SPACE> <Nop>

inoremap jk <esc>

nnoremap <silent> <Up> gk
inoremap <silent> <Up> <C-o>gk
nnoremap <silent> <Down> gj
inoremap <silent> <Down> <C-o>gj

nnoremap zz zz8<C-e>
nnoremap <leader>w :w<return>
nnoremap <leader>q :q<return>

" Formatting tex
vnoremap gw =
nnoremap gw =
nnoremap gww ==

onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
vnoremap i$ T$ot$

vnoremap u <Nop>
vnoremap U <Nop>

" copy to system clipboard
vnoremap <leader>d "+d
vnoremap <leader>y "+y
noremap <leader>p "+p

" vnoremap p _"p

vnoremap // y/<C-r>0<Return>

set relativenumber
set number
