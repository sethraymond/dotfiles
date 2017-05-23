syntax on
colorscheme slate
set number
set nowrap

set ts=4
set smartindent
set tabstop=4
set shiftwidth=4

set colorcolumn=80

nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k
ino jk <Esc>
cno jk <c-c>

cmap w!! w !sudo tee > /dev/null %

