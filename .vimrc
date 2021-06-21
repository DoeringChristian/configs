

"vim-plug:
"install itself
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"install language packs
if empty(glob(data_dir. '/spell/'))
    silent execute '!mkdir ' . data_dir . '/spell/'
    silent execute '!wget -P ' . data_dir . '/spell/ http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl'
    silent execute '!wget -P ' . data_dir . '/spell/ http://ftp.vim.org/vim/runtime/spell/de.utf-8.sug'
endif

call plug#begin(data_dir . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'preservim/nerdtree'
Plug 'Krasjet/auto.pairs'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'severin-lemaignan/vim-minimap'
Plug 'DoeringChristian/VimIT'
Plug 'DoeringChristian/MoVim'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/CmdlineComplete'
Plug 'romainl/vim-cool'
Plug 'vim-scripts/YankRing.vim'


"Disabled Plugins
"Plug 'justinmk/vim-sneak'
"Plug 'DoeringChristian/auto-pairs'
"Plug 'zsugabubus/vim-jumpmotion'
"Plug 'easymotion/vim-easymotion'
"Plug 'jiangmiao/auto-pairs'

"coc extensions:
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
colorscheme nord

"true color support
if (has("termguicolors"))
  set termguicolors
endif

set encoding=utf-8

"mouse block select
noremap <RightMouse> <4-LeftMouse>
noremap <RightDrag> <LeftDrag>


"set spellchecking language
function! ChangeLanguage()
    let str = input("Language Code:")
    call execute ("setlocal spell spelllang=" . str)
    return ""
endfunction

nnoremap <leader>l :call ChangeLanguage()<CR>

"test-movim

"fzf

nnoremap <leader><tab> :FZF<CR>

"Insert line with enter
noremap <Enter> o<ESC>
noremap <S-Enter> O<ESC>

"MoVim keybindings

"vim-cool
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

"jumpmotion
"hi! link JumpMotion Visual
"call execute("hi! JumpMotion ctermfg=" . synIDattr(hlID('SpellBad'), 'fg#'))
function! ReturnHighlightTerm(group, term)
   let output = execute('hi ' . a:group)
   return matchstr(output, a:term.'=\zs\S*')
endfunction

"hi! JumpMotion ctermfg=Red guifg=Red guibg=ReturnHighlightTerm(Visual, guibg)  
"call execute("hi! JumpMotion ctermfg=Red guifg=Red guibg=" . ReturnHighlightTerm("Visual", "guibg") . " ctermbg=" . ReturnHighlightTerm("Visual", "ctermbg") . " gui=bold cterm=bold" )
"call execute("hi! JumpMotionTail ctermfg=Red guifg=Red guibg=" . ReturnHighlightTerm("Visual", "guibg") . " ctermbg=" . ReturnHighlightTerm("Visual", "ctermbg") . " gui=NONE cterm=NONE" )

"minimap
let g:minimap_highlight='Visual'

"vimspector
"nmap <F5> <Plug>
let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector

"Autopairs:
let g:AutoPairsMultilineClose = 0

"Nerd Tree:
autocmd VimEnter * NERDTree | wincmd p
autocmd BufWinEnter * silent NERDTreeMirror
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufEnter NERD_tree_* | execute 'normal R'

"Coc:

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




