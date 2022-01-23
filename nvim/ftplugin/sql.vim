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

" Function and comand to select database
func! DBSelected(db_name)
	let b:db = g:db.a:db_name
endfunc
command -nargs=1 DBSelect call DBSelected(<f-args>)
