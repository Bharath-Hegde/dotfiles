func! CreateSymlink()
	let path = "~/dosbox/MASM611/BIN/"
	if &filetype ==? "masm"
		execute("!ln -s "."%:p ". path)
	endif
endfunc
set commentstring=;%s
" set commentstring=;%s
