call plug#begin('~/.config/nvim/plugged')

 " color scheme
Plug 'morhetz/gruvbox'

" Map simultaneous jk to <esc>
Plug 'kana/vim-arpeggio'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippet support
Plug 'SirVer/ultisnips'

" variety of code snippets
" Plug 'honza/vim-snippets'

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
" Extensions for telescope
Plug 'nvim-telescope/telescope-fzy-native.nvim'

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

" >> STATUSLINE
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
		let query = trim(match(expand('%'),'.*\.dbout$') > -1 ? join(readfile(expand('%:r').'.sql')) : '')
		if &modified
			return query.(' | ').(modified)
		else
			return query
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
" <<

autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_BaseDir = '~/.cache'

" Ultisnips configg
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-l>"
let g:UltiSnipsJumpBackwardTrigger = "<C-h>"
let g:UltiSnipsEditSplit = "vertical"

" configs written in lua
lua << EOF

-- autopairing plugin load
require('nvim-autopairs').setup{}
local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
	    ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
	fzy_native = {
		override_generic_sorter = false,
		override_file_sorter = true,
	}
  }
}
function find_configs()
  require("telescope.builtin").find_files {
    prompt_title = " Find Configs",
    results_title = "Config Files",
	shorten_path = true,
    search_dirs = {
      "~/programming/dotfiles/",
    },
    cwd = "~/programming/dotfiles/",
  }
end

require('telescope').load_extension('fzy_native')
EOF
