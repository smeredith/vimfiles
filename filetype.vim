if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.md setfiletype markdown
    au! BufRead,BufNewFile *.adoc setfiletype asciidoc
augroup END

