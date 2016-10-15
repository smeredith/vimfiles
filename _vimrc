" Use Vim settings, rather than Vi settings.  This must be first, because it
" changes other options as a side effect.
set nocompatible

" ==================================================
" Plugin settings.
" ==================================================

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

" clang_complete (disable for Windows)
if has('win32') || has('win64')
    let g:clang_complete_loaded=1
elseif has('mac')
    " disable on mac for now
    let g:clang_complete_loaded=1

    let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
    let g:clang_user_options='-std=c++14 -stdlib=libstd++ -isystem /usr/include/clang/3.6/include'
else
    let g:clang_library_path='/usr/lib/llvm-3.6/lib'
    let g:clang_user_options='.clang_complete'
endif
let g:clang_complete_copen=0
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_auto_user_options = "compile_commands.json"

" vim-clang-format (doesn't work on Windows)
if !has('win32') && !has('win64')
let g:clang_format#style_options = {
    \ "AccessModifierOffset" : -4,
    \ "AlignAfterOpenBracket" : "true",
    \ "AlignEscapedNewlinesLeft" : "false",
    \ "AlignOperands" : "true",
    \ "AlignTrailingComments" : "true",
    \ "AllowAllParametersOfDeclarationOnNextLine" : "true",
    \ "AllowShortBlocksOnASingleLine" : "false",
    \ "AllowShortCaseLabelsOnASingleLine" : "false",
    \ "AllowShortIfStatementsOnASingleLine" : "false",
    \ "AllowShortLoopsOnASingleLine" : "false",
    \ "AllowShortFunctionsOnASingleLine" : "Empty",
    \ "AlwaysBreakAfterDefinitionReturnType" : "false",
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "AlwaysBreakBeforeMultilineStrings" : "false",
    \ "BreakBeforeBinaryOperators" : "None",
    \ "BreakBeforeTernaryOperators" : "true",
    \ "BreakConstructorInitializersBeforeComma" : "false",
    \ "BinPackParameters" : "false",
    \ "BinPackArguments" : "false",
    \ "ColumnLimit" : 100,
    \ "ConstructorInitializerAllOnOneLineOrOnePerLine" : "true",
    \ "ConstructorInitializerIndentWidth" : 4,
    \ "DerivePointerAlignment" : "false",
    \ "ExperimentalAutoDetectBinPacking" : "false",
    \ "IndentCaseLabels" : "false",
    \ "IndentWrappedFunctionNames" : "false",
    \ "IndentFunctionDeclarationAfterType" : "false",
    \ "MaxEmptyLinesToKeep" : 1,
    \ "KeepEmptyLinesAtTheStartOfBlocks" : "true",
    \ "NamespaceIndentation" : "None",
    \ "ObjCBlockIndentWidth" : 2,
    \ "ObjCSpaceAfterProperty" : "false",
    \ "ObjCSpaceBeforeProtocolList" : "true",
    \ "PenaltyBreakBeforeFirstCallParameter" : 19,
    \ "PenaltyBreakComment" : 300,
    \ "PenaltyBreakString" : 1000,
    \ "PenaltyBreakFirstLessLess" : 120,
    \ "PenaltyExcessCharacter" : 1000000,
    \ "PenaltyReturnTypeOnItsOwnLine" : 60,
    \ "PointerAlignment" : "Left",
    \ "SpacesBeforeTrailingComments" : 1,
    \ "Cpp11BracedListStyle" : "true",
    \ "Standard" : "Cpp11",
    \ "IndentWidth" : 4,
    \ "TabWidth" : 8,
    \ "UseTab" : "Never",
    \ "BreakBeforeBraces" : "Stroustrup",
    \ "SpacesInParentheses" : "false",
    \ "SpacesInSquareBrackets" : "false",
    \ "SpacesInAngles" : "false",
    \ "SpaceInEmptyParentheses" : "false",
    \ "SpacesInCStyleCastParentheses" : "false",
    \ "SpaceAfterCStyleCast" : "false",
    \ "SpacesInContainerLiterals" : "true",
    \ "SpaceBeforeAssignmentOperators" : "true",
    \ "ContinuationIndentWidth" : 4,
    \ "SpaceBeforeParens" : "ControlStatements",
    \ "DisableFormat" : "false"
    \ }
endif

" ==================================================

" No bells!
set belloff=all

" Don't let the mouse move the cursor position. This helps with accidental
" trackpad contact on laptop.
set mouse=

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
    :%s/\s\+$//
    :%s/’/'/g
endfunction

" Change the leader to be a comma instead of a slash.
let mapleader=","

" Map the various registers to a leader shortcut for pasting from them.
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

" Switch to alternate buffer.
nmap <leader>ba <C-^>

" Show Buffer Explorer list in current window.
nmap <leader>bl :BufExplorer<CR>

" Clean whitespace from end of current line.
nmap <leader>cl :.s/\s\+$//<CR>

" Clean whitespace from end of all lines in the buffer
" and replace fancy single quotes.
nmap <leader>ca :call CleanBuffer()<CR>

" Turn off any highlighed search text.
nmap <leader>nh :nohls<CR>

" Paste from last yank but not delete.
nmap <leader>p "0p
nmap <leader>P "0P

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

" Load dev notes.
nmap <leader>nd :e $HOME/notes/dev/index.adoc<CR>

" Load work notes.
nmap <leader>nw :e $HOME/notes/work/work.md<CR>

" Load personal notes.
nmap <leader>nj :e $HOME/notes/personal/journal.md<CR>

" Underline the current line to represent a section header in asciidoc.
nmap <leader>u1 yyp<c-v>$r=
nmap <leader>u2 yyp<c-v>$r-
nmap <leader>u3 yyp<c-v>$r~
nmap <leader>u4 yyp<c-v>$r^
nmap <leader>u5 yyp<c-v>$r+

" Prefix the current line with some number of #'s to represent a section header in markdown.
nmap <leader>h1 I# <c-[>$
nmap <leader>h2 I## <c-[>$
nmap <leader>h3 I### <c-[>$
nmap <leader>h4 I#### <c-[>$
nmap <leader>h5 I##### <c-[>$

" Insert the current date as a top-level asciidoc header.
nmap <leader>id "='# ' . strftime("%Y-%m-%d %A")<CR>Po<CR>

" Yank the full path w/o the filename to the system clipboard.
nmap <leader>yp :let @* = expand("%:p:h")<CR>

" Yank the full path and filename to the Windows clipboard.
nmap <leader>yf :let @* = expand("%:p")<CR>

" Move through quickfix list.
nmap ]q :cnext<CR>
nmap [q :cprev<CR>

" ==================================================
" Windows / Splits
" ==================================================

" ctrl-jklm moves between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Make these all work in insert mode too (<C-O> makes next cmd
" happen as if in command mode.)
imap <C-W> <C-O><C-W>

" Use alt-down and alt-up to resize horizontal splits.
map <M-Down> <C-W>-
map <M-Up> <C-W>+

" Use alt-left and alt-right to resize vertical splits.
map <M-Left> <C-W><
map <M-Right> <C-W>>

" Make quickfix full width.
botright copen
botright cwindow

" ==================================================
" Settings
" ==================================================

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
    colorscheme delek
endif

" Syntax highlighting.
syntax on

" Highlight all search results.
set hlsearch

" Don't treat numbers that start with 0 as octal. Who uses octal?
set nrformats-=octal

" Number of command lines to remember.
set history=1000

" Backspace and cursor keys wrap to previous/next line.
set backspace=indent,eol,start whichwrap+=<,>,[,]

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

" Create directory for backup files and swap files.
" silent execute '!mkdir "'.$HOME.'/vimbackup"'

set backupdir=$HOME/vimbackup//
set directory=$HOME/vimswap//
set undodir=$HOME/vimundo//

" Make a backup before saving.
set writebackup

" Keep the backup even after writing is finished.
set backup

" Save incremental backups.
autocmd BufWritePre * let &backupext = '.' . substitute(expand("%:p:h"), ':\|/\|\\' , '%' , 'g') . '.' . strftime("%Y.%m.%d.%H.%M.%S")

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
autocmd FileType xml,markdown set softtabstop=4
autocmd FileType xml,markdown set shiftwidth=4

" Set filetype.
autocmd BufReadPost,BufNewFile *.md set filetype=markdown
autocmd BufReadPost,BufNewFile *.adoc set filetype=asciidoc

" Set options for prose.
autocmd FileType text :call SetProseOptions()
autocmd FileType markdown :call SetProseOptions()
autocmd FileType asciidoc :call SetProseOptions()

" Set encoding for asciidoc.
autocmd FileType asciidoc set encoding=utf-8
autocmd FileType asciidoc set fileencoding=utf-8

" Fancy % matching, including xml tags.
:source $VIMRUNTIME/macros/matchit.vim

" Help behavior.
autocmd filetype help set nonumber
autocmd filetype help nnoremap <buffer><cr> <c-]>   " Enter selects subject
autocmd filetype help nnoremap <buffer><bs> <c-T>   " Backspace to go back
autocmd filetype help set colorcolumn=

" Color column.
set colorcolumn=100

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
