" Pretty typical stuff
syntax on
colorscheme slate
set number
set relativenumber
set nowrap

" Setting tabbing
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

set colorcolumn=80

" Custom keybinds
" Pressing enter adds a new line below the cursor and keeps it in the same position
noremap <CR> o<Esc>k
" Use jk to change from Insert mode to Normal mode 
ino jk <Esc>
cno jk <c-c>

" :w!! will still write a file if you didn't open it as root
cmap w!! w !sudo tee > /dev/null %
" :W is the same as :w
:command W w

" Return to last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

set splitbelow
set splitright

" Read modelines at the beginning of files
set modelines=1
set modeline
" Show matching brackets
set showmatch

" Spelling - default to spell check off, enable with :SPELL
:command SPELL setlocal spell spelllang=en_us
:command NOSPELL set nospell

" Change cursor in insert mode to be a vertical line
let &t_ti.="\<Esc>[1 q"
let &t_SI.="\<Esc>[5 q"
let &t_EI.="\<Esc>[1 q"
let &t_te.="\<Esc>[0 q"

" Set _ as a word delimiter
set iskeyword-=_
