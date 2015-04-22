let mapleader = ' '

vnoremap <silent> <C-p> "0p<CR>

nnoremap <esc> :noh<cr>

nnoremap <silent> gl gt
nnoremap <silent> gh gT
nnoremap <silent> gj <C-w>w
nnoremap <silent> gk <C-w>W

nnoremap [unite] <Nop>
nmap     <Leader>u [unite]
nnoremap <silent> [unite]b :Unite buffer<cr>
nnoremap <silent> [unite]m :Unite mark<cr>
nnoremap <silent> [unite]y :Unite history/yank<cr>
nnoremap <silent> [unite]B :Unite bookmark<cr>
nnoremap <silent> [unite]q :Unite -tab -auto-preview quickfix<cr>
nnoremap <silent> [unite]g :Unite -tab -auto-preview grep<cr>

nmap <Leader>r <Plug>(quickrun)

nmap <Leader>o :TagbarToggle<cr>

nmap s         <Plug>(easymotion-s2)
vmap s         <Plug>(easymotion-s2)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
vmap <Leader>j <Plug>(easymotion-j)
vmap <Leader>k <Plug>(easymotion-k)

nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

vmap <cr> <Plug>(EasyAlign)

nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)

nmap <Leader>h <Plug>(quickhl-cword-toggle)
nmap <Leader>] <Plug>(quickhl-tag-toggle)

nmap ys <Plug>(operator-surround-append)
nmap ds <Plug>(operator-surround-delete)
nmap cs <Plug>(operator-surround-replace)

map * <Plug>(asterisk-z*)

nnoremap [git] <Nop>
nmap     <Leader>g [git]
nnoremap <silent> [git]s :Gstatus<cr>
nnoremap <silent> [git]l :AgitFile<cr>
nnoremap <silent> [git]L :Agit<cr>

if executable('fcitx-remote')
  inoremap <esc> <esc>:CloseFcitx<cr>
  command! CloseFcitx :call system("fcitx-remote -c")
endif

" 現在日時を入力
" nmap <C-o><C-o> <ESC>i<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>

" Google 翻訳
set keywordprg=trans\ :ja

" エンコード
" set encoding=UTF-8
" set fileencoding=UTF-8
set fileencodings=utf-8,euc-jp,cp932
" set termencoding=UTF-8
" scriptencoding utf-8

" フォント
" set guifont=Consolas:h11:cANSI
set ambiwidth=double
" set antialias

" ファイル形式に応じて色づけ
syntax on

" カラースキーム
colorscheme desert

" 検索
set ignorecase
set smartcase
set incsearch
set hlsearch

set nrformats=hex

" ファイルパスの区切り文字
" set noshellslash

" クリップボード
set clipboard=unnamedplus,unnamed

" バックアップファイル
set nobackup

" スワップファイル
set noswapfile
set directory=~/.vim/tmp

" アンドゥファイル
set noundofile

" シェル
" set shell=bash.bat

" 行数・列数
" set lines=60
" set columns=110

" マウス
set mouse=h

" ステータスの表示
set laststatus=2
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 行番号を表示
set number

" 行・列のハイライト
set cursorline
set cursorcolumn

" 行を常に中央に
set scrolloff=999

" 折り返しを禁止
set nowrap

" 対応する括弧を強調表示
set showmatch

" タブ・インデント
set expandtab " タブをスペースに変換しない
set tabstop=2 " タブをスペース何個で表示するか
set shiftwidth=2 " >>などで挿入される量
set softtabstop=0 " タブを押した時の挿入量 0の場合tabstopの値になる。
" set autoindent

" タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" カレントディレクトリの自動切換え
set noautochdir

" タブページを常に表示
set showtabline=2
" gVimでもテキストベースのタブページを使う
set guioptions-=e
" タブの表示
set guitablabel=%N:\ %{util#GuiTabLabel()}

" GUIオプション
set guioptions-=T
set guioptions-=m
set guioptions-=r

"---------------------------
" Start Neobundle Settings.
"---------------------------
set runtimepath+=~/.vim/bundle/NeoBundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/NeoBundle.vim'

" Vim Proc
NeoBundle 'Shougo/VimProc.vim',
\ { 'build' : {
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }

" Vim Filer
let g:vimfiler_as_default_explorer = 1 " デフォルトのファイラとして設定
NeoBundle 'Shougo/vimfiler.vim'

" Unite
let g:unite_split_rule                 = 'botright' " 分割方向
let g:unite_source_history_yank_enable = 1 " yank履歴の有効化
NeoBundle 'Shougo/unite.vim'

" Unite Color Scheme
NeoBundle 'ujihisa/unite-colorscheme'

" Quick Fix
NeoBundle 'osyo-manga/unite-quickfix.git'

" Vim Shell
NeoBundle 'Shougo/vimshell'

" Quick Run
let g:quickrun_config = {
\   '_' : {
\     'runner' : 'vimproc',
\     'runner/vimproc/updatetime' : 50
\   },
\   'watchdogs_checker/_' : {
\     'outputter/quickfix/open_cmd' : '',
\   },
\ }
NeoBundle 'thinca/vim-quickrun'

" Shabadou
NeoBundle 'osyo-manga/shabadou.vim'

" Watchdogs
let g:watchdogs_check_BufWritePost_enable = 1
if util#depend_cui_tool('vint', 'pip install vim-vint')
  let g:quickrun_config['vim/watchdogs_checker']             = {'type': 'watchdogs_checker/vint'}
  let g:quickrun_config['watchdogs_checker/vint']            = {}
  let g:quickrun_config['watchdogs_checker/vint']['command'] = 'vint'
  let g:quickrun_config['watchdogs_checker/vint']['exec']    = '%c %s'
endif
NeoBundle 'osyo-manga/vim-watchdogs'
" call watchdogs#setup(g:quickrun_config)

" Quickfix Status
NeoBundle 'dannyob/quickfixstatus'

" Hier
NeoBundle 'cohama/vim-hier'

" Neo Complete
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
NeoBundle 'Shougo/neocomplete.vim'

" Junkfile
NeoBundle 'Shougo/junkfile.vim'

" Easymotion
let g:EasyMotion_do_mapping       = 0 " デフォルトのマッピングを削除
let g:EasyMotion_smartcase        = 1 " 大文字小文字の違いを無視
let g:EasyMotion_use_smartsign_jp = 1 " キー位置の同じ文字は一致とみなす
let g:EasyMotion_use_upper        = 1 " labelの文字を大文字にする
let g:EasyMotion_keys             = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
NeoBundle 'Lokaltog/vim-easymotion'

" Easy Align
NeoBundle 'junegunn/vim-easy-align'

" Light Line
let g:lightline = {
      \   'colorscheme': 'wombat',
      \   'active': {
      \     'left': [
      \       [ 'mode', 'paste' ],
      \       [ 'readonly', 'absolutepath', 'modified' ]
      \     ],
      \     'right': [
      \       [ 'lineinfo', 'percent' ],
      \       [ 'fugitive' ],
      \       [ 'fileformat', 'fileencoding', 'filetype' ]
      \     ]
      \   },
      \   'component': {
      \     'readonly': '%{&readonly?"✖":""}',
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
      \   },
      \   'component_visible_condition': {
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \   },
      \ }
NeoBundle 'itchyny/lightline.vim'

" Fugitive
NeoBundle 'tpope/vim-fugitive'

" Agit
NeoBundle 'cohama/agit.vim'

" Multiple Cursors
NeoBundle 'terryma/vim-multiple-cursors'

" Caw
NeoBundle "tyru/caw.vim.git"

" Tagbar
NeoBundle 'majutsushi/tagbar'

" Quick Highlight
NeoBundle "t9md/vim-quickhl"

" Operator Surround
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround',
\ { 'depends' : 'kana/vim-operator-user' }

" Over
NeoBundle 'osyo-manga/vim-over'

" Asterisk
let g:asterisk#keeppos = 1
NeoBundle 'haya14busa/vim-asterisk'

" Coffee Script
NeoBundle 'kchmck/vim-coffee-script',
\ { 'autoload' : { 'filetypes' : ['coffee'] } }

" Jade
NeoBundle 'digitaltoad/vim-jade',
\ { 'autoload' : { 'filetypes' : ['jade'] } }

" Thumbnail
" NeoBundle 'itchyny/thumbnail.vim'

" Unite Mark
" NeoBundle 'tacroe/unite-mark'

" Emmet
" NeoBundle 'mattn/emmet-vim'

" Quick Fix Sign
" let g:qfsigns#AutoJump = 1
" NeoBundle 'KazuakiM/vim-qfsigns'

" Auto Ctags
" let g:auto_ctags                = 1
" let g:auto_ctags_directory_list = ['.git', '.svn']
" NeoBundle 'soramugi/auto-ctags.vim'

" Scss
" NeoBundle 'cakebaker/scss-syntax.vim'

" Sass
" NeoBundle 'AtsushiM/sass-compile.vim'

" Tern
" NeoBundleLazy 'marijnh/tern_for_vim'
" NeoBundleLazy 'othree/tern_for_vim_coffee', {'autoload': {'on_source': 'tern_for_vim'}}

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"-------------------------
" End Neobundle Settings.
"-------------------------
