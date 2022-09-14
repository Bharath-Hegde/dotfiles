" command! Vimconfig :e ~/.config/nvim/init.vim
command! Config :lua find_configs()

let s:opened = 0
" setup input/output buffers on the right side for python,cpp,c
func! IOBufferSetup()
	let s:opened = 1

	let s:workingWindow=winnr()
	let s:workingFileName=@%
	let s:workingFileType=&filetype

	vsplit input.file
	execute(":w")

	" Save the input window
	let s:inputWindow=winnr()

	vertical resize 60
	split output.file

	" Go back to the input window
	exe s:inputWindow . "wincmd w"
endfunc

func! CloseIOBuffers()
	let s:opened = 0
	exe s:workingWindow . "wincmd w"
	execute(":on")
endfunc

" Compile&Run/Run for python,cpp,c
func! CompileAndRun()
	if s:opened == 0
		let s:workingFileName=@%
		let s:workingFileType=&filetype

		if !(s:workingFileType ==? "masm")
			execute('!echo "" > input.file')
		endif
	endif

	if s:workingFileType ==? "python"
		execute("!cat input.file | python3 ". s:workingFileName ." > output.file")
	elseif s:workingFileType ==? "cpp"
		" g++ test.cpp -o test.cpp.out &&  ./test.cpp.out < input.file > output.file
		execute("! g++ -std=c++17 ". s:workingFileName ." -o ". s:workingFileName .".out 2>output.file &&  ./". s:workingFileName .".out< input.file >> output.file")
	elseif s:workingFileType ==? "c"
		execute("! gcc ". s:workingFileName ." -o ". s:workingFileName .".out &&  ./". s:workingFileName .".out< input.file > output.file")
	elseif s:workingFileType ==? "masm"
		let choice = confirm("Choose mode: ", "&1normal\n &2debugx")
		if choice == 0
			echo "aborted"
		elseif choice == 1
			execute("!masm ". s:workingFileName)
		elseif choice == 2
			execute("!masm ". s:workingFileName . " debugx")
		endif
	elseif s:workingFileType ==? "tex"
		" execute("! xelatex main.tex && open main.pdf")
		"

		execute("! xelatex main.tex && open main.pdf && osascript -e 'tell application \"System Events\" to key code 48 using command down'")
	endif
	if s:opened == 0 && !(s:workingFileType ==? "masm") && !(s:workingFileType ==? "tex")
		execute("call IOBufferSetup()")
		let s:opened = 1
	endif
endfunc

func! CreateSymlink()
	let path = "~/dosbox/MASM611/BIN/"
	if &filetype ==? "masm"
		execute("!ln -s "."%:p ". path)
	endif
endfunc

let s:enabled = 1
function! LoadJournalSettings()
    if s:enabled
		:Goyo
		set wrap
		set linebreak
		noremap j gj
		noremap k gk
		noremap $ g$
		noremap 0 g0
        let s:enabled = 0
    else
		:wq
		:q
        let s:enabled = 1
    endif
endfunction
