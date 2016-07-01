call plug#begin()
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-speeddating'
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'othree/jsdoc-syntax.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'gavocanov/vim-js-indent'
Plug 'elzr/vim-json'
Plug 'moll/vim-node'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Autocompletion for Javascript
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs'


" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rhysd/clever-f.vim'
Plug 'justinmk/vim-sneak'

" UI
Plug 'https://github.com/freeo/vim-kalisi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'spolu/dwm.vim'
Plug 'mhinz/vim-startify'
Plug 'tomtom/quickfixsigns_vim'

" Some sensible defaults
Plug 'tpope/vim-sensible'
call plug#end()

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
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


" Javascript specifics
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" General Mappings
let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"
nnoremap <silent> <LocalLeader>fs :w<CR>
"nnoremap ; :
nnoremap Q @q
nnoremap <silent> <Leader>bd :bdelete<CR>
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

if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set undofile
set undodir=~/.config/nvim/undo
