""" Plugin management with vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin()
""" Files
" File navigation sidebar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Fuzzy finding with fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install --all' }
Plug 'junegunn/fzf.vim'
"Autosave
Plug '907th/vim-auto-save'

""" Programming
" Autocompletion for neovim
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'carlitux/deoplete-ternjs'
" Best GIT plugin?
Plug 'tpope/vim-fugitive'
" Gitk clone for vim
Plug 'gregsexton/gitv'
" Vim git gutter
Plug 'airblade/vim-gitgutter'
" Make and syntax checking
Plug 'neomake/neomake'
" More Javascript
Plug 'othree/yajs.vim', { 'for': 'javascript' }
" JsDoc for Javascript
Plug 'othree/jsdoc-syntax.vim'
Plug 'heavenshell/vim-jsdoc'
" Javascript indentation etc.
Plug 'gavocanov/vim-js-indent'
" JSON syntax
Plug 'elzr/vim-json'
" Node.js support
Plug 'moll/vim-node'
" Autocompletion for Javascript
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Syntax Range
Plug 'vim-scripts/SyntaxRange'
" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

""" Documentation and writing
" Pandoc support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Integration of graphviz syntax (dot, ...)
Plug 'wannesm/wmgraphviz.vim'
" Org-mode for vim
Plug 'jceb/vim-orgmode'
" Narrow feature from emacs
Plug 'chrisbra/NrrwRgn'
" LaTeX
Plug 'lervag/vimtex'

""" Editing
" easy switching of function arguments
Plug 'PeterRincker/vim-argumentative'
" easy commenting in source code
Plug 'scrooloose/nerdcommenter'
" surround areas with stuff
Plug 'tpope/vim-surround'
" auto-pair braces and paranthesis
Plug 'jiangmiao/auto-pairs'
" C-A/C-X for dates
Plug 'tpope/vim-speeddating'
" Easy mass editing of the quickfix list
Plug 'Olical/vim-enmasse'
" Aligning
Plug 'junegunn/vim-easy-align'
" searching with f<char>
Plug 'rhysd/clever-f.vim'
" search with s<char1><char2>
Plug 'justinmk/vim-sneak'
" Undo tree navigation
Plug 'mbbill/undotree'
" Tab completion on the command line
Plug 'vim-scripts/CmdlineComplete'
" Toggel locationlist and quickfix list
Plug 'milkypostman/vim-togglelist'

""" UI
" colorscheme
Plug 'https://github.com/freeo/vim-kalisi'
" fancy and lightweight statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" starting page with MRU files etc
Plug 'mhinz/vim-startify'
" 
Plug 'tomtom/quickfixsigns_vim'
" Calendar view
Plug 'mattn/calendar-vim'

" Some sensible defaults
Plug 'tpope/vim-sensible'

" vim
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
call plug#end()

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Ultisnips
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_map_prefix = "<Leader>"
  let g:tern_request_timeout = 1
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  let g:tern#command = ["tern"]
  let g:tern#arguments = ["--persistent"]

  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" NERDTree
nnoremap <silent><F12> :NERDTreeToggle<Cr>
let NERDTreeIgnore = ['\.aux$', '\.bbl$', '\.bcf$', '\.blg$','\.fdb_latexmk$', '\.fls$','\.log$', '\.lof$', '\.lol$', '\.out$', '\.run.xml$', '\.synctex.gz$', '\.toc$', '\~$']
" vim-airline
let g:airline_theme='kalisi'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"let g:airline_left_sep=''
"let g:airline_left_alt_sep='|'
"let g:airline_right_sep=''
"let g:airline_right_alt_sep='|'
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'

" neomake
autocmd! BufWritePost * Neomake

" fzf.vim

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Open buffers in fzf
function! s:buflist()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" Filtered v:oldfiles and open buffers
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" Jump to tags
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| ag -v ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()


" Typescript
autocmd FileType typescript nmap <buffer> <Leader>h : <C-u>echo tsuquyomi#hint()<CR>
" checkers
let g:tsuquyomi_disable_quickfix = 1
let g:neomake_lint_maker = {
      \ 'exe': './node_modules/typescript/bin/tsc',
      \ 'args': ['%:p'],
      \ }

" Javascript specifics
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" General Mappings
let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"
" save with space f s
nnoremap <silent> <LocalLeader>fs :w<CR>
"nnoremap ; :
nnoremap Q @q
nnoremap <silent> <Leader>bd :bdelete<CR>
nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>

nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>so :so %<CR>
nnoremap <Leader>w <C-W>

nnoremap <C-T> :Tags<CR>
nnoremap <Leader>r :FZFMru<CR>
nnoremap <Leader>a :Ag

function! ShowTODOFIXME()
  let searchterm = 'TODO|FIXME'
  call fzf#vim#ag(searchterm)
endfunction

nnoremap <Leader>t :call ShowTODOFIXME()<CR>
nnoremap <Leader>fo :Files<CR>
inoremap jk <esc><esc>

" UI
" Line numbers
set nu
set relativenumber

" Colors
let t_Co=256
" in case t_Co alone doesn't work, add this as well:
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set expandtab
set shiftwidth=2
set softtabstop=2

colorscheme kalisi
set background=dark

" Tell Vim which characters to show for expanded TABs,
" " trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif
  set list                " Show problematic characters.

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\|\t/

" General settings
" nerditya.com/code/guide-to-neovim/
set linespace=0
set nojoinspaces
set splitbelow
set splitright

if !&scrolloff
    set scrolloff=3
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set nostartofline

set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault
set magic
set noshowmode
set showcmd
set smartindent

" Setup autosave plugin, off by default, enable with :AutoSaveToggle
let g:auto_save = 0
let g:auto_save_in_insert_mode = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:auto_save_silent = 1

" custom mappings
" paste from register 0
xnoremap <leader>p "0p
" edit init.vim
nnoremap <silent><leader>ec :e $MYVIMRC<CR>

" toggle lists
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>L :call ToggleLocationList()<cr>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<cr>

" vimbits mappings
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" vimtex
let g:vimtex_format_enabled = 1
let g:vimtex_latexmk_options = '-xelatex -synctex=1 -file-line-error -pdf -interaction=nonstopmode'
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_use_temp_files = 0
let g:vimtex_latexmk_progname = '/usr/local/bin/nvr'
" make it work with deoplete
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ .')'

set undofile
set undodir=~/.config/nvim/undo
" undotree
nnoremap <silent> <Leader>ut :UndotreeToggle<CR>
nnoremap <silent> <Leader>uf :UndotreeFocus<CR>

" easyalign
vmap <Enter> <Plug>(EasyAlign)
