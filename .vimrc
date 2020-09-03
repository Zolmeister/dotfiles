" Journal Mode - no clutter, never lose changes
function! EnterJournalMode()
  set updatecount=1
  set undofile
  set noshowmode
  set noruler
  set laststatus=0
  set noshowcmd
  set shortmess=F
  highlight EndOfBuffer ctermfg=0
  redraw
  echo "jrnl_mode!"
endfunction

nnoremap <S-j> :call EnterJournalMode()<CR>

if expand('%:t') == 'one_liners2'
	call EnterJournalMode()
endif
