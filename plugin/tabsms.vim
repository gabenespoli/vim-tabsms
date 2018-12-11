" Tabline {{{2
" Rename tabs to show tab# and # of viewports
" http://stackoverflow.com/questions/5927952/whats-the-implementation-of-vims-default-tabline-function
set tabline=%!SMSTabline()
function! SMSTabline() "{{{
  let s = ''
  let wn = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)

    let s .= '%#TabLineFill#'
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= ''
    let wn = tabpagewinnr(i,'$')

    "tab/window number
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let s .= '[' . i
    if tabpagewinnr(i,'$') > 1
      let s .= '|'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
    end
    let s .= ']%*'

    "modified flag
    let s .= (i == t ? '%#TabModSel#%m' : '%#TabMod#')
    let s .= ' %*'

    "filename
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
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

    " space until next tab
    let s .= file . ' ' . '%#TablineFill# %*'

    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  return s
endfunction "}}}



