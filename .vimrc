

"vim-plug:
"install itself
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'
Plug 'preservim/nerdtree'
"Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'severin-lemaignan/vim-minimap'
Plug 'justinmk/vim-sneak'
"Plug 'DoeringChristian/auto-pairs'
Plug 'DoeringChristian/VimIT'

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

"paring-test
function! GetKey(dict, value)
    return join(keys(filter(copy(a:dict), 'v:val ==# ' . string(a:value))))
endfunction

function! Values(dict)
    let ret = []
    for key in keys(a:dict)
        call add(ret, a:dict[key])
    endfor
    return ret
endfunction

function! HasValue(dict, value)
    return !empty(GetKey(a:dict, a:value))
endfunction

function! Goto(pos)
    let ret = ""
    if g:pos[1] > a:pos[1]
        let ret .= (g:pos[1]-a:pos[1]) . "h"
    elseif a:pos[1] > g:pos[1]
        let ret .= (a:pos[1]-g:pos[1]) . "l"
    endif
    if g:pos[0] > a:pos[0]
        let ret .= (g:pos[0]-a:pos[0]) . "k"
    elseif a:pos[0] > g:pos[0]
        let ret .= (a:pos[0]-g:pos[0]) . "j"
    endif
    let g:pos = a:pos
    return ret
endfunction

function! Delete(len)
    return repeat("x", a:len)
endfunction

let g:pairs = {"{":"}", "(":")", "'":"'", '"':'"', "[":"]"}
"let g:spairs = ["'", '"'] 

function! GetPrevKey()
    let max = 0
    let max_key = ""
    for key in keys(g:pairs)
        if col('.') > strlen(key) && strlen(key) > max && getline('.')[col('.')-strlen(key)-1:col('.')-2] ==# key 
            let max = strlen(key)
            let max_key = key
        endif
    endfor
    return max_key
endfunction

function! MatchRightKey(str)
    let line = getline('.')
    return col('.')+strlen(a:str)-1 <= strlen(line) && line[col('.')-1:col('.')+strlen(a:str)-2] ==# a:str
endfunction

function! GetLevelLine(pos, start, end)
    let i = a:pos[0]
    let j = 0
    let c = 0
    let line = getline(i)
    while j < a:pos[1]
        if strlen(line) - j >= strlen(a:start) && line[j:j+strlen(a:start)-1] ==# a:start
            if a:start ==# a:end
                if c > 0
                    let c = 1
                else
                    let c = 0
                endif
            else
                let c += 1
            endif
        elseif strlen(line) - j >= strlen(a:end) && line[j:j+strlen(a:end)-1] ==# a:end
            let c -= 1
        endif
        let j += 1
    endwhile
    return c
endfunction

function! GetLevel(pos, start, end)
    let i = 1
    let j = 0
    let c = 0
    while i < a:pos[0]
        let line = getline(i)
        while j < strlen(line)
            if strlen(line) - j >= strlen(a:start) && line[j:j+strlen(a:start)-1] ==# a:start
                let c += 1
            elseif strlen(line) - j >= strlen(a:end) && line[j:j+strlen(a:end)-1] ==# a:end
                let c -= 1
            endif
            let j += 1
        endwhile
        let j = 0
        let i += 1
    endwhile
    let j = 0 
    let line = getline(i)
    while j < a:pos[1]
        if strlen(line) - j >= strlen(a:start) && line[j:j+strlen(a:start)-1] ==# a:start
            let c += 1
        elseif strlen(line) - j >= strlen(a:end) && line[j:j+strlen(a:end)-1] ==# a:end
            let c -= 1
        endif
        let j += 1
    endwhile
    return c
endfunction

function! SearchPairPos(start, middle, end, flags)
    call cursor(line('.'), col('.')-1)
    let match = searchpairpos(a:start, a:middle, a:end, a:flags, 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string"')
    return match
endfunction

let g:ret = ""
let g:pos = [line('.'), col('.')]

function! Sub(pressed)
    let g:ret = ""
    let orig_pos = [line('.'), col('.')]
    let g:pos = [line('.'), col('.')]
    if a:pressed == "\<BS>"
        let line = getline('.')
        let key = GetPrevKey()
        if !empty(key)
            let match = SearchPairPos(key, "", g:pairs[key], "W")
            if match != [0,0]
                let ret = "\<Esc>"
                let ret .= Delete(strlen(key)) . Goto(match) . Delete(strlen(g:pairs[key]))
                let ret .= Goto(orig_pos) . "a"
                call cursor(orig_pos[0], orig_pos[1])
                return ret
            else
                return "\<BS>"
            endif
        else
            return "\<BS>"
        endif
    elseif has_key(g:pairs, a:pressed)
        let char = getline('.')[col('.')]
        "call input(MatchRightKey(")"))
        "call input(string(filter(copy(g:pairs), "MatchRightKey(v:val)")))
        if (char2nr(getline('.')[col('.')]) <= char2nr(" ") || !empty(filter(copy(g:pairs), "MatchRightKey(v:val)")))
            let key = GetKey(g:pairs, a:pressed)
            if !(synIDattr(synID(line("."), col("."), 0), "name") =~? "string")
                return a:pressed . g:pairs[a:pressed] . "\<Left>"
            elseif (GetLevelLine([line('.'), strlen(getline(line('.')))], key, a:pressed) <= 0 || key ==# a:pressed) && MatchRightKey(a:pressed)
                "if the pair is inside a comment but at the and and the pair
                "is a quote then escape it
                return "\<Right>"
            endif
        else
            return a:pressed
        endif
    elseif HasValue(g:pairs, a:pressed)
        let key = GetKey(g:pairs, a:pressed)
        if (GetLevelLine([line('.'), strlen(getline(line('.')))], key, a:pressed) <= 0 || key ==# a:pressed) && MatchRightKey(a:pressed)
            return "\<Right>"
        else
            return a:pressed
        endif
    elseif a:pressed == "\<CR>"
        let key_prev = GetPrevKey()
        let key_next = ""
        let line = getline('.')
        if !empty(key_prev) && searchpos(g:pairs[key_prev]) != [0,0] 
            let ws = line[col('.'):searchpos(g:pairs[key_prev])[0]-2] 
            if 1 "matchstr(ws, '\_s*') == ws
                return "\<CR>\<Esc><<O"
            endif
        endif
        return "\<CR>"
    else
        return a:pressed
    endif
endfunction

function! Init()
    for key in keys(g:pairs)
        if key == '"'
            execute "inoremap <expr> " . key . " Sub('" . key . "')"
        else
            execute 'inoremap <expr> ' . key . ' Sub("' . key . '")'
        endif
    endfor
    for value in Values(g:pairs)
        if value == '"'
            execute "inoremap <expr> " . key . " Sub('" . key . "')"
        else
            execute 'inoremap <expr> ' . value . ' Sub("' . value . '")'
        endif
    endfor
    execute 'inoremap <expr> <BS> Sub("\<BS>")'
    execute 'inoremap <expr> <CR> Sub("\<CR>")'
endfunction

autocmd BufEnter * :call Init()

"Insert line with enter
noremap <Enter> o<ESC>
noremap <S-Enter> O<ESC>

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

"minimap
let g:minimap_highlight='Visual'

"vimspector
"nmap <F5> <Plug>
let g:vimspector_enable_mappings = 'HUMAN'
"packadd! vimspector


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




