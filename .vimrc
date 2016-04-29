set nocompatible
syntax on
filetype plugin indent on
set nowrap
set backspace=indent,eol,start
set autoindent
set smartindent
set copyindent
set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set number
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set showmode
set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set nobackup
set noswapfile
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
"set timeoutlen=0
"set ttimeoutlen=0
set laststatus=2

let mapleader = ","
let maplocalleader = ";"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/ListToggle'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'pangloss/vim-javascript'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'docker/docker', {'rtp': '/contrib/syntax/vim/'}

call vundle#end()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" Gracefully handle holding shift too long after : for common commands

cabbrev W w
cabbrev Q q
cabbrev Wq wq
cabbrev Tabe tabe
cabbrev Tabc tabc

"set pastetoggle keybinding
set pastetoggle=<F2>

" Make Y consistent with D and C
map Y           y$

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/

" Split screen
map <leader>v   :vsp<CR>

" Move between screens
map <leader>w   ^Ww
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk

" Open .vimrc file in new tab. Think Command + , [Preferences...] but with Shift.
map <D-<>       :tabedit ~/.vimrc<CR>

" Reload .vimrc
map <leader>rv  :source ~/.vimrc<CR>

" Undo/redo - Doesn't MacVim already have this?
map <D-z>       :earlier 1<CR>
map <D-Z>       :later 1<CR>

" Auto-indent whole file
nmap <leader>=  gg=G``
map <silent> <F7> gg=G`` :delmarks z<CR>:echo "Reformatted."<CR>

" Jump to a new line in insert mode
imap <D-CR>     <Esc>o

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" File tree browser
map \           :NERDTreeToggle<CR>

" File tree browser showing current file - pipe (shift-backslash)
map \|          :NERDTreeFind<CR>

" Previous/next quickfix file listings (e.g. search results)
map <M-D-Down>  :cn<CR>
map <M-D-Up>    :cp<CR>

" Previous/next buffers
map <M-D-Left>  :bp<CR>
map <M-D-Right> :bn<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

" FuzzyFinder
map <D-e>       :FufBuffer<CR>
map <leader>rb  :FufBuffer<CR>

" Command-T
map <D-N>       :CommandTFlush<CR>:CommandT<CR>
map <leader>F   :CommandTFlush<CR>:CommandT<CR>
nmap <C-p>      :CommandT<CR>
map <leader>f   :CommandT<CR>

" ctags with rails load path
map <leader>rt :!bundle exec rails runner 'puts $LOAD_PATH.select{\|x\| x.include?(Dir.pwd) && x \!~ \%r{/(vendor\|spec)\b} }.join(" ")' \| xargs /usr/local/bin/ctags -R public/javascripts<CR>
map <leader>rT :!bundle exec rails runner 'puts $LOAD_PATH.select{\|x\| x.include?(Dir.pwd) && x \!~ \%r{/(vendor\|spec)\b} }.join(" ")' \| xargs bundle exec rdoc -f tags; /usr/local/bin/ctags --append -R public/javascripts<CR>

" Git blame
map <leader>g   :Gblame<CR>

" Comment/uncomment lines
map <leader>/   <plug>NERDCommenterToggle

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" Copy current file path to system pasteboard
map <leader>cp :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>

" Run tests
map <leader>t :wa<CR>:RunTestLine<CR>
map <leader>T :wa<CR>:RunTest<CR>
map <leader>tt :wa<CR>:RunTestAgain<CR>

map <F12> :write<CR>:RunTest<CR>
imap <F12> <ESC><F12>
map <F11> :write<CR>:RunTestLine<CR>
imap <F11> <ESC><F11>
map <F10> :write<CR>:RunTestAgain<CR>
imap <F10> <ESC><F10>
map <F9> :write<CR>:RunTestPrevious<CR>
imap <F9> <ESC><F9>

" Disable middle mouse button, F1
map <MiddleMouse>   <Nop>
imap <MiddleMouse>  <Nop>
map <F1>            <Nop>
imap <F1>           <Nop>

" Easy access to the shell
map <Leader><Leader> :!

" AckGrep current word
map <leader>a :call AckGrep()<CR>
" AckVisual current selection
vmap <leader>a :call AckVisual()<CR>

" Recalculate diff when it gets messed up.
nmap du :diffupdate<CR>

" Gundo.vim
map <leader>u :GundoToggle<CR>

" Make :EP! work like :e!
cabbrev EP! e!

" A rough opposite of J: inserts new-line. Real opposite of J, though, is: r<CR>
nmap <C-J> i<CR><ESC>

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

nmap <C-N><C-N> :set invnumber<CR>

highlight LineNr ctermfg=yellow ctermbg=black

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1

au BufRead,BufNewFile Dockerfile-base setfiletype Dockerfile
au BufRead,BufNewFile Dockerfile-dev setfiletype Dockerfile
