"=================================================
"
" init-plugin.vim - 插件管理(使用 Plug 管理)
"
"=================================================

"-------------------------------------------------
" 默认情况下的分组，可以在前面覆盖掉
"-------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'nerdtree']
    let g:bundle_group += ['fzf']
    let g:bundle_group += ['systemverilog']
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let s:bundle_home = s:home."/../plugged"

packadd! matchit

call plug#begin(s:bundle_home)

"-------------------------------------------------
" 默认插件
"-------------------------------------------------
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-cursorword'

if index(g:bundle_group, 'basic') >= 0
    Plug 'Yggdroot/indentLine'
    Plug 'andymass/vim-matchup'
    Plug 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "<c-n>"
    " 展示开始画面，显示最近编辑过的文件
	" Plug 'mhinz/vim-startify'
endif

"-------------------------------------------------
" AutoPairs
"-------------------------------------------------
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

"-------------------------------------------------
" systemverilog
"-------------------------------------------------
if index(g:bundle_group, 'systemverilog') >= 0
    Plug 'vhda/verilog_systemverilog.vim'
    Plug 'vim-scripts/FastFold'

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
            let g:verilog_syntax_fold_lst = "function,task"
        else
            let g:verilog_syntax_fold_lst = ""
        endif
    endfunction
endif

"-------------------------------------------------
" NERDTree
"-------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " let g:NERDTreeMinimalUI = 1
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeHijackNetrw = 0
    noremap <space>nn :NERDTree<cr>
    noremap <space>no :NERDTreeFocus<cr>
    noremap <space>nm :NERDTreeMirror<cr>
    noremap <space>nt :NERDTreeToggle<cr>

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_tab_\d\+\|NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_tab_\d\+\|NERD_tree_\d\+' && winnr('$') > 1 |
                \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
endif

"-------------------------------------------------
" FZF   
"-------------------------------------------------
if index(g:bundle_group, 'fzf') >= 0
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
endif

call plug#end()

"-------------------------------------------------
" gf(go to file)
"   : let 'gf' can go to file like $(project)/file.mk
"-------------------------------------------------
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
