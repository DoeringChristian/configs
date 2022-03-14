"=========================================
" My Vimrc:
"=========================================

"Copyright (c) 2021 Christian Döring
"
"Permission is hereby granted, free of charge, to any person obtaining a copy
"of this software and associated documentation files (the "Software"), to deal
"in the Software without restriction, including without limitation the rights
"to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
"copies of the Software, and to permit persons to whom the Software is
"furnished to do so, subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
"FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
"LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
"OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
"SOFTWARE.


"=========================================
" Requirements:
"=========================================
" - Vim 8+
"   - Python support
" - nodejs
" - yarn
" - clang
" - clangd/llvm
" - cmake
" - curl

"=========================================
" Vim-Plug:
"=========================================
"install itself
let data_dir = has('nvim') ? stdpath('data') . '/site' : $HOME . '/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"=========================================
" Language Packages:
"=========================================
if empty(glob(data_dir. '/spell/'))
    silent execute '!mkdir ' . data_dir . '/spell/'
    silent execute '!wget -P ' . data_dir . '/spell/ http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl'
    silent execute '!wget -P ' . data_dir . '/spell/ http://ftp.vim.org/vim/runtime/spell/de.utf-8.sug'
endif

set nocompatible

"=========================================
" Polyglot:
"=========================================
let g:polyglot_disabled = ['sensible']

"=========================================
" Vim-Plug:
"=========================================
call plug#begin(data_dir . '/plugged')

"=========================================
" Colorschemes:
"=========================================
Plug 'arcticicestudio/nord-vim' 
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
"Plug 'joshdick/onedark.vim'
"Plug 'ghifarit53/tokyonight-vim'
"Plug 'jacoborus/tender.vim'
"Plug 'tomasiser/vim-code-dark'
"Plug 'tomasr/molokai'
"Plug 'joshdick/onedark.vim'
"Plug 'sonph/onehalf', {'rtp': 'vim/'}

"=========================================
" Visual Plugins:
"=========================================
Plug 'sheerun/vim-polyglot'                                 " Polyglot for better syntax highlighting.
Plug 'yggdroot/indentline'                                  " Adds lines indecating indentation.
Plug 'severin-lemaignan/vim-minimap'                        " Adds minimap.
Plug 'vim-airline/vim-airline'                              " Adds status bar at the bottom.
Plug 'airblade/vim-gitgutter'                               " Git integration.
Plug 'romainl/vim-cool'                                     " Removes highlights after search.
Plug 'DingDean/wgsl.vim'                                    " Adds highlighting for wgsl

" =========================================
" Navigation Plugins:
" =========================================
Plug 'ctrlpvim/ctrlp.vim'                                   " Fuzzy search.
"Plug 'preservim/nerdtree'                                   " Tree on the left side of the screen.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " Fuzzy search.
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'                                " Adds bookmark indicator.
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" =========================================
" Utility Plugins:
" =========================================
Plug 'puremourning/vimspector'                              " Adds debugger to vim.
Plug 'tpope/vim-dispatch'                                   " Run makefiles.
Plug 'sgur/ctrlp-extensions.vim'                            " Integrates CtrlP with YankRing.
Plug 'vim-scripts/YankRing.vim'                             " Keeps yank history.
Plug 'vimwiki/vimwiki'                                      " Wiki in vim (<leader>nt)
Plug 'tpope/vim-fugitive'                                   " Git integration
Plug 'embear/vim-localvimrc'                                " Local .vimrc file
"Plug 'svermeulen/vim-yoink'

" =========================================
" Markdown Plugins:
" =========================================
Plug 'dhruvasagar/vim-table-mode'                           " Markdown table auto alignment.
                                                            " Adds markdown preview for vim.
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} 

" =========================================
" Motion Plugins:
" =========================================
Plug 'easymotion/vim-easymotion'                            " Adds easy shortcuts.
"Plug 'pechorin/any-jump.vim'                                " Jump to definitions
" Plug 'DoeringChristian/MoVim'

" =========================================
" Auto complete and formating plugins:
" =========================================
Plug 'DoeringChristian/VimIT'                               " Inline Templates/Snippets.
Plug 'junegunn/vim-easy-align'                              " Adds alignment functionality.
Plug 'vim-scripts/CmdlineComplete'                          " Allows completion in : CmdLine.
Plug 'neoclide/coc.nvim', {'branch': 'release'}             " Adds LSP integration.
Plug 'Krasjet/auto.pairs'                                   " Autopairs for brackets etc.
Plug 'tpope/vim-surround'                                   " Operations on surrounding characters.
Plug 'SirVer/ultisnips'                                     " Snippets Plugin.
Plug 'honza/vim-snippets'                                   " Snippets for Utilsnips

" =========================================
" Language specific plugins:
" =========================================
"Plug 'lervag/vimtex'

"Disabled Plugins
"Plug 'haya14busa/vim-easyoperator-line'
"Plug 'justinmk/vim-sneak'
"Plug 'DoeringChristian/auto-pairs'
"Plug 'zsugabubus/vim-jumpmotion'
"Plug 'jiangmiao/auto-pairs'
"Plug 'nathanaelkane/vim-indent-guides'

"=========================================
" Coc Extensions:
"=========================================
" Requires npm/node and yarn
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'} " requires clang and llvm or clangd
Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-xml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-texlab', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}
Plug 'Eric-Song-Nop/coc-glslx', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

"=========================================
" Vim:
"=========================================
set wildmenu
set autoindent
set nostartofline

if has('mouse')
  set mouse=a
endif

set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab
filetype plugin indent on
set number 
set relativenumber 
syntax on
set is hls
set scl=yes 
" Disabled due to lag
"set cursorline
"set cursorcolumn
set noautochdir
"set virtualedit=all
let mapleader = " "
let g:mapleader = " "
map <Space> <leader>

let undo_dir = data_dir . "/undodir"
if(!isdirectory(undo_dir))
    call mkdir(undo_dir)
endif
exe 'set undodir=' . undo_dir
set undofile

"=========================================
" Colorscheme:
"=========================================
" tokyonight
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1

"=========================================
" Gruvbox:
"=========================================
let g:gruvbox_contrast_dark = "hard"

"=========================================
" Colorscheme: (settings)
"=========================================
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

"true color support
if (has("termguicolors"))
  set termguicolors
endif

set encoding=utf-8

"=========================================
" Custom:
"=========================================
"mouse block select
noremap <RightMouse> <4-LeftMouse>
noremap <RightDrag> <LeftDrag>

"visual indent
vmap < <gv
vmap > >gv


"set spellchecking language
function! ChangeLanguage()
    let str = input("Language Code:")
    call execute ("setlocal spell spelllang=" . str)
    if(!empty(str))
        call execute ("set complete+=kspell")
    else
        call execute ("set complete-=kspell")
    endif
    return ""
endfunction

nnoremap <leader>l :call ChangeLanguage()<CR>

" add CTRL+Space for auto completion
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif

"Insert line with enter
noremap <Enter> o<ESC>
noremap <S-Enter> O<ESC>

" Init function
function! s:vim_init()
    try
        execute(':tcd %:p:h')
    catch
    endtry
endfunction

autocmd! VimEnter * call s:vim_init()

"=========================================
" FZF:
"=========================================
" <c-t>: tab_split,
" <c-x>: split,
" <c-v>: vsplit

nnoremap <leader><tab> :FZF<CR>
nnoremap <leader><s-tab> :Rgnf<CR>
nnoremap <leader>rg :Rgnf<CR>
nnoremap <leader>ag :Agnf<CR>
nnoremap <leader>s :Lines<CR>
nnoremap <leader>sl :Snippets<CR>
let g:fzf_layout = { 'down': '~40%' }
command! -bang -nargs=* Rgnf
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* Agnf call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

"=========================================
" CtrlP:
"=========================================
"let g:ctrlp_map = '<leader><tab>'
let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
            \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
            \ }
" Update of yankring is necesarray
map <leader>p :call yankring#collect() \| CtrlPYankring<cr>
"map <leader>s :CtrlPLine<cr>

"=========================================
" Vim-cool:
"=========================================
let g:CoolTotalMatches = 1

"=========================================
" Minimap:
"=========================================
let g:minimap_highlight='Visual'

"=========================================
" Vimspector:
"=========================================
"nmap <F5> <Plug>
let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector

"=========================================
" Autopairs:
"=========================================
let g:AutoPairsMultilineClose = 0


"=========================================
" Fern:
"=========================================
nnoremap <C-f> :Fern . -reveal=% -drawer -toggle <CR>

command Ferncd silent execute("windo tcd " . getcwd())

function! s:init_fern() abort
    nmap  <buffer>      o    <Plug>(fern-action-open:edit)
    nmap  <buffer>      go   <Plug>(fern-action-open:edit)<C-w>p
    nmap  <buffer>      t    <Plug>(fern-action-open:tabedit)
    nmap  <buffer>      T    <Plug>(fern-action-open:tabedit)gT
    nmap  <buffer>      s    <Plug>(fern-action-open:split)
    nmap  <buffer>      i    <Plug>(fern-action-open:split)
    nmap  <buffer>      v    <Plug>(fern-action-open:vsplit)
    nmap  <buffer>      ma   <Plug>(fern-action-new-path)
    nmap  <buffer>      mm   <Plug>(fern-action-move)
    nmap  <buffer>      md   <Plug>(fern-action-remove)
    nmap  <buffer>      mc   <Plug>(fern-action-copy)
    nmap  <buffer>      <CR> <Plug>(fern-action-open-or-expand)
    "nmap  <buffer>      <leader><CR> <Plug>(fern-action-enter)
    nmap  <buffer>      <leader><CR>  <Plug>(fern-action-enter) <Plug>(fern-action-tcd)
    nmap  <buffer>      <BS> <Plug>(fern-action-leave)
    nmap  <buffer>      P    gg
    nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
    nnoremap <buffer> zz zz

    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
    nmap <buffer> cd <Plug>(fern-action-cd)
    nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

    nmap <buffer> I <Plug>(fern-action-hide-toggle)
    nmap <buffer> H <Plug>(fern-action-hidden:toggle)

    nmap <buffer> q :<C-u>quit<CR>

    call feedkeys("\<Plug>(fern-action-tcd:root)")

    " workaround for updating every window to tabpath
    let curwin = winnr()
    silent execute("windo tcd " . getcwd())
    execute curwin . 'wincmd w'
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END

augroup fern-startup
    autocmd! *
    "autocmd VimEnter * Fern . -reveal=% -drawer -toggle
augroup END

let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

"=========================================
" Coc:
"=========================================

let g:coc_user_config = {
            \'diagnostic.enableSign': 'true',
            \'diagnostic.enableHighlightLineNumber': 'true',
            \'languageserver': {
                \"godot": {
                    \"host": "127.0.0.1",
                    \"filetypes": ["gd", "gdscript3"],
                    \"port": 6008,
                    \},
                    \},
            \}


if exists('g:vscode')
    :silent! CocDisable
endif

let g:coc_blacklist = []

function! s:disable_coc_for_type()
  if index(g:coc_blacklist, &filetype) == -1
    :silent! CocEnable
  else
    :silent! CocDisable
  endif
endfunction

function! s:coc_reload()
    :CocCommand rust-analyzer.reload
endfunction


augroup CocGroup
 autocmd!
 autocmd BufNew,BufEnter,BufAdd,BufCreate * call s:disable_coc_for_type()
augroup end

"in case VimPlug not working
"let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-cmake', 'coc-json', 'coc-python', 'coc-sh', 'coc-xml', 'coc-html', 'coc-css', 'coc-texlab']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=auto
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>a :CocAction<CR>
vmap <silent> <leader>a :CocAction<CR>
"nmap <silent> <leader>db :
nmap <silent> <leader>cfm: :Format<CR>
vmap <silent> <leader>fm: <Plug>(coc-format-selected)

" Language Specific: 

augroup coc_rust
    autocmd!
    autocmd FileType rust nmap <silent> <leader>rl :CocCommand rust-analyzer.reload<CR>
    autocmd FileType rust nmap <silent> <leader>db :CocCommand rust-analyzer.debug<CR>
    autocmd FileType rust nmap <silent> <leader>m :CocCommand rust-analyzer.expandMacro<CR>

    " Commands with r prefix: 
    autocmd FileType rust nmap <silent> <leader>rr :CocCommand rust-analyzer.run<CR>
    autocmd FileType rust nmap <silent> <leader>ras :CocCommand rust-analyzer.analyzerStatus<CR>
    autocmd FileType rust nmap <silent> <leader>rem :CocCommand rust-analyzer.expandMacro<CR>
    autocmd FileType rust nmap <silent> <leader>ree :CocCommand rust-analyzer.explainError<CR>
    autocmd FileType rust nmap <silent> <leader>rjl :CocCommand rust-analyzer.joinLines<CR>
    autocmd FileType rust nmap <silent> <leader>rmu :CocCommand rust-analyzer.moveItemUp<CR>
    autocmd FileType rust nmap <silent> <leader>rmd :CocCommand rust-analyzer.moveItemUp<CR>
    autocmd FileType rust nmap <silent> <leader>rod :CocCommand rust-analyzer.openDocs<CR>
    autocmd FileType rust nmap <silent> <leader>rpm :CocCommand rust-analyzer.parentModule<CR>
    autocmd FileType rust nmap <silent> <leader>rpT :CocCommand rust-analyzer.peekTests<CR>

    " Search and replace
    autocmd FileType rust nmap <silent> <leader>rsr :CocCommand rust-analyzer.ssr<CR>
    autocmd FileType rust nmap <silent> <leader>r/ :CocCommand rust-analyzer.ssr<CR> 
    autocmd FileType rust nmap <silent> <leader>rst :CocCommand rust-analyzer.syntaxTree<CR>
    autocmd FileType rust nmap <silent> <leader>rtih :CocCommand rust-analyzer.toggleInlayHints<CR>
    autocmd FileType rust nmap <silent> <leader>rhir :CocCommand rust-analyzer.viewHir<CR>
    autocmd FileType rust nmap <silent> <leader>rvg :CocCommand rust-analyzer.viewCrateGraph<CR>
    autocmd FileType rust nmap <silent> <leader>rvG :CocCommand rust-analyzer.viewFullCrateGraph<CR>
augroup END


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Symbol refactoring
nmap <leader>rf <Plug>(coc-refactor)


" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Easymotion fix for nvim
if has("nvim")
    autocmd User EasyMotionPromptBegin silent! CocDisable
    autocmd User EasyMotionPromptEnd silent! CocEnable
endif

"=========================================
" Easyalign:
"=========================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"=========================================
" Easymotion:
"=========================================
let g:yankring_zap_keys = ''
"map s <Plug>(easymotion-bd-f)
map f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)
map <leader>w <Plug>(easymotion-bd-w)
map <leader>e <Plug>(easymotion-bd-e)
map <leader>b <Plug>(easymotion-bd-w)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
"nmap <Leader>w <Plug>(easymotion-overwin-w)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_keys =  "wertzuiopghyxcvbnmalskdjf"
"let g:EasyMotion_keys = "qwertzuiopyxcvbnmghalskdjf"

"=========================================
" Polyglot:
"=========================================
let g:polyglot_disabled = ['sensible']

"=========================================
" Indentline:
"=========================================
let g:indentLine_char = '┊'

let g:indentLine_conceallevel = 1
let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = 'inc'
set conceallevel=1

"let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'Normal'
" for gruvbox
let g:indentLine_color_gui = '#504945' 
let g:indentLine_color_term = 239

"=========================================
" VimWiki:
"=========================================
let g:vimwiki_list = [{'path': '~/.vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_map_prefix = '<Leader>n'

" =========================================
" Utilsnips:
" =========================================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"
map <leader>ue :UltiSnipsEdit<CR>

let g:UltiSnipsSnippetDirectories=[data_dir . "/UltiSnips"]

"=========================================
" Local Vimrc:
"=========================================

"=========================================
" Custom:
"=========================================


