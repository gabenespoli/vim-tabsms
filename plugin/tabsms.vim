" Tabline {{{2
" Rename tabs to show tab# and # of viewports
" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
set tabline=%!SMSTabline()
function! SMSTabline()
  let s = ''
  let wn = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)

    " TODO build the tab name without highlights, then use regex to insert
    " highlights

    let s .= '%#TabLineFill#'
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= ''
    let wn = tabpagewinnr(i,'$')

    " start of tab
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let s .= '[' . i

    ""tab/window number
    "if tabpagewinnr(i,'$') > 1
    "  let s .= '|'
    "  let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
    "end

    " separator
    let s .= ':' 

    "filename
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype ==? 'nofile'
      if file =~? '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file ==? ''
      let file = '[No Name]'
    endif
    let s .= file

    "modified flag
    let s .= '%*'
    let s .= (i == t ? '%#TabModSel#' : '%#TabMod#')
    let s .= (i == t ? '%m' : '')
    let s .= '%*'
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    " end of tab
    let s .= ']'

    " space until next tab
    let s .= '%#TablineFill#' . ' ' . '%*'

    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  return s
endfunction
