function! util#warn(msg)
  echohl WarningMsg | echo a:msg | echohl None
endfunction

function! util#depend_cui_tool(cmd, ...)
  let l:able = executable(a:cmd)
  if !l:able
    call util#warn('コマンドラインツール「' . a:cmd . '」が見つかりません')
    if exists('a:1')
      call util#warn(a:1)
    endif
  endif
  return l:able
endfunction

function! util#to_camel(str)
  let l:words = split(a:str, '\W\+')
  call map(l:words, 'toupper(v:val[0]) . v:val[1:]')
  return join(l:words, '')
endfunction

function! util#to_snake(str)
  let l:words = split(a:str, '\W\+')
  call map(l:words, 'tolower(v:val)')
  return join(l:words, '_')
endfunction

function! util#LN()
  let name     = expand('%:t')
  let line_no  = line('.')
  let line_str = getline(line_no)
  redir @*>
  echo printf('%s:%d %s', name, line_no, line_str)
  redir END
endfunction

function! util#GuiTabLabel()
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
