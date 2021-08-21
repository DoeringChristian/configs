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
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
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

" =========================================
" Navigation Plugins:
" =========================================
Plug 'ctrlpvim/ctrlp.vim'                                   " Fuzzy search.
Plug 'preservim/nerdtree'                                   " Tree on the left side of the screen.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " Fuzzy search.
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'                                " Adds bookmark indicator.

" =========================================
" Utility Plugins:
" =========================================
Plug 'puremourning/vimspector'                              " Adds debugger to vim.
Plug 'tpope/vim-dispatch'                                   " Run makefiles.
Plug 'sgur/ctrlp-extensions.vim'                            " Integrates CtrlP with YankRing.
Plug 'vim-scripts/YankRing.vim'                             " Keeps yank history.
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
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-xml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-texlab', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vimtex', {'do': 'yarn install --frozen-lockfile'}

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
set number 
set relativenumber 
syntax on
set is hls
"set virtualedit=all
let mapleader = " "
let g:mapleader = " "
map <Space> <leader>

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

"=========================================
" FZF:
"=========================================
" <c-t>: tab_split,
" <c-x>: split,
" <c-v>: vsplit

nnoremap <leader><tab> :FZF<CR>
nnoremap <leader><s-tab> :Rg<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>ag :Ag<CR>
nnoremap <leader>s :Lines<CR>
let g:fzf_layout = { 'down': '~40%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

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

"close brackets:

"inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == "\"" ? ( strpart(getline('.'), col('.')-2, 1) == "\\" ? "\"" : "\<Right>" ) : "\"\"\<Left>"
"inoremap <expr> '  strpart(getline('.'), col('.')-1, 1) == "\'" ? ( strpart(getline('.'), col('.')-2, 1) == "\\" ? "\'" : "\<Right>" ) : "\'\'\<Left>"
"inoremap ( ()<left>
"inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"inoremap [ []<left>
"inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"inoremap { {}<left>
""inoremap {<CR> {<CR><Tab><BS>}<ESC>O
"inoremap {<CR> {<CR><CR>}<UP><TAB>
"inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
"inoremap {;<CR> {<CR>};<ESC>O
""smart bracket:
"inoremap <expr> ; strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>;" : ";"
""inoremap ;) );

"=========================================
" Jumpmotion:
"=========================================
"hi! link JumpMotion Visual
"call execute("hi! JumpMotion ctermfg=" . synIDattr(hlID('SpellBad'), 'fg#'))
function! ReturnHighlightTerm(group, term)
   let output = execute('hi ' . a:group)
   return matchstr(output, a:term.'=\zs\S*')
endfunction

"hi! JumpMotion ctermfg=Red guifg=Red guibg=ReturnHighlightTerm(Visual, guibg)  
"call execute("hi! JumpMotion ctermfg=Red guifg=Red guibg=" . ReturnHighlightTerm("Visual", "guibg") . " ctermbg=" . ReturnHighlightTerm("Visual", "ctermbg") . " gui=bold cterm=bold" )
"call execute("hi! JumpMotionTail ctermfg=Red guifg=Red guibg=" . ReturnHighlightTerm("Visual", "guibg") . " ctermbg=" . ReturnHighlightTerm("Visual", "ctermbg") . " gui=NONE cterm=NONE" )

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
" Nerd Tree:
"=========================================
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif


autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Auto refresh on enter.
autocmd BufEnter NERD_tree_* | execute 'normal R'


"=========================================
" Coc:
"=========================================

"in case VimPlug not working
"let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-cmake', 'coc-json', 'coc-python', 'coc-sh', 'coc-xml', 'coc-html', 'coc-css', 'coc-texlab']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
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
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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


" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
map <leader>b <Plug>(easymotion-bd-w)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
"nmap <Leader>w <Plug>(easymotion-overwin-w)
let g:EasyMotion_smartcase = 1

"=========================================
" Polyglot:
"=========================================
let g:polyglot_disabled = ['sensible']

"=========================================
" Indentline:
"=========================================
let g:indentLine_char = '┊'
"let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'Normal'
" for gruvbox
let g:indentLine_color_gui = '#504945' 
let g:indentLine_color_term = 239

"=========================================
" Yoink:
"=========================================
"nmap <c-p> <plug>(YoinkPostPasteSwapBack)
"nmap <c-n> <plug>(YoinkPostPasteSwapForward)
"nmap <leader>p <plug>(YoinkPostPasteSwapBack)
"nmap <leader>n <plug>(YoinkPostPasteSwapForward)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)
"nmap gp <plug>(YoinkPaste_gp)
"nmap gP <plug>(YoinkPaste_gP)
"nmap [y <plug>(YoinkRotateBack)
"nmap ]y <plug>(YoinkRotateForward)

