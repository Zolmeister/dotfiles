" Journal Mode - no clutter, never lose changes
function! EnterJournalMode()
		autocmd TextChanged,TextChangedI <buffer> :silent update
		autocmd CursorHold,CursorHoldI <buffer> :call GitCommit()
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
		set shortmess=F
		redraw
		echo ""
endfunction

function GitCommit()
    :silent !git commit -am'updated'
		:redraw!
endfunction

nnoremap <S-j> :call EnterJournalMode()<CR>
