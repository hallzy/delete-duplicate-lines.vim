" Maintainer: Steven Hall

if exists('g:delete_duplicate_lines#loaded')
  finish
endif
let g:delete_duplicate_lines#loaded = 1

function! s:delete_duplicate_lines(mode)
  " Counter to count the number of lines deleted
  let l:c=0

  " Clear register 'd' as we will be saving the deleted lines here.
  call setreg('d','')

  if a:mode ==? 'normal'
    " Select the current paragraph
    exe "normal! vip\<esc>"
  elseif a:mode ==? 'visual'
    " Select the current paragraph
    exe "normal! gv\<esc>"
  else
    echoe "Argument '" . a:mode "' unknown."
    return
  endif

  " Silently:
  " - Globally mark all the lines
  " - If the current line exists from the current line to the beginning of my
  "   visual selection...
  " - Delete it and append the line to register D
  " - Increment a counter
  silent '<,'>g/^/kl|
        \ if search('^'.escape(getline('.'),'\.*[]^$/').'$','bW', line("'<"))|
        \ 'ld D|
        \ let l:c=l:c+1
  " Turn off highlighting as the global command highlights text
  nohl
  " Display a message with how many lines were removed
  echom l:c . " Duplicate Lines Removed. They are saved in register 'd'."
endfunction

" Normal mode version will automatically remove duplicates from the current
" paragraph
nnoremap <Plug>DeleteDuplicateLines :call <SID>delete_duplicate_lines('normal')<cr>
vnoremap <Plug>DeleteDuplicateLinesVisual <esc>:call <SID>delete_duplicate_lines('visual')<cr>
