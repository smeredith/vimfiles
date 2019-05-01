" Use Vim settings, rather than Vi settings.  This must be first, because it
" changes other options as a side effect.
set nocompatible

" Change the line find undo to be a backslash instead of a comma.
nnoremap \ ,

" Change the leader to be a comma instead of a backslash.
let mapleader=","
let maplocalleader=","

" ==================================================
" Plugin settings.
" ==================================================

" netrw

let g:netrw_banner=0

" Ctrl-p
let g:ctrlp_root_markers = ['.p4ignore']
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|build$\|symbols$',
    \ 'file': '\.exe$\|\.so$\|\.dll$',
    \ }
" Use F5 in ctrlp window to clear cache.
let g:ctrlp_clear_cache_on_exit = 0

" Using Pathogen to manage plugins.  Use .git as a root marker.
call pathogen#infect()
call pathogen#helptags()

" Buffer Explorer.
let g:bufExplorerShowRelativePath=1
let g:bufExplorerDisableDefaultKeyMapping=1

" Don't let Solarized remap F5 by not loading the plugin. (But can't toggle background.)
let g:loaded_togglebg = 1

" Make vim-markdown-folding show only top level headers by default.
let g:markdown_fold_style = 'nested'

" Clang-Format
let g:clang_format#detect_style_file=1
map <leader>cf :ClangFormat<CR>

" You Complete Me
" Requires compile_commands.json in enlistment root.
nmap <leader>gf :YcmCompleter GoToInclude<CR>
nmap <leader>gd :YcmCompleter GoToDeclaration<CR>
nmap <leader>gt :YcmCompleter GetType<CR>
nmap <leader>fi :YcmCompleter FixIt<CR>

" No bells!
set belloff=all

" Don't let the mouse move the cursor position. This helps with accidental
" trackpad contact on laptop.
set mouse=

" set internal encoding
set encoding=utf-8

" Ex mode is useless. Don't enter it by accident.
nnoremap Q <nop>

" Unmap F1 from help because F1 is really close to the esc key on my laptop.
nmap <F1> <nop>
imap <F1> <nop>

" Select block that was just pasted.
nmap gV `[v`]

" Clean whitespace from end of all lines and
" replace special characters with standard ones.
function! CleanBuffer()
    let l:save = winsaveview()
    :%s/\s\+$//ge
    :%s/’/'/ge
    :%s/\(“\|”\)/"/ge
    call winrestview(l:save)
endfunction

" Switch to alternate buffer.
nmap <leader>ba <C-^>

" Show Buffer Explorer list in current window.
nmap <leader>bl :BufExplorer<CR>

" Clean whitespace from end of current line.
nmap <leader>cl :.s/\s\+$//e<CR>

" Clean whitespace from end of all lines in the buffer
" and replace fancy single quotes.
nmap <leader>ca :call CleanBuffer()<CR>

" Turn off any highlighed search text.
nmap <leader>nh :nohls<CR>

" Show the registers from things cut/yanked.
nmap <leader>rr :registers<CR>

" Toggle spelling.
nmap <leader>ts :setlocal spell! spelllang=en_us<CR>

" Toggle word wrap.
nmap <leader>tw :set invwrap<CR>:set wrap?<CR>

" Toggle line numbers.
nmap <leader>tn :setlocal number!<CR>

" Toggle relative line numbers.
nmap <leader>tr :setlocal relativenumber!<CR>

" Edit _vimrc/.vimrc.
nmap <leader>ev :e $MYVIMRC<CR>

" Source _vimrc/.vimrc.
nmap <leader>sv :so $MYVIMRC<CR>

" Yank the full path w/o the filename to the system clipboard.
nmap <leader>yp :let @* = expand("%:p:h")<CR>

" Yank the full path and filename to the Windows clipboard.
nmap <leader>yf :let @* = expand("%:p")<CR>

" <leader> s for snippets

" Insert the current date as a top-level asciidoc/markdown header, like:
" # 2017-03-01 Wednesday
" then enter insert mode.
nmap <leader>sdate "='# ' . strftime("%Y-%m-%d %A")<CR>Po<CR>

" Move through quickfix list.
nmap ]q :cnext<CR>
nmap [q :cprev<CR>

" ==================================================
" Windows / Splits
" ==================================================

" Make quickfix full width.
botright copen
botright cwindow

if has("gui_running")
    set background=light
    colorscheme solarized

    if &diff
        colorscheme blue
    endif

    " No toolbar.
    set guioptions-=T

    " No menu.
    set guioptions -=m

    " No scollbar.
    set guioptions -=r

    " Use console for confirmations instead of GUI dialogs.
    set guioptions +=c

    " Default window size.
    set columns=110
    " winpos -1050 -200
else
    colorscheme murphy
endif

" Syntax highlighting.
syntax on

" Highlight all search results.
set hlsearch

" Don't treat numbers that start with 0 as octal. Who uses octal?
set nrformats-=octal

" Number of command lines to remember.
set history=1000

" Backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start

" Backspace, space and cursor keys wrap to previous/next line.
set whichwrap=b,s,<,>,[,]

" Do not unindent if typing #.
set cinkeys-=0#

" Font.
if has("gui_running")
    if has("gui_win32")
        set guifont=Consolas:h11:cANSI
    elseif has("gui_macvim")
        set guifont=Monaco:h12
    else
        set guifont=Monospace\ 10
    endif
endif

" When splitting windows, add new window below.
set splitbelow

" Don't wrap lines.
set nowrap

set backupdir=$HOME/vimbackup//
set directory=$HOME/vimswap//
set undodir=$HOME/vimundo//

" Make a backup before saving.
set writebackup

" Whitespace characters to show (trailing spaces and tabs).
set listchars=trail:·,tab:»-

" Allow cursor to go where there is no text when in visual block mode.
set virtualedit=block

" Persistent undo between sessions.
set undofile

" Don't jump to first character of line when paging.
set nostartofline

" Custom status line.
set statusline=%f%m%r%h%w[%{&ff}][%Y]%=[%03c,%04l/%04L(%p%%)]

" Show the status line even when there is only one window.
set laststatus=2

" Enhanced tab completion on command line.
set wildmenu

" When word wrap is enabled, don't break in the middle of lines.
" This doesn't work if `list` is set. (List is for showing whitespace.)
set linebreak

" Enable file type detection (sets cindent, etc) and load indent files, to do
" language-dependent indenting.
filetype plugin indent on

" Set options for writing prose.
function! SetProseOptions()
    set formatoptions=q
    set nojoinspaces
endfunction

" Set tabstop to 2 for xml files.
autocmd FileType xml,markdown setlocal softtabstop=4
autocmd FileType xml,markdown setlocal shiftwidth=4

" Set filetype.
autocmd BufReadPost,BufNewFile *.md setlocal filetype=markdown
autocmd BufReadPost,BufNewFile *.adoc setlocal filetype=asciidoc

" Set options for prose.
autocmd FileType text :call SetProseOptions()
autocmd FileType markdown :call SetProseOptions()
autocmd FileType asciidoc :call SetProseOptions()
autocmd FileType rst :call SetProseOptions()

" Set encoding for asciidoc.
autocmd FileType asciidoc setlocal encoding=utf-8
autocmd FileType asciidoc setlocal fileencoding=utf-8

" Set 2 char spacing for yaml files.
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Fancy % matching, including xml tags.
:source $VIMRUNTIME/macros/matchit.vim

" Help behavior.
autocmd filetype help setlocal nonumber
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back
autocmd filetype help setlocal colorcolumn=

" Y yanks from cursor to the end of the line.
nmap Y y$

" Round < and > indent to multiple of shiftwidth.
set shiftround

" Incremental searching.
set incsearch

" Spaces used for block indenting (>>, <<, cindent).
set shiftwidth=4

" Expand Tabs this much.
set tabstop=4

" Insert spaces instead of tabs.
set expandtab

" Insert this many spaces when Tab pressed.
set softtabstop=4

" Case-insensitive searches.
set ignorecase

" If case is used in the search term, make the search case sensitive.
set smartcase

" Show line numbers.
set number

" Always show lines above/below the cursor when at the top/bottom of the file.
set scrolloff=2

" Show whitespace.
set list

" For wrapping while typing and auto-formatting paragraphs.
set textwidth=80

" Auto change the directory to the current file I'm working on.
set autochdir

" Read .vimrc from current directory if it exists. This allows me to configure
" project-specific tab stops.
set exrc

" Allow unsaved buffers that do not have a current window.
set hidden

" Don't auto wrap lines at textwidth.
set formatoptions-=t
