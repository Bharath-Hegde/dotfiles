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

" A Vim Plugin for Lively Previewing LaTeX PDF Output
" Plug 'xuhdev/vim-latex-live-preview'

call plug#end()

" plug configurations

" custom delay for jk map 
let g:arpeggio_timeoutlen=200

" show coc status in statusline
set statusline^=%{coc#status()}

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_BaseDir = '~/.cache'
" configs written in lua
luafile $HOME/.config/nvim/luaconfig.lua
