let mapleader =","
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" execute pathogen#infect()
syntax on
filetype plugin indent on
set complete+=kspell
set expandtab

call plug#begin('~/.config/nvim/plugged')

" movements and text objects
Plug 'tpope/vim-surround'
Plug 'tmsvg/pear-tree'
Plug 'triglav/vim-visual-increment'

Plug 'trusktr/seti.vim'
Plug 'eigenfoo/stan-vim'

Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-titlecase'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" syntax highlighting / colors
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'kovetskiy/sxhkd-vim'
Plug 'vifm/vifm.vim'
Plug 'folke/tokyonight.nvim'

" appearance
Plug 'bling/vim-airline'
Plug 'junegunn/goyo.vim'

" completion and snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
call plug#end()

" Define Color Scheme
colorscheme tokyonight
set bg=dark

UltiSnips Jumps
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger = '<s-tab>'

" Some basics:
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set cindent
set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set softtabstop=4

" save undos / file history after file closes
set undofile
set undodir=$HOME/.vimdid

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown','.sh': 'sh','.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.py set filetype=python
	autocmd BufRead,BufNewFile *.r,*.R,*.rnw  set filetype=r
	autocmd BufRead,BufNewFile *.rs set filetype=rust
	autocmd BufRead,BufNewFile *.sh set filetype=sh
	autocmd BufRead,BufNewFile *.notes set filetype=notes

" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex, !texclear %
	autocmd VimLeave *.rnw, !texclear %

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Restart bspwm when bspwmrc is changed
	autocmd BufWritePost *bspwmrc !bspc wm -r

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" " Sort bib file whenever saved
" 	autocmd BufWritePost *.bib execute "silent !sortbib <amatch>" | edit!

""" remaps for indentation
	vnoremap < <gv
	vnoremap > >gv

""" use external terminal emulator for R
	let R_assign=0
	let g:R_rnowebchunk=0
	let R_rconsole_width = 0
	let R_rconsole_height = 8
    let R_csv_app = 'terminal:sc-im2'
    let R_csv_delim = '\t'
    nnoremap <leader>t :!R -e "devtools::test()"<enter>
    nnoremap <leader>l :Rsend devtools::load_all()<enter>
    autocmd Filetype R setlocal tabstop=2

""" w!! trick
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

inoremap %% %>%<enter>

" Go back to last edited file with <Space><Space>
nnoremap <space><space> :b#<enter>

" linter settings
let b:ale_fixers = {'python': ['yapf', 'autopep8'], 'rust':["rustfmt"]}
#let g:ale_r_lintr_options = "with_defaults(line_length_linter(120))"

" run linter on pressing leader f.
nnoremap ,f :ALEFix<enter>

nnoremap ,m :w!<enter> :!make<enter>

" fix last spelling error in insert mode
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Make Y behave like the rest of the capital letters
noremap Y y$

" Stop the cursor from jumping around when you press J
noremap J mzJ`z

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==

vnoremap ,v :norm I"<enter>gv:norm A",<enter>xo)<esc>{i(<esc>

nnoremap ,j :m .+1<CR>==
nnoremap ,k :m .-2<CR>==


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:UltiSnipsExpandTrigger="<c-tab>"




