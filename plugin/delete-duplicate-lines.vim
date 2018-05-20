" Maintainer: Steven Hall

if exists('g:delete_duplicate_lines#loaded')
  finish
endif
let g:delete_duplicate_lines#loaded = 1

" A string of allowed registers
let s:allowed_characters = 'abcdefghijklmnopqrstuvwxyz_'

" If the user has setup their own register to use, then use it
if exists('g:delete_duplicate_lines#register')
  " Only use the first character as we only want 1 character.
  let s:register = tolower(g:delete_duplicate_lines#register[0])
  let s:register_append = toupper(g:delete_duplicate_lines#register[0])

  " If the input was empty, use the blackhole register
  " Checking this here in case the input isn't empty, but the first character is
  if s:register ==# '' || s:register ==# ' '
    let s:register = '_'
    let s:register_append = '_'
  endif

  " Check to see that the input is a valid register we can use
  if s:allowed_characters !~ s:register
    let s:message = " is not valid. It must be an alpha char or '_'"
    echoe 'g:delete_duplicate_lines#register' . s:message
    finish
  endif
else
  " If all else fails, we will just use 'd'
  let s:register = 'd'
  let s:register_append = 'D'
endif

function! s:delete_duplicate_lines(mode)
  " Counter to count the number of lines deleted
  let l:c=0

  " Set the '<,'> registers
  if a:mode ==? 'normal'
    " Select the current paragraph
    exe "normal! vip\<esc>"
  elseif a:mode ==? 'visual'
    " Reselect the visual selection that the user just made
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
  "   - If the count is at 0 it doesn't append, it just resets the register
  " - Increment a counter
  silent '<,'>g/^/kl |
        \ if search('^'.escape(getline('.'),'\.*[]^$/').'$','bW', line("'<")) |
        \   if l:c == 0 |
        \     exe "'ld " . s:register |
        \     let l:c=l:c+1 |
        \   else |
        \     exe "'ld " . s:register_append |
        \     let l:c=l:c+1 |
        \   endif |
        \ endif
  " Turn off highlighting as the global command highlights text
  nohl
  " Display a message with how many lines were removed
  let l:message = ' Duplicate lines removed.'
  if s:register !=# '_'
    let l:message = l:message . " They are saved in register '"
    let l:message = l:message . s:register . "'."
  endif
  echom l:c . l:message
endfunction

" Normal mode version will automatically remove duplicates from the current
" paragraph
nnoremap <Plug>DeleteDuplicateLines :call <SID>delete_duplicate_lines('normal')<cr>

" Visual mode will remove duplicate lines that exist within the visual selection
vnoremap <Plug>DeleteDuplicateLinesVisual <esc>:call <SID>delete_duplicate_lines('visual')<cr>
