let mapleader = " "

au BufRead,BufNewFile *.scss set filetype=sass

nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
nnoremap <Down> <C-w>j
nnoremap <Left> <C-w>h

nnoremap <C-Right> <C-PageDown>
nnoremap <C-Left> <C-PageUp>

nnoremap <esc> :noh<Enter>

nnoremap <silent> gl gt
nnoremap <silent> gh gT

nnoremap [unite] <Nop>
nmap     <Leader>u [unite]
nnoremap <silent> [unite]b :Unite -resume -tab -auto-preview buffer<Enter>
nnoremap <silent> [unite]q :Unite -tab -auto-preview quickfix<Enter>
nnoremap <silent> [unite]g :Unite -resume -tab -auto-preview grep<Enter>
nnoremap <silent> [unite]m :Unite -resume -tab -auto-preview mark<Enter>
nnoremap <silent> [unite]y :Unite -resume history/yank<Enter>
nnoremap <silent> [unite]B :Unite -resume bookmark<Enter>

nnoremap [vimfiler] <Nop>
nmap     <Leader>f [vimfiler]
nnoremap <silent> [vimfiler]b :VimFilerBufferDir -force-quit -status -edit-action=tabswitch<enter>
nnoremap <silent> [vimfiler]c :VimFilerCurrentDir -force-quit -status -edit-action=tabswitch<enter>

nmap <Leader>r <Plug>(quickrun)

nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
nmap w <Plug>(easymotion-bd-wl)
vmap w <Plug>(easymotion-bd-wl)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
vmap <Leader>j <Plug>(easymotion-j)
vmap <Leader>k <Plug>(easymotion-k)

nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

vmap <Enter> <Plug>(EasyAlign)

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
" set ambiwidth=double
" set antialias

" カラースキーム
colorscheme desert

" ファイル形式に応じて色づけ
syntax on

" 起動時のモード
set iminsert=0

" 検索
set ignorecase
set smartcase
set incsearch
set hlsearch

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

" GUIオプション
set guioptions-=T
set guioptions-=m
set guioptions-=r

"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリ
set runtimepath+=~/.vim/bundle/NeoBundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/NeoBundle.vim'
 
" Vim Proc
NeoBundle 'Shougo/VimProc.vim'

" Quick Run
let g:quickrun_config = {
\	"_" : {
\		"runner" : "vimproc",
\		"runner/vimproc/updatetime" : 50
\	},
\	"watchdogs_checker/_" : {
\		'outputter/quickfix/open_cmd' : '',
\	},
\}
NeoBundle 'thinca/vim-quickrun'

" Vim Shell
NeoBundle 'Shougo/vimshell'

" Unite
let g:unite_split_rule                 = 'botright' " 分割方向
let g:unite_source_history_yank_enable = 1 " yank履歴の有効化
NeoBundle 'Shougo/unite.vim'

" Unite Quick Fix
NeoBundle 'osyo-manga/unite-quickfix.git'

" Unite Mark
NeoBundle 'tacroe/unite-mark'

" VimFiler
let g:vimfiler_as_default_explorer = 1 " デフォルトのファイラとして設定
NeoBundle 'Shougo/vimfiler.vim'

" Neo Completion
" NeoBundle 'Shougo/neocomplete.vim'
" let g:neocomplcache_enable_at_startup = 1 " 自動起動
" let g:neocomplcache_enable_underbar_completion = 1 " アンダーバー区切りを補完

" Junk File
NeoBundle 'Shougo/junkfile.vim'

" EasyMotion
let g:EasyMotion_do_mapping       = 0 " デフォルトのマッピングを削除
let g:EasyMotion_smartcase        = 1 " 大文字小文字の違いを無視
let g:EasyMotion_use_smartsign_jp = 1 " キー位置の同じ文字は一致とみなす
let g:EasyMotion_use_upper        = 1 " labelの文字を大文字にする
let g:EasyMotion_keys             = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
NeoBundle 'Lokaltog/vim-easymotion'

" Easy Align
NeoBundle 'junegunn/vim-easy-align'

" Fugitive
NeoBundle 'tpope/vim-fugitive'
 
" WatchDogs
let g:watchdogs_check_BufWritePost_enable = 1
NeoBundle 'osyo-manga/vim-watchdogs'
" call watchdogs#setup(g:quickrun_config)

" Shabadou
NeoBundle 'osyo-manga/shabadou.vim'

" Hier
NeoBundle 'cohama/vim-hier'

" Quick Fix Status
NeoBundle 'dannyob/quickfixstatus'

" Emmet (html css helper)
NeoBundle 'mattn/emmet-vim'

" Light Line
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
\	'colorscheme': 'wombat'
\}

" Quick Fix Signs
" let g:qfsigns#AutoJump = 1
" NeoBundle 'KazuakiM/vim-qfsigns'

" Multiple Cursor
NeoBundle 'terryma/vim-multiple-cursors'

" Caw
NeoBundle "tyru/caw.vim.git"

" Tag Bar
NeoBundle "majutsushi/tagbar"

" Coffee Script
NeoBundle "kchmck/vim-coffee-script"

" Sass Syntax
" NeoBundle "cakebaker/scss-syntax.vim"

" Sass Compile
" NeoBundle "AtsushiM/sass-compile.vim"

" NeoBundleLazy 'marijnh/tern_for_vim'
" NeoBundleLazy 'othree/tern_for_vim_coffee', {'autoload': {'on_scurce': 'tern_for_vim'}}
" if neobundle#tap('tern_for_vim')
"     if executable('npm')
"         call neobundle#config({'build': {'others': 'npm install && npm install tern-coffee'}})
"         call neobundle#config({'autoload': {'filetypes': ['javascript', 'coffee']}})
"     endif
"     call neobundle#untap()
" endif

call neobundle#end()
 
" Required:
filetype plugin indent on
 
NeoBundleCheck
"-------------------------
" End Neobundle Settings.
"-------------------------

function! LN()
	let name     = expand('%:t')
	let line_no  = line('.')
	let line_str = getline(line_no)
	redir @*>
	echo printf("%s:%d %s", name, line_no, line_str)
	redir END
endfunction

" 個別のタブの表示設定をします
function! GuiTabLabel()
	" タブで表示する文字列の初期化をします
	let l:label = ''

	" タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
	let l:bufnrlist = tabpagebuflist(v:lnum)

	" 表示文字列にバッファ名を追加します
	" パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
	let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
	" バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
	let l:label .= l:bufname == '' ? 'No title' : l:bufname

	" タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
	" let l:wincount = tabpagewinnr(v:lnum, '$')
	" if l:wincount > 1
	" 	let l:label .= '[' . l:wincount . ']'
	" endif

	" このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
	for bufnr in l:bufnrlist
		if getbufvar(bufnr, "&modified")
			let l:label .= '[+]'
			break
		endif
	endfor

	" 表示文字列を返します
	return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N:\ %{GuiTabLabel()}
