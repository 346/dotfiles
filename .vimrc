" ---------------------------------------------------------------------
"
" .vimrc
"
" ---------------------------------------------------------------------
" カンマで始まるキーマップはMacのSparkでCtrl+Shift同時押しにしている

" vi互換にしない
set nocompatible

" os判定
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \ (!executable('xdg-open') &&
      \ system('uname') =~? '^darwin'))

" スクリプト実行中に画面を描画しない
set lazyredraw

" シェルに移動
" nnoremap <silent> ,h :VimShell<CR>
nnoremap <silent> ,h :shell<CR>

" make
nnoremap <silent> ,b :w<CR>:make<CR>

" タブ移動（あんまりタブ使わないから一方向
nnoremap <silent> ,m :tabN<CR>

" .vimrcを編集(これはSparkとかじゃなくてキーマップをそのまま使う
nnoremap <silent> ,. :<C-u>edit $MYVIMRC<CR>

" マクロは使いこなせないのでqを無効
noremap q <nop>

" 直前のyankレジスタをpaste。 visualでpasteするとyankレジスタが更新されるため、pasteを別途定義
" もっといい方法ないかね
vnoremap <silent> <C-p> "0p<CR>

" 自動set paste
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret)
      set paste
      return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" {{{ プラグイン(neobundle)
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimshell' 
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'sudo.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'matchit.zip'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'janko-m/vim-test'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'slm-lang/vim-slm'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'wakatime/vim-wakatime'
NeoBundleLazy 'leafgarland/typescript-vim', {
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}
NeoBundleLazy 'Quramy/tsuquyomi', {
\ 'depends': ['Shougo/vimproc'],
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}
NeoBundleLazy 'jason0x43/vim-js-indent', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'typescript', 'html'],
\}}
call neobundle#end()



" neocomplete
let g:neocomplete#enable_at_startup = 1

let g:neocomplete#force_omni_input_patterns = {}
let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'

" typescript
let g:js_indent_typescript = 1
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript setlocal omnifunc=tsuquyomi#complete
let g:tsuquyomi_disable_default_mappings = 1
nnoremap <C-]> <Plug>(TsuquyomiDefinition)

" neosnippet
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" " For conceal markers.
" if has('conceal')
  " set conceallevel=2 concealcursor=niv
" endif

" unite.vim
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nmap <buffer> <space> <nop>
endfunction"}}}
" 入力モードで開始する
let g:unite_enable_start_insert = 1
" 最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 10 
let g:unite_source_buffer_limit = 3
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される、らしい・・・
let g:unite_source_file_mru_time_format = ''
let g:unite_source_file_mru_filename_format = ''

" file_recの最大ファイル数
let g:unite_source_file_rec_max_cache_files = 2000

" lightline
let g:unite_force_overwrite_statusline = 0

" file_recの除外
let s:file_rec_ignore_globs = ['*.png', '*.jpg', '*.gif', '**/vendor/**', '**/Smarty/**', '**/gmopg/**', '**/Yahoo/**', '*~', 'seeds.rb']
call unite#custom#source('file_rec/git', 'ignore_globs', s:file_rec_ignore_globs)
call unite#custom_source('file_rec/git', 'sorters', 'sorter_length')
call unite#custom#source('buffer', 'ignore_globs', s:file_rec_ignore_globs)
call unite#custom#source('grep', 'ignore_globs', s:file_rec_ignore_globs)

if executable('ag')
  let g:unite_source_rec_async_command = ["ag", "--nocolor", "--nogroup", "-g"]
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

function! Unite_substitute(pattern, substitute)
  call unite#custom#substitute('default', '[[:blank:]]\zs' . a:pattern . '\ze[[:blank:]]\|^\zs' . a:pattern . '\ze[[:blank:]]', a:substitute)
endfunction

call Unite_substitute('m', 'app\/models')
call Unite_substitute('v', 'app\/views')
call Unite_substitute('c', 'app\/controllers')
call Unite_substitute('h', 'app\/helpers')
call Unite_substitute('a', 'app\/api')
call Unite_substitute('s', 'services')
call Unite_substitute('f', 'forms')
call Unite_substitute('ce', 'cells')
call Unite_substitute('se', 'serializers')
call Unite_substitute('au', 'authorizers')
call Unite_substitute('ma', 'mailers')
call Unite_substitute('w', 'workers')
call Unite_substitute('t', '_spec.rb')
call Unite_substitute('r', 'requests')
call Unite_substitute('fa', 'spec\/factories')
call Unite_substitute('con', 'config\/')
call Unite_substitute('l', 'lib\/')

call Unite_substitute('ux', '\.ux')
call Unite_substitute('vm', 'vm\/')
call Unite_substitute('ts', '\.ts')

nnoremap <C-T> :Unite buffer file_rec/git:--cached:--others:--exclude-standard -direction=topleft -auto-resize -toggle<CR>
nnoremap <silent> ,/ :<C-u>Unite -buffer-name=search line -start-insert<CR>

" unite-outline
nnoremap <silent> ,t :Unite outline -direction=topleft -auto-resize -toggle<CR>

" grep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" grep with keyword under cursor
nnoremap <silent> ,* :<C-u>UniteWithCursorWord grep:. -buffer-name=search-buffer<CR>

" unite-tags
let g:unite_source_tag_max_fname_length = 100
nnoremap <silent> ,] :<C-u>UniteWithCursorWord -immediately tag<CR>

" Yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
"" 履歴取得数
let g:yankround_max_history = 100
""履歴一覧(kien/ctrlp.vim)
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
let g:yankround_dir = '~/.cache/yankround'

" nerd commenter
let NERDSpaceDelims = 1
nmap <silent> ,, <Plug>NERDCommenterToggle
vmap <silent> ,, <Plug>NERDCommenterToggle

" quickrun
function! s:load_rspec_settings()
  nnoremap <silent>,rn :TestNearest<CR>
  nnoremap <silent>,rf :TestFile<CR>
  nnoremap <silent>,rs :TestSuite<CR>
  nnoremap <silent>,rl :TestLast<CR>
  nnoremap <silent>,rv :TestVisit<CR>
endfunction
augroup RSpecSetting
  au!
  au BufEnter *.rb call s:load_rspec_settings()
augroup END

" jinja2
" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [ 'fugitive' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag'
      \ },
      \ 'component_type': {
      \   'syntastic': 'error'
      \ }
      \ }
" indentLine
let g:indentLine_color_term = 237

" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_xml_xmllint_quiet_messages = { 'regex': 'namespace' }

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.rb,*.js,*.ux call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  " call lightline#update()
endfunction

" }}}

" ---------------------------------------------------------------------
" 共通
" ---------------------------------------------------------------------
" ヘルプを日本語に
set helplang=ja,en

" ハイライトをリセット
:nnoremap <ESC><ESC> :nohlsearch<CR>

" 終了時にセッションを保存
au VimLeave * mks! ~/vims

" デフォルトモードをインサートにしない
set noinsertmode

" 行の端まで到達したら折り返す
set wrap

" スペースで折り返さない
set nolinebreak

" gq コマンド以外では自動改行しない
autocmd FileType * setlocal formatoptions-=ro

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
  set nolist    " Tab や改行を表示しない
endif

" 記憶するコマンド数
set history=50

" アンドゥ可能な変更の最大値
set undolevels=1000

" 行番号を表示
set number

" タブの空白文字数
set tabstop=2

" 自動インデントの空白文字数
set shiftwidth=2

" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

" 新しい行を作ったときに高度な自動インデントを行う
set smartindent

" タブはスペース
set expandtab

" コロンコマンドを記録する数
set history=50

" 編集中の内容を保ったまま別の画面に切替えられるようにする
set hid

" :shellをログインシェルに
"set shell=bash\ -l
" ---------------------------------------------------------------------
" 文字コードの自動認識
" ---------------------------------------------------------------------

" macの場合は判定をmacvim kaoriyaにまかせる
if !s:is_mac
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
" let php_htmlInStrings=1
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
filetype plugin indent on

colorscheme hybrid

" 表示行単位で行移動する
nnoremap j gj
nnoremap k gk

" フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" filetype設定
augroup MyAutoCmd
  autocmd!
  au BufRead,BufNewFile *.phtml set filetype=php
  au BufRead,BufNewFile *.ctp set filetype=php
  " au BufRead,BufNewFile *.tpl set filetype=smarty 
  au BufRead,BufNewFile Fastfile,Vagrantfile,*.eye,*.cap,*.rake set filetype=ruby
  au BufRead,BufNewFile */db/seeds.rb set filetype=text
  au BufRead,BufNewFile *.ux set filetype=xml
  au BufRead,BufNewFile *.uxl set filetype=xml
  au BufRead,BufNewFile *.uno set filetype=cs

  " make
  autocmd filetype php :set makeprg=php\ -l\ %
  autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

  autocmd FileType ruby setlocal makeprg=ruby\ -c\ %
  autocmd FileType ruby setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  autocmd FileType perl,cgi :compiler perl  
  autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

augroup END

NeoBundleCheck
