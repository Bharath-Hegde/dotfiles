" Map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

let g:mapleader=" "

" Select all
nnoremap <leader>a ggVG

" Clear highlights after search
nnoremap <leader>l :noh<CR>

" Source init file
nnoremap <leader>so :so ~/.config/nvim/init.vim<CR>

" Insert new line above and below in insert mode with changing cursor position
inoremap <C-v> <Esc>m`O<Esc>``a
inoremap <C-c> <Esc>m`o<Esc>``a

" Navigate between buffers
map gn :bn<cr>
map gp :bp<cr>

" Extend ci" ca" functionality to {,(,[
nnoremap ci{ f}vi{di
nnoremap ca{ f}va{di
nnoremap ci} f}vi{di
nnoremap ca} f}va{di
nnoremap ci) f)vi(di
nnoremap ca) f)va(di
nnoremap ci) f)vi(di
nnoremap ca) f)va(di
nnoremap ci[ f]vi[di
nnoremap ca[ f]va[di
nnoremap ci] f]vi[di
nnoremap ca[ f]va[di

" Navigate between splits - vim/tmux
" let g:tmux_navigator_no_mappings = 1
nnoremap <silent> {C-h} :TmuxNavigateLeft<cr> 
nnoremap <silent> {C-j} :TmuxNavigateDown<cr>
nnoremap <silent> {C-k} :TmuxNavigateUp<cr>
nnoremap <silent> {C-l} :TmuxNavigateRight<cr>
nnoremap <silent> {C-\} :TmuxNavigatePrevious<cr>

" Digraphs
digraph fa 8704
digraph te 8707
digraph ph 8709
digraph ss 8834
digraph se 8838
digraph bt 8712
