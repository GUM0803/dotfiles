let mapleader = ' '

nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
nnoremap <Down> <C-w>j
nnoremap <Left> <C-w>h

nnoremap <C-Right> <C-PageDown>
nnoremap <C-Left> <C-PageUp>

nnoremap <esc> :noh<cr>

nnoremap <silent> gl gt
nnoremap <silent> gh gT

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
" set ambiwidth=double
" set antialias

" カラースキーム
colorscheme desert

" ファイル形式に応じて色づけ
syntax on

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
 
NeoBundle 'Shougo/VimProc.vim',
\ { 'build' : {
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'osyo-manga/unite-quickfix.git'
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'cohama/vim-hier'
NeoBundle 'Shougo/junkfile.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle "tyru/caw.vim.git"
NeoBundle 'majutsushi/tagbar'
NeoBundle "t9md/vim-quickhl"
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround',
\ { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'haya14busa/vim-asterisk'
NeoBundle 'kchmck/vim-coffee-script',
\ { 'autoload' : { 'filetypes' : ['coffee'] } }
NeoBundle 'digitaltoad/vim-jade',
\ { 'autoload' : { 'filetypes' : ['jade'] } }

" NeoBundle 'tacroe/unite-mark'
" NeoBundle 'Shougo/neocomplete.vim'
" NeoBundle 'mattn/emmet-vim'
" NeoBundle 'KazuakiM/vim-qfsigns'
" NeoBundle 'soramugi/auto-ctags.vim'
" NeoBundle 'cakebaker/scss-syntax.vim'
" NeoBundle 'AtsushiM/sass-compile.vim'
" NeoBundleLazy 'marijnh/tern_for_vim'
" NeoBundleLazy 'othree/tern_for_vim_coffee', {'autoload': {'on_source': 'tern_for_vim'}}

function! s:on_source_unite_vim(bundle)
  nnoremap [unite] <Nop>
  nmap     <Leader>u [unite]
  nnoremap <silent> [unite]b :Unite buffer<cr>
  nnoremap <silent> [unite]m :Unite mark<cr>
  nnoremap <silent> [unite]y :Unite history/yank<cr>
  nnoremap <silent> [unite]B :Unite bookmark<cr>
  nnoremap <silent> [unite]q :Unite -tab -auto-preview quickfix<cr>
  nnoremap <silent> [unite]g :Unite -tab -auto-preview grep<cr>

  let g:unite_split_rule                 = 'botright' " 分割方向
  let g:unite_source_history_yank_enable = 1 " yank履歴の有効化
endfunction

function! s:on_source_vim_quickrun(bundle)
  nmap <Leader>r <Plug>(quickrun)

  let g:quickrun_config = {
\   '_' : {
\     'runner' : 'vimproc',
\     'runner/vimproc/updatetime' : 50
\   },
\   'watchdogs_checker/_' : {
\     'outputter/quickfix/open_cmd' : '',
\   },
\ }
endfunction

function! s:on_source_vimfiler_vim(bundle)
  let g:vimfiler_as_default_explorer = 1 " デフォルトのファイラとして設定
endfunction

function! s:on_source_neocomplete_vim(bundle)
  let g:neocomplcache_enable_at_startup          = 1 " 自動起動
  let g:neocomplcache_enable_underbar_completion = 1 " アンダーバー区切りを補完
endfunction

function! s:on_source_vim_easymotion(bundle)
  nmap s         <Plug>(easymotion-s2)
  vmap s         <Plug>(easymotion-s2)
  nmap <Leader>j <Plug>(easymotion-j)
  nmap <Leader>k <Plug>(easymotion-k)
  vmap <Leader>j <Plug>(easymotion-j)
  vmap <Leader>k <Plug>(easymotion-k)
  let g:EasyMotion_do_mapping       = 0 " デフォルトのマッピングを削除
  let g:EasyMotion_smartcase        = 1 " 大文字小文字の違いを無視
  let g:EasyMotion_use_smartsign_jp = 1 " キー位置の同じ文字は一致とみなす
  let g:EasyMotion_use_upper        = 1 " labelの文字を大文字にする
  let g:EasyMotion_keys             = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
endfunction

function! s:on_source_vim_watchdogs(bundle)
  let g:watchdogs_check_BufWritePost_enable                  = 1
  let g:quickrun_config['vim/watchdogs_checker']             = {'type': 'watchdogs_checker/vint'}
  let g:quickrun_config['watchdogs_checker/vint']            = {}
  let g:quickrun_config['watchdogs_checker/vint']['command'] = 'vint'
  let g:quickrun_config['watchdogs_checker/vint']['exec']    = '%c %s'

  " call watchdogs#setup(g:quickrun_config)
endfunction

function! s:on_source_vim_easy_align(bundle)
  vmap <cr> <Plug>(EasyAlign)
endfunction

function! s:on_source_operator_surround_append(bundle)
  nmap ys <Plug>(operator-surround-append)
  nmap ds <Plug>(operator-surround-delete)
  nmap cs <Plug>(operator-surround-replace)
endfunction

function! s:on_source_lightline_vim(bundle)
  let g:lightline = {
\   'colorscheme': 'wombat'
\ }
endfunction

function! s:on_source_vim_qfsigns(bundle)
  let g:qfsigns#AutoJump = 1
endfunction

function! s:on_source_tagbar(bundle)
  nmap <Leader>o :TagbarToggle<cr>
endfunction

function! s:on_source_auto_ctags_vim(bundle)
  let g:auto_ctags                = 1
  let g:auto_ctags_directory_list = ['.git', '.svn']
endfunction

function! s:on_source_caw_vim(bundle)
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)
endfunction

function! s:on_source_vim_quickhl(bundle)
  nmap <Leader>m <Plug>(quickhl-manual-this)
  xmap <Leader>m <Plug>(quickhl-manual-this)
  nmap <Leader>M <Plug>(quickhl-manual-reset)
  xmap <Leader>M <Plug>(quickhl-manual-reset)
  nmap <Leader>h <Plug>(quickhl-cword-toggle)
  nmap <Leader>] <Plug>(quickhl-tag-toggle)
endfunction

function! s:on_source_vim_operator_surround(bundle)
  map * <Plug>(asterisk-z*)
endfunction

function! s:on_source_vim_asterisk(bundle)
  let g:asterisk#keeppos = 1
endfunction

function! s:on_source_vim_asterisk(bundle)
endfunction


function! s:to_camel(str)
  let l:words = split(a:str, '\W\+')
  call map(l:words, 'toupper(v:val[0]) . v:val[1:]')
  return join(l:words, '')
endfunction

function! s:to_snake(str)
  let l:words = split(a:str, '\W\+')
  call map(l:words, 'tolower(v:val)')
  return join(l:words, '_')
endfunction

function! s:setup_bundle()
  let l:bundles = neobundle#config#get_neobundles()
  for l:bundle in l:bundles
    let l:funcname = 's:on_source_' . s:to_snake(l:bundle['name'])
    if exists('*' . l:funcname)
      let l:bundle.hooks.on_source = function(l:funcname)
    endif
  endfor
endfunction
call s:setup_bundle()

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
  echo printf('%s:%d %s', name, line_no, line_str)
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
  "   let l:label .= '[' . l:wincount . ']'
  " endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, '&modified')
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
