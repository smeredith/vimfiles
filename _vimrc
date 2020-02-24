" Use Vim settings, rather than Vi settings.  This must be first, because it
" changes other options as a side effect.
set nocompatible

" Allow a local .vimrc in current dir
set exrc

" Change the line find undo to be a backslash instead of a comma.
nnoremap \ ,

" Change the leader to be a comma instead of a backslash.
let mapleader=","
let maplocalleader=","

if !isdirectory($HOME."/vimfiles/backup")
    call mkdir($HOME."/vimfiles/backup", "p")
endif
if !isdirectory($HOME."/vimfiles/swap")
    call mkdir($HOME."/vimfiles/swap", "p")
endif
if !isdirectory($HOME."/vimfiles/undo")
    call mkdir($HOME."/vimfiles/undo", "p")
endif

set backupdir=$HOME/vimfiles/backup//
set directory=$HOME/vimfiles/swap//
set undodir=$HOME/vimfiles/undo//


" ==================================================
" Plugin settings.
" ==================================================

" vim-plug
if empty(glob('$HOME/vimfiles/autoload/plug.vim'))
      silent !curl -fLo $HOME/vimfiles/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/vimfiles/plugged')
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'rhysd/vim-clang-format'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-surround'
Plug '~/vimfiles/plugged/YouCompleteMe'
call plug#end()

" netrw
let g:netrw_banner=0

" Buffer Explorer.
let g:bufExplorerShowRelativePath=1
let g:bufExplorerDisableDefaultKeyMapping=1

" Don't let Solarized remap F5 by not loading the plugin. (But can't toggle background.)
let g:loaded_togglebg = 1

" Clang-Format
let g:clang_format#detect_style_file=1
map <leader>cf :ClangFormat<CR>

" You Complete Me
" Requires compile_commands.json in enlistment root.
nmap <leader>gf :YcmCompleter GoToInclude<CR>
nmap <leader>gd :YcmCompleter GoToDeclaration<CR>
nmap <leader>gt :YcmCompleter GetType<CR>
nmap <leader>gg :YcmCompleter GoTo<CR>
nmap <leader>gp :YcmCompleter GetParent<CR>
nmap <leader>gr :YcmCompleter GoToReferences<CR>
nmap <leader>fi :YcmCompleter FixIt<CR>
nmap <leader>rr :YcmCompleter RefactorRename 
nmap <leader>ry :YcmRestartServer<CR>

" fzf
map <C-p> :Files<CR>

" ==================================================

" Chrome OS SSH hterm: Copy to system clipboard via OSC52
vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>

" Clean whitespace from end of all lines and
" replace special characters with standard ones.
function! CleanBuffer()
    let l:save = winsaveview()
    :%s/\s\+$//ge
    :%s/’/'/ge
    :%s/\(“\|”\)/"/ge
    call winrestview(l:save)
endfunction

" Set options for writing prose.
function! SetProseOptions()
    set nojoinspaces
    set spelllang=en_us
endfunction

" ==================================================

" Security mitigation for older versions
set nomodeline

" Expand hard tabs this much.
set tabstop=4

" Insert spaces instead of tabs.
set expandtab

" Insert this many spaces for tabs.
set softtabstop=4

" Number of spaces for block indenting (>>, <<, cindent).
set shiftwidth=4

" Round << and >> indent to multiple of shiftwidth.
set shiftround

" Always show lines above/below the cursor when at the top/bottom of the file.
set scrolloff=2

" Don't insert newlines to wrap text.
set textwidth=0

" q: formats comments; l: long lines not broken in insert mode
set formatoptions=ql

" Don't wrap lines.
set nowrap

" When word wrap is enabled, don't break in the middle of lines.
" This doesn't work if `list` is set. (List is for showing whitespace.)
set linebreak

" Show whitespace.
set list

" Whitespace characters to show (trailing spaces and tabs).
set listchars=trail:·,tab:»-

" Show line numbers.
set number

" No bells!
" set belloff=all

" Don't let the mouse move the cursor position. This helps with accidental
" trackpad contact on laptop.
set mouse=

" set internal encoding
set encoding=utf-8

" Incremental searching.
set incsearch

" Highlight all search results.
set hlsearch

" Case-insensitive searches.
set ignorecase

" If case is used in the search term, make the search case sensitive.
set smartcase

" Don't jump to first character of line when paging.
set nostartofline

" Do not unindent if typing #.
set cinkeys-=0#

" Backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start

" Backspace, space and cursor keys wrap to previous/next line.
set whichwrap=b,s,<,>,[,]

" Allow cursor to go where there is no text when in visual block mode.
set virtualedit=block

" Don't treat numbers that start with 0 as octal. Who uses octal?
set nrformats-=octal

" Custom status line.
set statusline=%f%m%r%h%w[%{&ff}][%Y]%=[%03c,%04l/%04L(%p%%)]

" Show the status line even when there is only one window.
set laststatus=2

" Enhanced tab completion on command line.
set wildmenu

" When splitting windows, add new window below.
set splitbelow

" Allow unsaved buffers that do not have a current window.
set hidden

" Auto change the directory to the current file I'm working on.
" Great for the general case: less good when using YCM.
set autochdir

" Number of command lines to remember.
set history=1000

" Make a backup before saving.
set writebackup

" Persistent undo between sessions.
set undofile

" Color
colorscheme industry

" Syntax highlighting.
syntax on

" Make quickfix full width.
botright copen
botright cwindow

" Enable file type detection (sets cindent, etc) and load indent files, to do
" language-dependent indenting.
filetype plugin indent on

if has("gui_running")
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
endif

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

" <leader> s for snippets
" Insert the current date as a top-level asciidoc/markdown header, like:
" # 2017-03-01 Wednesday
" then enter insert mode.
nmap <leader>sdate "='# ' . strftime("%Y-%m-%d %A")<CR>Po<CR>

" Ex mode is useless. Don't enter it by accident.
nnoremap Q <nop>

" Unmap F1 from help because F1 is really close to the esc key on my laptop.
nmap <F1> <nop>
imap <F1> <nop>

" Y yanks from cursor to the end of the line.
nmap Y y$

" Select block that was just pasted.
nmap gV `[v`]

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

nmap <leader>ff :find modules/**/

" Move through quickfix list.
nmap ]q :cnext<CR>
nmap [q :cprev<CR>

" Set tabstop to 2 for xml files.
autocmd FileType xml,markdown setlocal softtabstop=4
autocmd FileType xml,markdown setlocal shiftwidth=4

" Set 2 char spacing for yaml files.
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Set filetype.
autocmd BufReadPost,BufNewFile *.md setlocal filetype=markdown
autocmd BufReadPost,BufNewFile *.adoc setlocal filetype=asciidoc

" Disable markdown syntax highlighting
autocmd FileType markdown setlocal syntax=off

" Set options for prose.
autocmd FileType text :call SetProseOptions()
autocmd FileType markdown :call SetProseOptions()
autocmd FileType asciidoc :call SetProseOptions()
autocmd FileType rst :call SetProseOptions()

" Set encoding for asciidoc.
autocmd FileType asciidoc setlocal fileencoding=utf-8

" Help behavior.
autocmd filetype help setlocal nonumber
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back
autocmd filetype help setlocal colorcolumn=

" Fancy % matching, including xml tags.
:source $VIMRUNTIME/macros/matchit.vim

