call plug#begin('~/.vim/plugged')
    Plug 'vim-python/python-syntax'
    Plug 'uiiaoo/java-syntax.vim'
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdtree'
    Plug 'morhetz/gruvbox'
call plug#end()

filetype plugin indent on
syntax enable
set backspace=indent,eol,start
set ruler
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set tabpagemax=20
set nohlsearch
set laststatus=2
let g:mwDefaultHighlightingPalette = 'maximum'
set fillchars=fold:\ 
set number relativenumber
set noshowcmd
set wildmenu
set showmatch
set incsearch
set esckeys
set timeoutlen=1000 ttimeoutlen=10
set t_Co=256
set clipboard=unnamedplus
set noshowmode
set lazyredraw
let mapleader = ","
set modifiable
set ttymouse=sgr
set formatoptions-=cro
set hidden
set cmdheight=3
set shortmess+=IaWFc

"NERD TREE
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
let g:NERDTreeWinSize=20
let g:NERDTreeMinimalUI = v:true

set background=dark
colorscheme gruvbox
let g:python_highlight_all = 1
autocmd BufRead,BufNewFile * syn match VwisdCurly /{/ | hi VwisdCurly ctermbg=none cterm=bold ctermfg=19
autocmd BufRead,BufNewFile * syn match VwisdCurly /}/ | hi VwisdCurly ctermbg=none cterm=bold ctermfg=19
autocmd BufRead,BufNewFile * syn match VwisdPar /[()]/ | hi VwisdPar ctermbg=none cterm=none ctermfg=20
autocmd BufRead,BufNewFile * syn match VwisdSemiColon /;/ | hi VwisdSemiColon ctermbg=none cterm=none ctermfg=226
hi Normal 	  			ctermfg=250 cterm=NONE ctermbg=NONE
hi LineNr 				ctermfg=178 cterm=NONE ctermbg=NONE
hi Comment    			ctermfg=75 cterm=NONE ctermbg=NONE
hi EndOfBuffer ctermfg=23
hi Todo term=bold cterm=bold ctermbg=176 ctermfg=165
hi StatusLine   term=bold cterm=bold ctermbg=178 ctermfg=233
hi StatusLineNC term=bold cterm=bold ctermbg=178 ctermfg=233

nnoremap <silent> <tab>u :hi Comment ctermfg=177<cr> <bar> :hi Todo ctermbg=176 ctermfg=165<cr>
nnoremap <silent> <tab>i :hi Comment ctermfg=23<cr> <bar> :hi Todo ctermbg=23 ctermfg=23<cr>

vnoremap <esc><esc> <c-\><c-n>
tnoremap <esc><esc> <c-\><c-n>
cnoremap <esc><esc> <c-c>

nnoremap <silent> <tab><tab> <c-i>
nnoremap <silent> <s-tab><s-tab> <c-o>

function! Exit()
    execute "normal! :q!\<cr>"
endfunction

nnoremap <C-S-j> :m .+1<CR>==
nnoremap <C-S-k> :m .-2<CR>==
inoremap <C-S-j> <esc>:m .+1<CR>==gi
inoremap <C-S-k> <esc>:m .-2<CR>==gi
vnoremap <C-S-j> :m '>+1<CR>gv=gv
vnoremap <C-S-k> :m '<-2<CR>gv=gv
nnoremap <CR> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
noremap <silent> <Space> V
nnoremap <silent> <Space> V
vnoremap <silent> u :call vwisd#line#Comment()<cr>
vnoremap <silent> o :call vwisd#line#Uncomment()<cr>
inoremap <silent> <esc>l $
nnoremap <silent> <esc>l $
vnoremap <silent> <esc>l $<left>
nnoremap p p=`]
nnoremap P P=`]

function! Alt(char)
  if has('gui_running') | return ' <Alt'.a:char.'> ' 
      \ | else | return ' <esc>'.a:char.' '|endif
endfunction
execute 'inoremap <silent>'.Alt('p').'<esc>pi<right>'
execute 'inoremap <silent>'.Alt('P').'<esc>Pi'
execute 'inoremap <silent>'.Alt('a').'<esc>ggVG'
execute 'noremap <silent>'.Alt('a').'<esc>ggVG'
execute 'nnoremap <silent>'.Alt('a').'<esc>ggVG'
execute 'vnoremap <silent>'.Alt('a').'<esc>ggVG'
execute 'inoremap <silent>'.Alt('h').'<esc>0i'
execute 'nnoremap <silent>'.Alt('h').'0'
execute 'vnoremap <silent>'.Alt('h').'0'
execute 'noremap <silent>'.Alt('h').'0'

"more ergonomic to use alt-space instead of Return
execute 'inoremap <silent>'.Alt('<space>').'<nl>'
execute 'cnoremap <silent>'.Alt('<space>').'<cr>'

"fast literal search and replace with alt-space in nmode/vmode
execute 'nnoremap <silent>'.Alt('<Space>').'V \| :call vwisd#search#SR("/", "v")<cr><cr>'
execute 'vnoremap <silent>'.Alt('<Space>').':<C-u>call vwisd#search#SR("/", "v")<cr><cr>'

nnoremap <esc>j /
nnoremap <esc>k ?
vnoremap <esc>j /
vnoremap <esc>k ?

inoremap <silent> <esc>e <esc><esc>
nnoremap <silent> <esc>e <esc><esc>
vnoremap <silent> <esc>e <esc><esc>

execute 'inoremap <silent>'.Alt('d').'<Del>'
execute 'nnoremap <silent>'.Alt('d').'<esc>0v$<left>d'
execute 'nnoremap <silent>'.Alt('y').'<esc>0v$<left>y'
execute 'inoremap <silent>'.Alt('7').'{<NL>}<esc>O'
execute 'noremap <silent>'.Alt('7').'{'
execute 'nnoremap <silent>'.Alt('7').'{'
execute 'vnoremap <silent>'.Alt('7').'{'
execute 'noremap <silent>'.Alt('0').'}'
execute 'nnoremap <silent>'.Alt('0').'}'
execute 'vnoremap <silent>'.Alt('0').'}'

"TODO : make this command to keep top and bottom rows, right now it sets current line to bottom of screen
nnoremap <silent> <esc>W :w <bar> :set ul=-1<CR> <bar> :e<CR> <bar> :set ul=100<CR> <bar> `.

execute 'inoremap <silent>'.Alt('w').'<esc>:w<CR>'
execute 'nnoremap <silent>'.Alt('w').'<esc>:w<CR>'
execute 'vnoremap <silent>'.Alt('w').'<esc>:w<CR>'

"TODO: add a cnoremap binding to quit as well
execute 'inoremap <silent>'.Alt('q').'<esc>:q!<cr>'
execute 'noremap <silent>'.Alt('q').'<esc>:q!<cr>'
execute 'nnoremap <silent>'.Alt('q').'<esc>:q!<cr>'
execute 'vnoremap <silent>'.Alt('q').'<esc>:q!<cr>'

execute 'inoremap <silent>'.Alt('z').'<esc>ZZ<cr>'
execute 'noremap <silent>'.Alt('z').'<esc>ZZ<cr>'
execute 'nnoremap <silent>'.Alt('z').'<esc>ZZ<cr>'
execute 'vnoremap <silent>'.Alt('z').'<esc>ZZ<cr>'

execute 'inoremap <silent>'.Alt('n').'<esc>:noh<cr>'
execute 'noremap <silent>'.Alt('n').'<esc>:noh<cr>'
execute 'nnoremap <silent>'.Alt('n').'<esc>:noh<cr>'

execute 'inoremap <silent>'.Alt('.').'<esc>:set nonumber! norelativenumber!<cr>a'
execute 'noremap <silent>'.Alt('.').':set nonumber! norelativenumber!<cr>'
execute 'nnoremap <silent>'.Alt('.').':set nonumber! norelativenumber!<cr>'

execute 'inoremap <silent>'.Alt(',').'<esc>:execute "set colorcolumn=" 
    \ . (&colorcolumn == "" ? "80" : "")<CR>a'
execute 'noremap <silent>'.Alt(',').':execute "set colorcolumn=" 
    \ . (&colorcolumn == "" ? "80" : "")<CR>'
execute 'nnoremap <silent>'.Alt(',').':execute "set colorcolumn=" 
    \ . (&colorcolumn == "" ? "80" : "")<CR>'

augroup myvimrc
    au!
    au BufWritePost .vimrc so $MYVIMRC
augroup END

if !has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=1000
    autocmd InsertLeave * set timeoutlen=1000
  augroup END
endif

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    "open NerdTree automatically when start on directory
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

    "close vim if the only window left open is a NERDTree?
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    "open a NERDTree automatically when vim starts up if no files were specified
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    autocmd FileType nerdtree setlocal relativenumber
endif


au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

au VimLeave * if filereadable("/home/t/.vim/.netrwhist") | call delete("/home/t/.vim/.netrwhist") | endif

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

if &term =~ "rxvt"

    "color the cursor green in insert mode
    let &t_SI = "\<esc>]12;green\x7"

    "color the cursor orange in normal mode
    let &t_EI = "\<esc>]12;orange\x7"

    silent !echo -ne "\033]12;orange\007"

    "color the cursor orange when leaving vim
    autocmd VimLeave * silent !echo -ne "\033]112\007"

    au CmdlineEnter * set ttimeoutlen=10
    au CmdlineLeave * set timeoutlen=1000
endif

set foldtext=vwisd#fold#MyFoldText()

function! Md(dir)
	if a:dir == '/'
		nmap n /<CR>
		nmap N ?<CR>
		vmap n /<CR>
		vmap N ?<CR>
	else
		nmap n ?<CR>
		nmap N /<CR>
		vmap n ?<CR>
		vmap N /<CR>
	endif
endfunction
