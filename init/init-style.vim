"=================================================
"
" init-style.vim - 显示样式设置
"
"=================================================

"-------------------------------------------------
" 显示设置
"-------------------------------------------------

" 总是显示状态栏
set laststatus=2

" 总是显示行号
set number

" 总是显示侧边栏(用于显示 mark/gitdiff/诊断信息)
" set signcolumn=yes

" 总是显示标签栏
set showtabline=2

" 右下角显示命令
set showcmd

" 字体设置
if has("win32") || has("win64")
    set guifont=Courier\ New:h12
elseif has("unix")
    set guifont=Monospace\ 12
endif

try
	colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme desert
endtry
