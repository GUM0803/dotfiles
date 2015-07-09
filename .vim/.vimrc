let s:is_win   = has('win32') || has('win64')
let s:is_mingw = system('uname') =~? '^MINGW'
let s:is_mac   = has('mac') || system('uname') =~? '^darwin'
let s:is_linux = !s:is_mac && has('unix')

set encoding=UTF-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
" set termencoding=UTF-8
if s:is_win || s:is_mingw
  " set termencoding=cp932
endif
scriptencoding utf-8

" Utility Functions"{{{
function! s:warn(msg)
  echohl WarningMsg | echo a:msg | echohl None
endfunction

function! s:depend_cui_tool(cmd, ...)
  let l:able = executable(a:cmd)
  if !l:able
    call s:warn('コマンドラインツール「' . a:cmd . '」が見つかりません')
    if exists('a:1')
      call s:warn(a:1)
    endif
  endif
  return l:able
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

function! s:line_info()
  let name     = expand('%:t')
  let line_no  = line('.')
  let line_str = getline(line_no)
  redir @*>
  echo printf('%s:%d %s', name, line_no, line_str)
  redir END
endfunction

function! s:provide_tab_label()
  let l:label = ''
  let l:bufnrlist = tabpagebuflist(v:lnum)
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  for bufnr in l:bufnrlist
    if getbufvar(bufnr, '&modified')
      let l:label .= '[+]'
      break
    endif
  endfor

  return l:label
endfunction

function! s:get_outerdoc_name()
  let l:path = expand('%:p')
  return substitute(l:path, '/\|:', '_', 'g') . '.md'
endfunction

function! s:setup_source_buffer()
  setlocal cursorbind
endfunction

function! s:setup_outerdoc_buffer()
  setlocal cursorbind
endfunction

function! s:create_outerdoc_dir(path)
  let l:outerdoc_dir = fnamemodify(a:path, ':h')
  if !isdirectory(l:outerdoc_dir)
    call mkdir(l:outerdoc_dir, 'p')
  endif
endfunction

function! s:fill_in_blank_line(path, count_line)
  let l:blank_lines = map(range(a:count_line), '""')
  call writefile(l:blank_lines, a:path)
endfunction

function! s:prepare_outerdoc(path, count_line)
  if !filewritable(a:path)
    call s:create_outerdoc_dir(a:path)
    call s:fill_in_blank_line(a:path, a:count_line)
  endif
endfunction

function! s:open_outerdoc_buffer(path, cursor_line)
  belowright 50vnew `=a:path`
  execute ':normal ' . a:cursor_line . 'G'
endfunction

function! s:outerdoc_open()
  let l:count_line = line('$')
  let l:cursor_line = line('.')
  let l:outerdoc_path = expand('~/.outerdoc/' . s:get_outerdoc_name())

  call s:setup_source_buffer()
  call s:prepare_outerdoc(l:outerdoc_path, l:count_line)
  call s:open_outerdoc_buffer(l:outerdoc_path, l:cursor_line)
  call s:setup_outerdoc_buffer()
endfunction

command! OuterDocOpen call s:outerdoc_open()

" Codic Complete "{{{
" https://gist.github.com/sgur/4e1cc8e93798b8fe9621
" http://sgur.tumblr.com/post/91906146884/codic-vim
inoremap <silent> <C-x><C-t>  <C-R>=<SID>codic_complete()<CR>
function! s:codic_complete()
  let line = getline('.')
  let start = match(line, '\k\+$')
  let cand = s:codic_candidates(line[start :])
  call complete(start +1, cand)
  return ''
endfunction
function! s:codic_candidates(arglead)
  let cand = codic#search(a:arglead, 30)
  " error
  if type(cand) == type(0)
    return []
  endif
  " english -> english terms
  if a:arglead =~# '^\w\+$'
    return map(cand, '{"word": v:val["label"], "menu": join(map(copy(v:val["values"]), "v:val.word"), ",")}')
  endif
  " japanese -> english terms
  return s:reverse_candidates(cand)
endfunction
function! s:reverse_candidates(cand)
  let _ = []
  for c in a:cand
    for v in c.values
      call add(_, {'word': v.word, 'menu': !empty(v.desc) ? v.desc : c.label })
    endfor
  endfor
  return _
endfunction
"}}}
"}}}

" Plugins"{{{
set runtimepath+=~/.vim/bundle/NeoBundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/NeoBundle.vim'
" Vim Proc {{{
NeoBundle 'Shougo/VimProc.vim',
      \ { 'build' : {
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
" }}}
" Vim Filer {{{
let g:vimfiler_as_default_explorer = 1 " デフォルトのファイラとして設定
let g:vimfiler_ignore_pattern      = '' " 非表示にするファイルのパターン
NeoBundle 'Shougo/vimfiler.vim'
" }}}
" Color Scheme Solarized {{{
if !has('gui_running')
  let g:solarized_termcolors=256
endif
NeoBundle 'altercation/vim-colors-solarized'
" }}}
" Color Scheme mustang {{{
NeoBundle 'croaker/mustang-vim'
" }}}
" Color Scheme jellybeans {{{
NeoBundle 'nanotech/jellybeans.vim'
" }}}
" Color Scheme molokai {{{
NeoBundle 'tomasr/molokai'
" }}}
" Unite {{{
let g:unite_split_rule                 = 'botright' " 分割方向
let g:unite_source_history_yank_enable = 1 " yank履歴の有効化
NeoBundle 'Shougo/unite.vim'
" }}}
" Unite Color Scheme {{{
NeoBundle 'ujihisa/unite-colorscheme'
" }}}
" Quick Fix {{{
NeoBundle 'osyo-manga/unite-quickfix.git'
" }}}
" Vim Shell {{{
NeoBundle 'Shougo/vimshell'
" }}}
" Quick Run {{{
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
" }}}
" Shabadou {{{
NeoBundle 'osyo-manga/shabadou.vim'
" }}}
" Watchdogs {{{
let g:watchdogs_check_BufWritePost_enable = 1
if s:depend_cui_tool('vint', 'pip install vim-vint')
  let g:quickrun_config['vim/watchdogs_checker']             = {'type': 'watchdogs_checker/vint'}
  let g:quickrun_config['watchdogs_checker/vint']            = {}
  let g:quickrun_config['watchdogs_checker/vint']['command'] = 'vint'
  let g:quickrun_config['watchdogs_checker/vint']['exec']    = '%c %s'
endif
NeoBundle 'osyo-manga/vim-watchdogs'
" call watchdogs#setup(g:quickrun_config)
" " }}}
" Quickfix Status {{{
NeoBundle 'dannyob/quickfixstatus'
" }}}
" Hier {{{
NeoBundle 'cohama/vim-hier'
" }}}
" Neo Complete {{{
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
" }}}
" Neo Snippet {{{
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" }}}
" Junkfile {{{
NeoBundle 'Shougo/junkfile.vim'
" }}}
" Easymotion {{{
let g:EasyMotion_do_mapping       = 0 " デフォルトのマッピングを削除
let g:EasyMotion_smartcase        = 1 " 大文字小文字の違いを無視
let g:EasyMotion_use_smartsign_jp = 1 " キー位置の同じ文字は一致とみなす
let g:EasyMotion_use_upper        = 1 " labelの文字を大文字にする
let g:EasyMotion_keys             = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
NeoBundle 'Lokaltog/vim-easymotion'
" }}}
" Easy Align {{{
NeoBundle 'junegunn/vim-easy-align'
" }}}
" Light Line {{{
let g:lightline = {
      \   'colorscheme': 'wombat',
      \   'active': {
      \     'left': [
      \       [ 'mode', 'paste' ],
      \       [ 'readonly', 'pwd', 'absolutepath', 'tagbar', 'anzu', 'modified' ]
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
      \     'tagbar': '%{tagbar#currenttag("%s", "")}',
      \   },
      \   'component_function': {
      \     'anzu': 'anzu#search_status',
      \     'pwd': 'getcwd',
      \   },
      \   'component_visible_condition': {
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \   },
      \ }
NeoBundle 'itchyny/lightline.vim'
" }}}
" Fugitive {{{
NeoBundle 'tpope/vim-fugitive'
" }}}
" Agit {{{
NeoBundle 'cohama/agit.vim'
" }}}
" Multiple Cursors {{{
NeoBundle 'terryma/vim-multiple-cursors'
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
" }}}
" Caw {{{
NeoBundle "tyru/caw.vim.git"
" }}}
" Tagbar {{{
let g:tagbar_left = 1
NeoBundle 'majutsushi/tagbar'
" }}}
" Quick Highlight {{{
NeoBundle "t9md/vim-quickhl"
" }}}
" Operator Surround {{{
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-operator-surround',
      \ { 'depends' : 'kana/vim-operator-user' }
" }}}
" Over {{{
NeoBundle 'osyo-manga/vim-over'
" }}}
" Asterisk {{{
let g:asterisk#keeppos = 1
NeoBundle 'haya14busa/vim-asterisk'
" }}}
" Coffee Script {{{
NeoBundleLazy 'kchmck/vim-coffee-script',
      \ { 'autoload' : { 'filetypes' : ['coffee'] } }
" }}}
" Jade {{{
NeoBundleLazy 'digitaltoad/vim-jade',
      \ { 'autoload' : { 'filetypes' : ['jade'] } }
" }}}
" Vim Json "{{{
NeoBundleLazy 'elzr/vim-json',
      \ { 'autoload' : { 'filetypes' : ['json'] } }
"}}}
" Open Browser "{{{
NeoBundleLazy 'tyru/open-browser.vim',
      \ { 'autoload' : { 'filetypes' : ['markdown'] } }
"}}}
" Previm "{{{
let g:previm_disable_default_css = 1
let g:previm_custom_css_path     = expand('~/.vim/bundle/github-markdown-css/github-markdown.css')
NeoBundleLazy 'kannokanno/previm',
      \ { 'autoload' : { 'filetypes' : ['markdown'] } }
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"}}}
" Github Markdown Css "{{{
NeoBundleFetch 'tigmium/github-markdown-css'
"}}}
" Indent Line "{{{
NeoBundle 'Yggdroot/indentLine'
"}}}
" Memo List "{{{
NeoBundle 'glidenote/memolist.vim'
"}}}
" Git Gutter "{{{
NeoBundle 'airblade/vim-gitgutter'
"}}}
" Signature "{{{
NeoBundle 'kshenoy/vim-signature'
"}}}
" Unite Mark {{{
NeoBundle 'tacroe/unite-mark'
" " }}}
" Anzu "{{{
let g:anzu_status_format = '(%i/%l)'
NeoBundle 'osyo-manga/vim-anzu'
"}}}
" Codic "{{{
NeoBundle 'koron/codic-vim'
"}}}
" Colorizer "{{{
NeoBundle 'lilydjwg/colorizer'
"}}}
" 2hs "{{{
NeoBundleLazy 'dag/vim2hs',
      \ { 'autoload' : { 'filetypes' : ['haskell'] } }
"}}}
" Ghcmod "{{{
NeoBundleLazy 'eagletmt/ghcmod-vim',
      \ { 'autoload' : { 'filetypes' : ['haskell'] } }
"}}}
" Neco Ghc "{{{
NeoBundleLazy 'ujihisa/neco-ghc',
      \ { 'autoload' : { 'filetypes' : ['haskell'] } }
"}}}
" Rust "{{{
NeoBundle 'rust-lang/rust.vim'
"}}}
" Operator Replace "{{{
NeoBundle 'kana/vim-operator-replace'
"}}}
" Dockerfile "{{{
NeoBundle 'ekalinin/Dockerfile.vim'
"}}}

" Unused Plugins "{{{
" Dynamic Window Manager {{{
" NeoBundle 'spolu/dwm.vim'
" " }}}
" Tabman {{{
" NeoBundle 'kien/tabman.vim'
" " }}}
" Thumbnail {{{
" NeoBundle 'itchyny/thumbnail.vim'
" " }}}
" Emmet {{{
" NeoBundle 'mattn/emmet-vim'
" " }}}
" Quick Fix Sign {{{
" let g:qfsigns#AutoJump = 1
" NeoBundle 'KazuakiM/vim-qfsigns'
" " }}}
" Auto Ctags {{{
" let g:auto_ctags                = 1
" let g:auto_ctags_directory_list = ['.git', '.svn']
" NeoBundle 'soramugi/auto-ctags.vim'
" " }}}
" Scss {{{
" NeoBundle 'cakebaker/scss-syntax.vim'
" " }}}
" Sass {{{
" NeoBundle 'AtsushiM/sass-compile.vim'
" " }}}
" Tern {{{
" NeoBundleLazy 'marijnh/tern_for_vim'
" NeoBundleLazy 'othree/tern_for_vim_coffee', {'autoload': {'on_source': 'tern_for_vim'}}
" Unite Giti "{{{
" NeoBundle 'kmnk/vim-unite-giti'
"}}}
" " }}}
"}}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"}}}

" Key Binds"{{{
let mapleader = ' '

nnoremap <esc> :noh<cr>

" タブ切り替え
nnoremap 1<Leader> 1gt
nnoremap 2<Leader> 2gt
nnoremap 3<Leader> 3gt
nnoremap 4<Leader> 4gt
nnoremap 5<Leader> 5gt
nnoremap 6<Leader> 6gt
nnoremap 7<Leader> 7gt
nnoremap 8<Leader> 8gt
nnoremap 9<Leader> 9gt
nnoremap 0<Leader> 10gt
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
nnoremap <silent> [unite]q :Unite -tab -max-multi-lines=1 quickfix<cr>

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

nnoremap [git] <Nop>
nmap     <Leader>g [git]
nnoremap <silent> [git]s :Gstatus<cr>
nnoremap <silent> [git]l :AgitFile<cr>
nnoremap <silent> [git]L :Agit<cr>

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

nmap n n<Plug>(anzu-update-search-status)
nmap N N<Plug>(anzu-update-search-status)
map * <Plug>(asterisk-z*)<Plug>(anzu-update-search-status)

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

if executable('fcitx-remote')
  inoremap <esc> <esc>:CloseFcitx<cr>
  command! CloseFcitx :call system("fcitx-remote -c")
endif

nmap <Leader>p <Plug>(operator-replace)
"}}}

" Options"{{{
if has('vim_starting') 
  if executable('xset')
    call system('xset r rate 200 30')
  endif
endif

" Google 翻訳
if s:depend_cui_tool('trans', 'https://github.com/soimort/translate-shell')
  set keywordprg=trans\ :ja
endif

" フォント
if s:is_win
  set guifont=Consolas:h11:cANSI
endif
set ambiwidth=double
" set antialias

" ファイル形式に応じて色づけ
syntax enable

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
" if s:is_mingw
"   set termencoding=UTF-8
"   set shell=E:/Software/Mingw/msys/1.0/bin/mintty\ /bin/bash\ -l
"   set shellcmdflag=-c
" endif

" 行数・列数
if s:is_win
  set lines=60
  set columns=110
endif

" マウス
set mouse=h

" ステータスの表示
set laststatus=2
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" 行番号を表示
set number

" 行・列のハイライト
set nocursorline
set nocursorcolumn

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
set guitablabel=%N:\ %{s:provide_tab_label()}

" GUIオプション
set guioptions-=T
set guioptions-=m
set guioptions-=r

" 折り畳み
set foldmethod=marker

" ターミナルの色数
if !has('gui_running')
  set t_Co=256
endif

" カラースキーム
set background=dark
colorscheme solarized

" ファイル名補完
set wildmode=list:full
"}}}
