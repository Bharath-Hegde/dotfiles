" to recoginise dbout as filetype (to extend vim-dadbod functionality)
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.dbout	setfiletype dbout
augroup END

