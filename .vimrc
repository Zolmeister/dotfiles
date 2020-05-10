" TODO: backup to cloud (encrypted) - use Git here so that can't accidentally delete older versions (this phase creates a git commit)

function! EnterJournalMode()
		autocmd TextChanged,TextChangedI * :silent update
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
		set shortmess=F
		redraw
		echo ""
endfunction

nnoremap <S-j> :call EnterJournalMode()<CR>
