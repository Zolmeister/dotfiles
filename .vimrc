" Journal Mode - no clutter, never lose changes
function! EnterJournalMode()
		set updatecount=1
		set undofile
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
		set shortmess=F
		highlight EndOfBuffer ctermfg=black ctermbg=black
		redraw
		echo ""
endfunction

nnoremap <S-j> :call EnterJournalMode()<CR>
