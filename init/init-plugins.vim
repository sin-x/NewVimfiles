"=================================================
"
" init-plugin.vim - 插件管理(使用 Plug 管理)
"       
"       - default
"           - lightline
"           - vim-cursorword
"           - auto-pairs
"           - vim-easymotion
"       - basic
"           - indentLine
"           - vim-matchup
"           - supertab
"           - vim-surround
"           - vim-easy-align
"       - nerdtree
"           - nerdtree
"           - vim-nerdtree-syntax-highlight
"       - fzf
"           - fzf
"           - fzf.vim
"       - systemverilog
"           - verilog_systemverilog
"           - FastFold
"       - colors
"           - vim-colors-solarized
"           - onehalf
"
"=================================================

"-------------------------------------------------
" 默认情况下的分组，可以在前面覆盖掉
"-------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group  = ['basic', 'nerdtree']
    let g:bundle_group += ['colors']
    let g:bundle_group += ['fzf']
    " let g:bundle_group += ['systemverilog']
    let g:bundle_group += ['snippets']
    let g:bundle_group += ['lsp']
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let s:bundle_home = s:home."/../plugged"
let s:lsp_servers = s:home."/../vim-lsp/servers"

packadd! matchit

call plug#begin(s:bundle_home)

"-------------------------------------------------
" 默认插件
"-------------------------------------------------
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-cursorword'
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

"-------------------------------------------------
" Basic
"-------------------------------------------------
if index(g:bundle_group, 'basic') >= 0
    Plug 'Yggdroot/indentLine'
    Plug 'andymass/vim-matchup'
    Plug 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "<c-p>"
    " 展示开始画面，显示最近编辑过的文件
    " Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

    " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    Plug 'kshenoy/vim-signature'
    Plug 'vim-scripts/AutoComplPop'

    Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
endif

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
        if line('$') < 2000
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

"-------------------------------------------------
" colors   
"-------------------------------------------------
if index(g:bundle_group, 'colors') >= 0
    Plug 'altercation/vim-colors-solarized'
    " set background=dark
    " colorscheme solarized
    " let g:solarized_termcolors=256

    Plug 'sonph/onehalf', { 'rtp': 'vim' }
endif

if index(g:bundle_group, 'snippets') >= 0
    " Plug 'jayli/vim-easycomplete'

    " Track the engine.
    Plug 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'

    " Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
    " - https://github.com/Valloric/YouCompleteMe
    " - https://github.com/nvim-lua/completion-nvim
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
endif

if index(g:bundle_group, 'lsp') >= 0
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    let g:lsp_settings_servers_dir = s:lsp_servers
    " let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
    let g:lsp_diagnostics_float_cursor = 1
    let g:lsp_diagnostics_virtual_text_enabled = 0
    " set foldmethod=expr
    "   \ foldexpr=lsp#ui#vim#folding#foldexpr()
    "   \ foldtext=lsp#ui#vim#folding#foldtext()

    let g:lsp_settings = {
            \     'verible-verilog-ls' : {
            \       'allowlist': ['verilog_systemverilog', 'verilog', 'systemverilog']
            \     }
            \ }
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

