" Map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

let g:mapleader=" "

" Select all
nnoremap <leader>a ggVG

" Clear highlights after search
nnoremap <leader>l :noh<CR>

" Source init file
nnoremap <leader>so :so ~/.config/nvim/init.vim<CR>

" Jump outside closing bracket
" imap <c-e> <c-o>A
" nnoremap <leader>s :w<CR> 
" nnoremap <Leader>o o<Esc>0"_D
" nnoremap <Leader>O O<Esc>0"_D
" Insert new line above and below in insert mode with changing cursor position
inoremap <C-v> <Esc>m`O<Esc>``a
inoremap <C-c> <Esc>m`o<Esc>``a

" Navigate between buffers
map gn :bn<cr>
map gp :bp<cr>

" Paste without new line
" nnoremap gp a<CR><Esc>PkJxJ
" nnoremap gp a<CR><Esc>PkJxJ

" Open file explorer on left side
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

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

" Compile and view latex pdfs 
" nnoremap cn <esc>:!pdflatex % <CR><CR>
" nnoremap cm <esc>:!mupdf-x11 $(echo $ \| sed 's/tex$/pdf/') & disown<CR>

" Digraphs
digraph fa 8704
digraph te 8707
digraph ph 8709
digraph ss 8834
digraph se 8838
digraph bt 8712


