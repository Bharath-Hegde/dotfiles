" command! Vimconfig :e ~/.config/nvim/init.vim
command! Config :lua find_configs()

" setup input/output buffers on the right side for python,cpp,c
func! IOBufferSetup()
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
	exe s:workingWindow . "wincmd w"
	execute(":on")
endfunc

func! JumpToCurrent()
	exe s:workingWindow . "wincmd w"
endfunc

" Compile&Run/Run for python,cpp,c
func! CompileAndRun()
	if s:workingFileType ==? "python"
		execute("!cat input.file | python3 ". s:workingFileName ." > output.file")
	elseif s:workingFileType ==? "cpp"
		" g++ test.cpp -o test.cpp.out &&  ./test.cpp.out < input.file > output.file
		execute("! g++ -std=c++17 ". s:workingFileName ." -o ". s:workingFileName .".out 2>output.file &&  ./". s:workingFileName .".out< input.file >> output.file")

	elseif s:workingFileType ==? "c"
		execute("! gcc ". s:workingFileName ." -o ". s:workingFileName .".out &&  ./". s:workingFileName .".out< input.file > output.file")

	endif
endfunc

