"=================================================
"
" init-keymaps.vim - 按键设置
"
"   - 快速移动
"
"=================================================

"-------------------------------------------------
" keymap
"-------------------------------------------------
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

xnoremap <C-h> <Left>
xnoremap <C-j> <Down>
xnoremap <C-k> <Up>
xnoremap <C-l> <Right>

nnoremap <space><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
