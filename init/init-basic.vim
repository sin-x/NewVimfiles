"-------------------------------------------------
" 一般设定
"-------------------------------------------------

" 禁用 vi 兼容模式
set nocompatible

" 设置 Backspace 键模式
set backspace=eol,start,indent

" 自动缩进
set autoindent

" 打开 C/C++ 语言缩进优化
set cindent

" 自动格式化
set formatoptions=tcrqn

" 在行和段开始处使用制表符
set smarttab

" 打开功能键超时检测(终端下功能键为一串ESC开头的字符串)
set ttimeout

" 功能键超市检测 50 毫秒
set ttimeoutlen=50

" 显示光标位置
set ruler

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

"-------------------------------------------------
" 搜索设置
"-------------------------------------------------

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch


"-------------------------------------------------
" 编码设置
"-------------------------------------------------
if has('multi_byte')
    " 内部工作编码
    set encoding=utf-8

    " 文件默认编码
    set fileencoding=utf-8

    " 打开文件时自动尝试下面顺序的编码
    set fileencodings=utf-8,ucs-bom,gbk,gb18030,big5,euc-jp,latin1
endif


"-------------------------------------------------
" 允许 Vim 自带脚本根据文件类型自动设置缩进等
"-------------------------------------------------
if has('autocmd')
    filetype plugin indent on
endif


"-------------------------------------------------
" 语法高亮设置
"-------------------------------------------------
if has('syntax')
    syntax enable
    syntax on
endif


"-------------------------------------------------
" 其他设置
"-------------------------------------------------

" 显示匹配的括号
set showmatch

" 显示括号匹配的时间
set matchtime=2

" 显示最后一行
set display=lastline

" 输入 :set list 命令时应该显示些啥
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 光标移动道buffer的顶部和底部时保持3行的距离
set scrolloff=3

set cuc
set cul

" 通过使用 :commands 命令，显示哪里被改变过
set report=0

" 在被分割的窗口显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" 字符间插入的像素行数目
set linespace=0

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
set noswapfile
set bufhidden=hide

" history 文件中需要记录的行数
set history=100

"-------------------------------------------------
" 状态栏
"-------------------------------------------------

" 允许下方显示目录
set wildmenu
set wildmode=list,full
set completeopt=menu,menuone

" 延迟绘制（提升性能）
set lazyredraw

" 命令行的高度
set cmdheight=2

" 文件换行符，默认使用 unix 换行符
" set ffs=unix,dos,mac
set ff=unix

"-------------------------------------------------
" Bell
"-------------------------------------------------

set novisualbell
set vb t_vb=
au GuiEnter * set t_vb=

"-------------------------------------------------
" 设置代码折叠
"-------------------------------------------------
if has('folding')
    " 允许代码折叠
    set foldenable

    " 代码折叠默认使用syntax
    set foldmethod=syntax

    if has('autocmd')
        autocmd FileType python setlocal foldmethod=indent
    endif
endif

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
