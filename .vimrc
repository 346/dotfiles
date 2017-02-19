" ---------------------------------------------------------------------
"
" .vimrc
"
" ---------------------------------------------------------------------
" カンマで始まるキーマップはMacのKeyboardMaestroでCtrl+Shift同時押しにしている

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

" {{{ プラグイン(dein.vim)
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim')
  call dein#begin('~/.vim/bundle')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ })

  call dein#add('Shougo/neomru.vim')
  call dein#add('tsukkee/unite-tag')
  call dein#add('Shougo/vimshell')
  call dein#add('Shougo/unite-outline')
  call dein#add('LeafCage/yankround.vim')
  call dein#add('sudo.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('The-NERD-Commenter')
  call dein#add('matchit.zip')
  call dein#add('thinca/vim-quickrun')
  call dein#add('thinca/vim-qfreplace')
  call dein#add('janko-m/vim-test')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('Glench/Vim-Jinja2-Syntax')
  call dein#add('itchyny/lightline.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('neomake/neomake')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('chase/vim-ansible-yaml')
  call dein#add('slim-template/vim-slim')
  call dein#add('slm-lang/vim-slm')
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('leafgarland/typescript-vim', {
  \ 'autoload' : {
  \   'filetypes' : ['typescript'] }
  \})
  call dein#add('Quramy/tsuquyomi', {
  \ 'depends': ['Shougo/vimproc'],
  \ 'autoload' : {
  \   'filetypes' : ['typescript'] }
  \})
  call dein#add('jason0x43/vim-js-indent', {
  \ 'autoload' : {
  \   'filetypes' : ['javascript', 'typescript', 'html'],
  \}})
  call dein#add('fatih/vim-go', {
  \ 'depends': ['Shougo/vimproc'],
  \ 'autoload' : {
  \   'filetypes' : ['go'] }
  \})
  call dein#add('sudar/vim-arduino-syntax')
  call dein#add('majutsushi/tagbar.git')
  call dein#add('bronson/vim-trailing-whitespace')
  if dein#tap('vim-trailing-whitespace')
    let g:extra_whitespace_ignored_filetypes = ['unite']
  endif

  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif


" go
let g:go_def_mapping_enabled = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0
augroup MyVimGo
  autocmd!
  autocmd BufWritePre *.go call go#fmt#Format(-1)
augroup END


" neocomplete
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'
call neocomplete#custom#source('include', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('member', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('syntax', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('buffer', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('file', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('file_include', 'disabled_filetypes', {'sql' : 1})
call neocomplete#custom#source('tag', 'disabled_filetypes', {'sql' : 1})
augroup MyNeoComplete
  autocmd!
  autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
  autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
  autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
augroup END

" typescript
let g:js_indent_typescript = 1
augroup MyTsuquyomi
  autocmd!
  autocmd FileType typescript setlocal completeopt+=menuone,preview
augroup END
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
augroup MyUniteVim
  autocmd!
  autocmd FileType unite call s:unite_my_settings()
augroup END
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
  let g:unite_source_grep_default_opts = '--vimgrep'
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
      \   'right': [ [ 'neomake', 'lineinfo' ],
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
      \ 'component_function': {
      \   'neomake': 'neomake#statusline#LoclistStatus'
      \ },
      \ 'component_type': {
      \   'neomake': 'error'
      \ }
      \ }
" indentLine
let g:indentLine_color_term = 237

" Syntastic
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=2
" let g:syntastic_mode_map = { 'mode': 'passive' }
" let g:syntastic_xml_xmllint_quiet_messages = { 'regex': 'namespace' }
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" tagbar
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1
let g:tagbar_left = 1

" neomake
autocmd! BufWritePost * Neomake " 保存時に実行する
let g:neomake_javascript_enabled_makers = ['eslint']

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
set undofile

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
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 検索

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

" PHP

let php_sql_query=1
" let php_htmlInStrings=1
let php_noShortTags=1
"let php_folding=1


" etc
set foldmethod=marker

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
  autocmd BufRead,BufNewFile *.phtml set filetype=php
  autocmd BufRead,BufNewFile *.ctp set filetype=php
  " autocmd BufRead,BufNewFile *.tpl set filetype=smarty
  autocmd BufRead,BufNewFile Fastfile,Vagrantfile,*.eye,*.cap,*.rake set filetype=ruby
  autocmd BufRead,BufNewFile */db/seeds.rb set filetype=text
  autocmd BufRead,BufNewFile *.ux set filetype=xml
  autocmd BufRead,BufNewFile *.uxl set filetype=xml
  autocmd BufRead,BufNewFile *.uno set filetype=cs
  autocmd BufRead,BufNewFile *.go set filetype=go
  autocmd BufRead,BufNewFile *.dig set filetype=yaml

  " make
  autocmd filetype php setlocal makeprg=php\ -l\ %
  autocmd filetype php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

  autocmd FileType ruby setlocal makeprg=ruby\ -c\ %
  autocmd FileType ruby setlocal errorformat=%m\ in\ %f\ on\ line\ %l
  autocmd FileType perl,cgi :compiler perl
  autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

  " gq コマンド以外では自動改行しない
  autocmd FileType * setlocal formatoptions-=ro
  " au FileType gmaio setlocal sw=4 ts=4 sts=4 noet
  " au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m

augroup END
