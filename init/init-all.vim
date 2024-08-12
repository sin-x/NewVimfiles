" 检测文件类型
filetype on
filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""
" 设置默认解码
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

" 不使用vi的键盘模式
set nocompatible

" history 文件中需要记录的行数
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 语法高亮
syntax on

"""""""""""""""""""""""""""""""""""""
" color scheme
"""""""""""""""""""""""""""""""""""""
set background=dark
colo desert
set guifont=Courier_New:h14

"""""""""""""""""""""""""""""""""""""
" 文件设定
"""""""""""""""""""""""""""""""""""""
set nobackup 

set number
set smartcase
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set showtabline=2

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
set noswapfile
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" 在状态行上显示光标所在位置的行号和列号
set ruler

" 命令行的高度
set cmdheight=2

" 使用 backspace 正常处理 indent, eol, start等
set backspace=2

" 启动的时候不显示援助索马里儿童的提示
set shortmess=atI

" 通过使用 :commands 命令，显示哪里被改变过
set report=0

" 在被分割的窗口显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"""""""""""""""""""""""""""""""""""""
" 搜索和匹配
"""""""""""""""""""""""""""""""""""""
set matchtime=5

" 搜索的时候忽略大小写
set ignorecase
set smartcase

" 高亮搜索的单词
set hlsearch

" 在搜索时，输入的词句逐字符高亮（类似firefox的搜索）
set incsearch

" 输入 :set list 命令时应该显示些啥
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 光标移动道buffer的顶部和底部时保持3行的距离
set scrolloff=3

"""""""""""""""""""""""""""""""""""""
" 状态行
"""""""""""""""""""""""""""""""""""""
set showcmd

set splitright

" 总是显示状态行
set laststatus=2

set cuc
set cul

set wildmenu
set wildmode=list,full
set completeopt=menu,menuone

set novisualbell
set vb t_vb=
au GuiEnter * set t_vb=

"""""""""""""""""""""""""""""""""""""
" keymap
"""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""
" 文本格式和排版
"""""""""""""""""""""""""""""""""""""
" 自动格式化
set formatoptions=tcrqn

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进(verilog_systemverilog插件不能有这个选项)
" set smartindent

" 使用 C 样式的缩进
set cindent

" 在行和段开始处使用制表符
set smarttab

"""""""""""""""""""""""""""""""""""""
" folding
"""""""""""""""""""""""""""""""""""""
set foldenable

set foldmethod=syntax
if has('autocmd')
    autocmd FileType python setlocal foldmethod=indent
endif

nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"""""""""""""""""""""""""""""""""""""
" Plugin (使用 plug 管理)
"""""""""""""""""""""""""""""""""""""
call plug#begin('D:\\vim\\plugin\\')
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/indentLine-master'
Plug 'vim-scripts/verilog_systemverilog.vim-master'
Plug 'vim-scripts/FastFold-master'
Plug 'vim-scripts/vim-cursorword-master'
Plug 'vim-scripts/vim-matchup-master'
Plug 'vim-scripts/supertab-main'
Plug 'jiangmiao/auto-pairs'
call plug#end()

"""""""""""""""""""""""""""""""""""""
" AutoPairs
"""""""""""""""""""""""""""""""""""""
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}

"""""""""""""""""""""""""""""""""""""
" gf(go to file)
"   : let 'gf' can go to file like $(project)/file.mk
"""""""""""""""""""""""""""""""""""""
set isfname+=(,)

function! OwnGfExpression(fname)
    " let 'gf' can go to file like $(project)/file.mk
    " the first character should be in A-Z or a-z
    let l:fname = substitute(a:fname, '$(\([A-Za-z]\w\+\))', '$\1', 'g')

    " Handle the situation like : project/file.mk(50)
    let l:line = matchstr(l:fname, '(\d\+)')

    if l:line != ''
        let l:fname = substitute(l:fname, '(\(\d\+\))', '', 'g')
    endif

    return l:fname
endfunction

set includeexpr=OwnGfExpression(v:fname)


"""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""
" verilog_systemverilog
"""""""""""""""""""""""""""""""""""""
packadd! matchit
let b:match_ignorecase = 1

let g:SuperTabDefaultCompletionType = 'context'

let g:verilog_verbose = 1
let g:verilog_efm_uvm_lst = 'all'

augroup systemverilog_settings_2
    au!
    
    au Filetype verilog_systemverilog call SystemVerilogFoldSettings()
augroup END

syntax enable

function! SystemVerilogFoldSettings()
    if line('$') < 8000
        let g:verilog_syntax_fold_lst = "function, task"
    else
        let g:verilog_syntax_fold_lst = ""
    endif
endfunction

