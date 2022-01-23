call plug#begin('~/.config/nvim/plugged')

 " color scheme
Plug 'morhetz/gruvbox'

" Map simultaneous jk to <esc>
Plug 'kana/vim-arpeggio'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" variety of code snippets
Plug 'honza/vim-snippets'

" easy commenting
Plug 'tpope/vim-commentary'

" Surround 
Plug 'tpope/vim-surround'

" status line
Plug 'itchyny/lightline.vim'

" Auto-pairing
Plug 'windwp/nvim-autopairs'

" Navigate between vim splits and tmux splits
Plug 'christoomey/vim-tmux-navigator'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Dependencies for telescope
" Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Devicons
Plug 'kyazdani42/nvim-web-devicons'

" Manipulate your filesystem just like you manipulate text
" Plug 'elihunter173/dirbuf.nvim'

" Intereact with databases like MySQL
Plug 'tpope/vim-dadbod'
call plug#end()

" plug configurations

" custom delay for jk map 
let g:arpeggio_timeoutlen=200

" show coc status in statusline
set statusline^=%{coc#status()}
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Show sql query in dbout result buffer of vim-dadbod, followed by modified
" To display only modified for all other filetypes
function! SqlGetQuery()
	let modified = &modified ? '+' : ''
	if &filetype ==? "dbout"
		if &modified
			return (match(expand('%'),'.*\.dbout$') > -1 ? join(readfile(expand('%:r').'.sql')) : '').(' | ').(modified)
		else
			return (match(expand('%'),'.*\.dbout$') > -1 ? join(readfile(expand('%:r').'.sql')) : '')
		endif
	else
		return modified
	endif
endfunction

" Statusline configs
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction',  'readonly', 'filename','sqlcurrentquery'] ]
      \ },
	  \ 'component': {
		  \ 'sqlcurrentquery':'%{SqlGetQuery()}'
	  \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \ },
      \ }

autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_BaseDir = '~/.cache'

" configs written in lua
luafile $HOME/.config/nvim/luaconfig.lua
