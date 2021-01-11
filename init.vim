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
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-phpls']
	" Splash Screen
	Plug 'mhinz/vim-startify'
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
set number relativenumber
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
