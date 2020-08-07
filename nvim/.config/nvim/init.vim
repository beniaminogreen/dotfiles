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
	Plug 'tpope/vim-surround'
	Plug 'chrisbra/csv.vim'
	Plug 'ap/vim-css-color'
	Plug 'christoomey/vim-titlecase'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'unblevable/quick-scope'
	Plug 'rust-lang/rust.vim'
	Plug 'jalvesaq/Nvim-R'
	Plug 'vim-scripts/bats.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'jreybert/vimagit'
	Plug 'bling/vim-airline'
	Plug 'vifm/vifm.vim'
	Plug 'kovetskiy/sxhkd-vim'
call plug#end()

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

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

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

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

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

""" wordcount
	map <leader>wc :w !wc -w<enter>
" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" add jump point
	map <leader>j i<++><esc>
	inoremap <leader>j <++>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown','.sh': 'sh','.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd BufRead,BufNewFile *.py set filetype=python
	autocmd BufRead,BufNewFile *.r,*.R  set filetype=r
	autocmd BufRead,BufNewFile *.rs set filetype=rust
	autocmd BufRead,BufNewFile *.sh set filetype=sh
	autocmd BufRead,BufNewFile *.notes set filetype=notes

" Enable Goyo by default for mutt writting
" Goyo's width will be the line limit in mutt.
"	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80



" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
"	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

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
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,li <Esc>o\item<Space>
	autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ,bf \textbf{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,bn <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/notes_template.tex<Enter>ggdd:MultipleCursorsFind<Space><TITLE><Enter>c
	autocmd FileType tex inoremap ,bd <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/data_sci_template.tex<Enter>ggdd,,
	autocmd FileType tex inoremap ,be <Esc>:read<Space>!cat<Space>$HOME/UCL/latex_resources/essay_template.tex<Enter>ggdd:MultipleCursorsFind<Space><TITLE><Enter>c
	autocmd FileType tex inoremap ,bt {\blindtext}
	autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,cp \parencites[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex inoremap ,cc \cites[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex inoremap ,cf \footcites[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex inoremap ,ct \textcites[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex inoremap ,ac <esc>f}a[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex noremap ,ac f}a[][<++>]{<++>}<Space><++><Esc>2T[i
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,ms  $$<esc>i
	autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ,im \item
	autocmd FileType tex inoremap ,it \textit{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,lat {\LaTeX}
	autocmd FileType tex inoremap ,nu $\varnothing$
	autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,mat \begin{equation}<Enter><Enter>\end{equation}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ,il $$<++><esc>F$i
	autocmd FileType tex inoremap ,mfr \frac{}{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,mli \lim{}<++><esc>T{i
	autocmd FileType tex inoremap ,gc \{<++>}<++><esc>T\i
	autocmd FileType tex inoremap ,msq \sqrt[]{<++>}{<++>}<++><esc>T[i
	autocmd FileType tex inoremap ,msum \sum_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,mint \int_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,miint \iint_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,miiint \iiint_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,miiiint \iiiint_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,mprod \prod_{}^{<++>}<++><esc>2T{i
	autocmd FileType tex inoremap ,gn \{<++>}<++><esc>F{i
	autocmd FileType tex inoremap ,ggn \{<++>}{<++>}<++><esc>2F{i
	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex vnoremap ,a <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex vnoremap ,ol :norm I<Tab>\item<Space><Enter>'<O\begin{enumerate}<Esc>'>o\end{enumerate}<Esc>
	autocmd FileType tex vnoremap ,ul :norm I<Tab>\item<Space><Enter>'<O\begin{itemize}<Esc>'>o\end{itemize}<Esc>
	autocmd FileType tex vnoremap ,it c\textit{}<esc>P
	autocmd FileType tex vnoremap ,sec c\section{}<esc>P
	autocmd FileType tex vnoremap ,ssec c\subsection{}<esc>P
	autocmd FileType tex vnoremap ,sssec c\subsubsection{}<esc>P
	autocmd FileType tex vnoremap ,ms c$$<esc>P
	autocmd FileType tex vnoremap ,bf c\textbf{}<esc>P
	autocmd FileType tex vnoremap ,em c\emph{}<Esc>P

"""HTML
	autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html inoremap ,it <em></em><Space><++><Esc>FeT>i
	autocmd FileType html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
	autocmd FileType html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,li <Esc>o<li></li><Esc>F>a
	autocmd FileType html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
	autocmd FileType html inoremap ,td <td></td><++><Esc>Fdcit
	autocmd FileType html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType html inoremap ,th <th></th><++><Esc>Fhcit
	autocmd FileType html inoremap ,tab <table><Enter></table><Esc>O
	autocmd FileType html inoremap ,gr <font color="green"></font><Esc>F>a
	autocmd FileType html inoremap ,rd <font color="red"></font><Esc>F>a
	autocmd FileType html inoremap ,yl <font color="yellow"></font><Esc>F>a
	autocmd FileType html inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
	autocmd FileType html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
	autocmd FileType html inoremap &<space> &amp;<space>

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
	autocmd filetype r,python nnoremap ,A ggV}k:sort<enter>''
	autocmd filetype r,python inoremap ,a <esc>wa,""<esc>T"i
	autocmd filetype r,python inoremap ,k <esc>wa,<Space><+*+><Space>=<Space>"<++>"<esc>T*ciW
	autocmd filetype r,python inoremap ,nk {+*+}<Space>="<++>"<esc>T*ca}
	autocmd filetype r,python noremap ,p <esc>0Iprint(<esc>A)<esc>
	autocmd Filetype r,python vnoremap ,c :norm<space>I#<enter>
	autocmd Filetype r,python vnoremap ,uc :norm<space>I#<enter>

""".r
	autocmd filetype r,rmd inoremap ,fun <-<Space>function(<++>){<enter><++><enter>return(<++>)<enter>}<enter><enter><++><esc>5kI
	autocmd filetype r nnoremap ,D <esc>w<enter>:!rpkg<enter>
	autocmd filetype r nnoremap ,l ggOlibrary("")<esc>T(a
	autocmd filetype r,rmd inoremap ,if if(){<enter><++><enter>}<++><enter><enter><++><esc>4k0f)i
	autocmd filetype r,rmd inoremap ,ie if(){<enter><++><enter>}<space>else<space>{<enter><++><enter>}<++><enter><enter><++><esc>6k0f)i
	autocmd filetype r,rmd inoremap ,el <space>else<space>{<enter><enter>}<++><esc>kI<tab>
	autocmd filetype r,rmd inoremap ,ei <space>else<space>if<space>()<space>{<enter><++><enter>}<++><esc>2kf)i
	autocmd filetype r,rmd inoremap ,p <esc>A<Space>%>%<enter>
	autocmd filetype r,rmd inoremap ,sp <Space><-<Space><++><Space>%>%<enter><tab><++><esc>kI
	autocmd filetype r,rmd inoremap ,for for(){<enter><++><enter>}<enter><enter><++><esc>4k0f)i
	autocmd filetype r,rmd inoremap ,wh while(){<enter><++><enter>}<enter><enter><++><esc>4k0f)i
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

"""
	""" nnoremap z "1yiW:!goto.sh "<C-R>1"<enter>

""" use external terminal emulator for R
	let R_in_buffer=0
	let R_term=$TERMINAL
	let R_assign=2

""" w!! trick
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
""" quickscopes
	highlight QuickScopePrimary guifg='#ff1493' gui=underline ctermbg=236 ctermfg=226 cterm=underline
	highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=171 cterm=underline
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
