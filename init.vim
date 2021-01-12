let g:ale_disable_lsp = 1
let g:airline#extensions#ale#enabled = 1
call plug#begin("~/.vim/plugged")
	" Theme
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'ryanoasis/vim-devicons'
	" File Tree
	Plug 'scrooloose/nerdtree'
	" Status Bar
	Plug 'vim-airline/vim-airline'
	" File Searching
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	" Intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
	Plug 'dense-analysis/ale'
	" Splash Screen
	Plug 'mhinz/vim-startify'
	" Emacs only advantage
	Plug 'jceb/vim-orgmode'
	Plug 'vim-scripts/utl.vim'
	Plug 'tpope/vim-repeat'
	Plug 'yegappan/taglist'
	Plug 'preservim/tagbar'
	Plug 'tpope/vim-speeddating'
	Plug 'chrisbra/NrrwRgn'
	Plug 'mattn/calendar-vim'
	Plug 'inkarkat/vim-SyntaxRange'
	Plug 'axvr/org.vim'
call plug#end()

"Config Section
if (has("termguicolors"))
	set termguicolors
endif

" THEME CONFIG
let g:dracula_colorterm = 0
syntax enable
colorscheme dracula

" NERDTREE CONFIG
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle the tree
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" TERMINAL CONFIG
" open new split panes to right and bottom
set splitright
set splitbelow
" Use Escape to switch to normal mode
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	split term://bash
	resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" QUICK PANEL SWITCHING WITH alt
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" FUZZY FIND CONFIG
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-s': 'split',
			\ 'ctrl-v': 'vsplit'
			\}
" close fzf with Escape
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" GENERAL
set hidden
set number relativenumber
set laststatus=2
set noshowmode
let mapleader=" "
" Remove highlight on searches
map <Leader>0 :exe "noh" <CR>
" Quick saving
map <F1> :w<CR><Esc>
imap <F1> <c-o><F1>
" Quick Tab/Buffer Movements
map <Leader>j :bn <CR>
map <Leader>k :bp <CR>
map <Leader>l :tabnext <CR>
map <Leader>h :tabprev <CR>
map <Leader>x :bd <CR>
" This will execute the current line in bash silently
map <Leader>e :exe "silent .w !bash" <CR>
" FZF
map <Leader>f :Files <CR>
map <Leader>b :Buffers <CR>
" Quick Command Prompt
map <Leader><Leader> :
" Quick Emmet Wrap
map <leader><cr> <c-y>,
" Easily adjust splits
nnoremap <silent> = 10<C-w>>
nnoremap <silent> - 10<C-w><
nnoremap <silent> _ 10<C-w>-
nnoremap <silent> + 10<C-w>+
" Use system clipboard
set clipboard=unnamedplus
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
" Save as sudo and load file back in
map <Leader>w :silent w !sudo tee %

" INDENTATION
set autoindent
set copyindent
set incsearch
set nosmarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
filetype plugin indent on

" WRAPPING
set wrap       "Wrap lines
set linebreak  "Wrap lines at convenient points

" WIN 10 CLIPBOARD
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" STARTIFY CONFIG
let g:ascii_header = [
	\ ' _    __________  __ ',
	\ '| | _|___ /___ / / _|',
	\ '| |/ / |_ \ |_ \| |_ ',
	\ '|   < ___) |__) |  _|',
	\ '|_|\_\____/____/|_|  ',
	\ ''
	\ ]                     
let g:startify_custom_header =
	\ startify#pad(g:ascii_header + startify#fortune#boxed())

" BOOKMARKS
function! SetGMark(mark, filename, line_nr)
	let l:mybuf = bufnr(a:filename, 1)
	call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf
call SetGMark('L', '/mnt/d/ownCloud/hd1/orgnotes/work/compulse/log.org', 5)
call SetGMark('T', '/mnt/d/ownCloud/hd1/orgnotes/work/compulse/tasks.org', 3)
call SetGMark('V', '/home/k33f/.vimrc', 58)
call SetGMark('A', '/mnt/d/ahk_scripts/ahk_2020/ahk33.ahk', 6)

" Orgmode mappings
nmap <C-j> <localleader>hh
imap <C-j> <Esc><localleader>hh
nmap <C-k> <localleader>hN
imap <C-k> <Esc><localleader>hN
nmap <Leader>c <localleader>cc
