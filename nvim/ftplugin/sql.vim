" execute current para query - works for lines and paras too
nmap <leader>e <leader>dbip}

" mappings - refer end of https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

let g:db = "mysql://user:your_pswd@localhost/"
source $HOME/.config/nvim/pswds.vim

" Following funcs for DBSelect command
" Execute show databses
" Get output as list of databases
" Get tabcompletion for these lists

func! DBSelected(...)
	" Clear databse selction in case no arguments provided
	if a:0 == 0
		let b:db = g:db
	" Set db url otherwise
	else
		let b:db = g:db.a:1
	endif
	execute ":DB show tables"
endfunc

function! GetActiveBuffers()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:item in l:blist
        "skip unnamed buffers; also skip hidden buffers?
        if empty(l:item.name) || l:item.hidden
            continue
        endif
        call add(l:result, shellescape(l:item.name))
    endfor
    return l:result
endfunction

func! GetDatabases()
	execute ":DB show databases"
	let buf = GetActiveBuffers()[-1]
	execute('let lines = readfile('.buf.')')
	let lines = lines[4:len(lines)-2]
	let dbli = []
	for line in lines
		call add(dbli,split(line,' ')[1])
	endfor
	return dbli
endfunc!

function! MakeCompletion(A,L,P) abort
    let l:targets = GetDatabases()
	return filter(l:targets, 'v:val =~ "^' . a:A . '"')
endfunction

command! -nargs=* -complete=customlist,MakeCompletion DBSelect call DBSelected(<f-args>)


