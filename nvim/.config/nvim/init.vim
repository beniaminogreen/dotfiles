let mapleader =","
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

execute pathogen#infect()
syntax on
filetype plugin indent on
set complete+=kspell

call plug#begin('~/.config/nvim/plugged')
	Plug 'tmsvg/pear-tree'
	Plug 'danilo-augusto/vim-afterglow'
	Plug 'tpope/vim-surround'
	Plug 'chrisbra/csv.vim'
	Plug 'ap/vim-css-color'
	Plug 'christoomey/vim-titlecase'
	Plug 'unblevable/quick-scope'
	Plug 'vim-scripts/bats.vim'
	Plug 'preservim/nerdtree'
	Plug 'cespare/vim-toml'
	Plug 'honza/vim-snippets'
	Plug 'bling/vim-airline'
	Plug 'vifm/vifm.vim'
	Plug 'sirver/ultisnips'
	Plug 'kovetskiy/sxhkd-vim'
call plug#end()

colorscheme afterglow

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus


inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" enforcing good habits
	inoremap <up> <nop>
	inoremap <down> <nop>
	inoremap <left> <nop>
	inoremap <right> <nop>
	"
	noremap <up> <nop>
	noremap <down> <nop>
	noremap <left> <nop>
	noremap <right> <nop>
	"
	vnoremap <up> <nop>
	vnoremap <down> <nop>
	vnoremap <left> <nop>
	vnoremap <right> <nop>
" Some basics:
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

" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <leader>e :setlocal spell! spelllang=es<CR>
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

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

""" wordcount
" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" add jump point
	map <leader>j i<++><esc>
	inoremap <leader>j <++>

	map <leader>wc :w !sed '/<<.*>>=/,/^@$/d' %:p \| detex \| wc -w <enter>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex, !texclear %
	autocmd VimLeave *.rnw, !texclear %

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

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Restart bspwm when bspwmrc is changed
	autocmd BufWritePost *bspwmrc !bspc wm -r

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Sort bib file whenever saved
	autocmd BufWritePost *.bib execute "silent !sortbib <amatch>" | edit!

" Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

	" Word count:
	" Code snippets
"""LATEX
	autocmd FileType tex inoremap ,bd <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/data_sci_template.tex<Enter>ggdd,,
	autocmd FileType tex inoremap ,be <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/essay_template.tex<Enter>ggdd:MultipleCursorsFind<Space><TITLE><Enter>c
	autocmd FileType tex inoremap ,bn <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/notes_template.tex<Enter>ggdd:MultipleCursorsFind<Space><TITLE><Enter>c
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA

	autocmd FileType tex inoremap ;a \alpha
	autocmd FileType tex inoremap ;b \beta
	autocmd FileType tex inoremap ;c \chi
	autocmd FileType tex inoremap ;d \delta
	autocmd FileType tex inoremap ;e \varepsilon
	autocmd FileType tex inoremap ;f \varphi
	autocmd FileType tex inoremap ;g \gamma
	autocmd FileType tex inoremap ;h \eta
	autocmd FileType tex inoremap ;i \iota
	autocmd FileType tex inoremap ;k \kappa
	autocmd FileType tex inoremap ;l \lambda
	autocmd FileType tex inoremap ;m \mu
	autocmd FileType tex inoremap ;n \nu
	autocmd FileType tex inoremap ;o \omicron
	autocmd FileType tex inoremap ;p \pi
	autocmd FileType tex inoremap ;q \theta
	autocmd FileType tex inoremap ;r \rho
	autocmd FileType tex inoremap ;s \sigma
	autocmd FileType tex inoremap ;t \tau
	autocmd FileType tex inoremap ;u \upsilon
	autocmd FileType tex inoremap ;v \varsigma
	autocmd FileType tex inoremap ;w \omega
	autocmd FileType tex inoremap ;x \xi
	autocmd FileType tex inoremap ;y \psi
	autocmd FileType tex inoremap ;z \zeta
	autocmd FileType tex inoremap ;A \Alpha
	autocmd FileType tex inoremap ;B \Beta
	autocmd FileType tex inoremap ;C \Chi
	autocmd FileType tex inoremap ;D \Delta
	autocmd FileType tex inoremap ;E \Varepsilon
	autocmd FileType tex inoremap ;F \Varphi
	autocmd FileType tex inoremap ;G \Gamma
	autocmd FileType tex inoremap ;H \Eta
	autocmd FileType tex inoremap ;I \Iota
	autocmd FileType tex inoremap ;K \Kappa
	autocmd FileType tex inoremap ;L \Lambda
	autocmd FileType tex inoremap ;M \Mu
	autocmd FileType tex inoremap ;N \Nu
	autocmd FileType tex inoremap ;O \Omicron
	autocmd FileType tex inoremap ;P \Pi
	autocmd FileType tex inoremap ;Q \Theta
	autocmd FileType tex inoremap ;R \Rho
	autocmd FileType tex inoremap ;S \Sigma
	autocmd FileType tex inoremap ;T \Tau
	autocmd FileType tex inoremap ;U \Upsilon
	autocmd FileType tex inoremap ;V \Varsigma
	autocmd FileType tex inoremap ;W \Omega
	autocmd FileType tex inoremap ;X \Xi
	autocmd FileType tex inoremap ;Y \Psi
	autocmd FileType tex inoremap ;Z \Zeta
	autocmd FileType tex inoremap ;( \left(
	autocmd FileType tex inoremap ;) \right)

"""BIB
	autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>2F*i
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>2F~i
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>2F=i
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><++><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><++><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><++><esc>2kO
	autocmd Filetype rmd vnoremap ,r ><esc>'>o```<esc><<'<O```{r}<esc><<f}i
	autocmd Filetype rmd vnoremap ,c ><esc>'>o```<esc><<'<O```<esc><<'>
	autocmd Filetype rmd vnoremap ,p ><esc>'>o```<esc><<'<O```{python}<esc><<f}i

"""Genral Code
	autocmd Filetype r,python vnoremap ,c :norm<space>I#<enter>
	autocmd Filetype r,python vnoremap ,uc :norm<space>I#<enter>

""".r
	autocmd filetype r,rmd inoremap ,fun <-<Space>function(<++>){<enter><++><enter>return(<++>)<enter>}<enter><enter><++><esc>5kI
	autocmd filetype r nnoremap ,D <esc>w<enter>:!rpkg<enter>
	autocmd filetype r nnoremap ,l ggOlibrary("")<esc>T(a
	autocmd filetype r,rmd inoremap ,test context("<++>")<enter>test_that('<++>',{<enter>expect_<++>(<++>)<esc><<A<enter>})<esc>3k0ci"

""".sh
	autocmd filetype shell inoremap ,e echo<Space>"*"<++><esc>T*ci"
	autocmd filetype shell inoremap ,if if<Space><Enter>then<Enter><Tab><++><Enter>fi<esc><<A<Enter><Enter><++><esc>5kA
	autocmd filetype shell inoremap ,v ${+*+}<++><esc>T*ci}
	autocmd filetype shell inoremap ,w while<Space><Enter>do<Enter><Tab><++><Enter>done<esc><<A<Enter><Enter><++><esc>5kA

""".xml
	autocmd filetype xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd filetype xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"

""".notes
	autocmd filetype notes nnoremap ,n :put =strftime('%D')<enter>A ()<enter><++><esc>k$i

""" remaps for indentation
	vnoremap < <gv
	vnoremap > >gv

""" use external terminal emulator for R
	let R_in_buffer=0
	let R_term=$TERMINAL
	let g:R_external_term=$TERMINAL
	let R_assign=2
	let g:R_rnowebchunk=0

""" w!! trick
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
""" quickscopes
	highlight QuickScopePrimary guifg='#ff1493' gui=underline ctermbg=236 ctermfg=226 cterm=underline
	highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=171 cterm=underline
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
