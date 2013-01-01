" ---------------------------------------------------------------------
"
" .vimrc
"
" ---------------------------------------------------------------------

" vi互換にしない
set nocompatible
" スクリプト実行中に画面を描画しない
set lazyredraw

" {{{ プラグイン(neobundle)
if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
" NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
" NeoBundle 'Shougo/neocomplcache'

" Non github repos
" NeoBundle 'git://git.wincent.com/command-t.git'

" Non git repos
" NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'

"unite.vim
NeoBundle 'Shougo/unite.vim'

" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
let g:unite_enable_start_insert=1
noremap <C-T> :Unite buffer -direction=topleft -auto-resize -toggle<CR>
noremap <F4> :UniteWithBufferDir -auto-resize -buffer-name=files file<CR>

" YankRing.vim
"set viminfo+=!		" おまじない
let g:yankring_window_use_bottom=0
let g:yankring_history_file='.yankring_history'
let g:yankring_history_dir=$HOME.'/.vim/'
NeoBundle 'YankRing.vim'

" sudo.vim
NeoBundle 'sudo.vim'

" vim-fugitive
NeoBundle 'tpope/vim-fugitive'

" easy motion
let g:EasyMotion_leader_key = '<Space><Space>'
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_keys = 'fjdkslaureiwoqpvncm'

" sparkup
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" phpDocumenter for Vim
"NeoBundle 'bthemad/php-doc.vim'
NeoBundle 'php-doc-upgrade'
inoremap <F2> <ESC>:call PhpDocSingle()<CR>i
nnoremap <F2> :call PhpDocSingle()<CR>
vnoremap <F2> :call PhpDocRange()<CR> 
let g:pdv_cfg_Author = "Takahiro Mishiro"
"let g:pdv_cfg_Copyright="2013 Trifort Inc."
let g:pdv_cfg_License = ""

NeoBundle 'The-NERD-Commenter'
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
" matchit
NeoBundle 'matchit.zip'

" quickrun
NeoBundle 'thinca/vim-quickrun'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
if neobundle#exists_not_installed_bundles()
echomsg 'Not installed bundles : ' .
	 \ string(neobundle#get_not_installed_bundle_names())
echomsg 'Please execute ":NeoBundleInstall" command.'
" }}}

" phtml設定
au BufRead,BufNewFile *.phtml            set filetype=php

" make
autocmd filetype php setlocal makeprg=php\ -l\ %
autocmd filetype php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType ruby setlocal makeprg=ruby\ -c\ %
autocmd FileType ruby setlocal errorformat=%m\ in\ %f\ on\ line\ %l
autocmd FileType perl,cgi :compiler perl  
noremap <F5> :w<CR>:make<CR>
" shell
noremap <F6> :shell<CR>

" 複数行のコメントを自動的に継続する
set formatoptions+=or

endif
" ---------------------------------------------------------------------
" 共通
" ---------------------------------------------------------------------
" ハイライトをリセット
:nnoremap <ESC><ESC> :nohlsearch<CR>

" 終了時にセッションを保存
au VimLeave * mks! ~/vims

" デフォルトモードをインサートにしない
set noinsertmode

" 行の端まで到達したら折り返す
set wrap

" ホワイト・スペースで折り返さない
set nolinebreak

" gq コマンド以外では自動改行しない
set formatoptions=q

" 全て Backspace で削除可能にする
set backspace=indent,eol,start

" オートインデント
set autoindent

" エラーメッセージに伴ってベルを発生させない
set noerrorbells

" エラー音の代わりに画面フラッシュを使わない
set novisualbell

" コマンドラインの高さ
set cmdheight=1

" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden

" カーソル行に下線を追加
"set cursorline

" 'Press RETURN or enter command to continue' を表示しない
set shortmess=t

" タブや改行を表示するときの文字
set listchars=tab:>-,extends:<,trail:-,eol:<
if has("gui_running")
	set list
else
	set nolist		" Tab や改行を表示しない
endif

" 記憶するコマンド数
set history=50

" アンドゥ可能な変更の最大値
set undolevels=1000

" 行番号を表示
set number

" タブの空白文字数
set tabstop=4

" 自動インデントの空白文字数
set shiftwidth=4

" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

" 新しい行を作ったときに高度な自動インデントを行う
set smartindent

" Insertモードで: <Tab> を挿入するのに、適切な数の空白を使う
set noexpandtab

" コロンコマンドを記録する数
set history=50

" 編集中の内容を保ったまま別の画面に切替えられるようにする
set hid

" ---------------------------------------------------------------------
" 文字コードの自動認識
" ---------------------------------------------------------------------

if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif

if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconvがeucJP-msに対応しているかをチェック
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
		" iconvがJISX0213に対応しているかをチェック
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif

	" fileencodingsを構築
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif

	" 定数を処分
	unlet s:enc_euc
	unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	set ambiwidth=double
endif

" バイナリ編集(xxd)モード
" vim -b での起動、もしくは *.bin ファイルを開くと発動
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

" ---------------------------------------------------------------------
" 表示関連
" ---------------------------------------------------------------------

" ルーラーを表示
set ruler

" 実行したコマンドを表示
set showcmd

" 現在のモードを表示する
set showmode

" 括弧入力時の対応する括弧を表示
set showmatch

" タイトルを表示
set title

" 常にステータス行を表示
set laststatus=2

" ステータス行のフォーマット
"set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" ---------------------------------------------------------------------
" 検索関連
" ---------------------------------------------------------------------

" 結果をハイライト
set hlsearch

" ダイナミックに検索
set incsearch

" 大文字小文字を無視
set ignorecase

" キーワードに大文字が含まれていれば大文字小文字を区別
set smartcase

" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

" ファイルの最後に来たら最初から検索
set wrapscan

" 正規表現使用時に magic モードにする
set magic

" ---------------------------------------------------------------------
" PHP
" ---------------------------------------------------------------------

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1

" ---------------------------------------------------------------------
" folding
" ---------------------------------------------------------------------

"let php_folding=1
set foldmethod=marker

" ---------------------------------------------------------------------
" ハイライト
" ---------------------------------------------------------------------

syntax on

highlight StatusLine cterm=NONE ctermbg=DARKBLUE ctermfg=WHITE
highlight LineNr ctermfg=DARKBLUE
highlight Constant term=NONE ctermfg=DARKRED
highlight Comment term=NONE ctermfg=DARKGREEN
highlight Identifier cterm=NONE ctermfg=BLUE
highlight Statement cterm=BOLD ctermfg=BLUE
highlight PreProc ctermfg=BLUE
highlight Type ctermfg=BLUE
highlight Ignore ctermfg=DARKBLUE
highlight Error cterm=BOLD ctermbg=RED ctermfg=WHITE
highlight Title ctermfg=WHITE
highlight Special cterm=NONE ctermfg=DARKRED
highlight Search cterm=NONE ctermbg=YELLOW
highlight Todo ctermbg=YELLOW ctermfg=RED
highlight cTodo ctermbg=YELLOW ctermfg=RED
highlight VertSplit term=NONE cterm=NONE ctermbg=DARKBLUE ctermfg=7
highlight Visual term=NONE cterm=NONE ctermbg=DARKBLUE ctermfg=7
highlight BufferSelected term=NONE cterm=NONE ctermbg=BLUE ctermfg=7
highlight Cursor ctermbg=WHITE ctermfg=BLACK
highlight FoldColumn ctermbg=DARKBLUE ctermfg=WHITE
highlight Folded ctermbg=DARKBLUE ctermfg=WHITE

"highlight Underlined term=underline cterm=underline ctermfg=WHITE
highlight Underlined term=underline cterm=underline ctermfg=BLACK
highlight link htmlArg Identifier
highlight link htmlValue Identifier
highlight MatchParen ctermbg=WHITE ctermfg=BLACK
"highlight link htmlString SpecialKey
"highlight link javaScript SpecialKey

" 編集中はステータスバーの色を変える
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine ctermfg=WHITE ctermbg=DARKRED
autocmd InsertLeave * highlight StatusLine ctermfg=WHITE ctermbg=DARKBLUE
augroup END

" ---------------------------------------------------------------------
" キーマップ
" ---------------------------------------------------------------------

" make 
" map <F9>  :make<ENTER>
" map <F10> :!make clean; make<ENTER>

" 表示行単位で行移動する
nnoremap j gj
nnoremap k gk

" バッファ移動用キーマップ
" F2: 前のバッファ
" F3: 次のバッファ
" F4: バッファ削除
" map <F2> <ESC>:bp<CR>
" map <F3> <ESC>:bn<CR>
" map <F4> <ESC>:bw<CR>

" フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" ---------------------------------------------------------------------
" メモ
" ---------------------------------------------------------------------

" コントロールコードを入力する場合
"  Ctrl+v Ctrl+@
"
" fold command
" zR : open all
" zM : close all
" zc : close it
" zC : close it recursive
" zo : open it
" zO : optn it recursive

"syntax on
"set foldlevel=1
"set foldmethod=indent
"let perl_fold=1
"let perl_fold_blocks=1