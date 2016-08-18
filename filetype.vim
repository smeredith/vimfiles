if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.w setfiletype cpp
    au! BufRead,BufNewFile *.uix,*.provxml,*.mc setfiletype xml
augroup END

