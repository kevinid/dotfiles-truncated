" Yibo's neovim setup

" NeoBundle setup {{{
    if &compatible
    set nocompatible
    endif

    " add the dein installation directory into runtimepath
    set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

    if dein#load_state('~/.cache/dein')
        call dein#begin('~/.cache/dein')

        " Configure dein with dein
        call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
        call dein#add('Shougo/deoplete.nvim')

        " Git utilities
        call dein#add('airblade/vim-gitgutter')

        " Utilities
        call dein#add('scrooloose/nerdtree') " File browsing
        call dein#add('tpope/vim-surround') " Change surroundings
        call dein#add('tomtom/tcomment_vim') " Commenting
        " Provide folding support for php, tex,...
        " call dein#add('Konfekt/FastFold') " Folding
        call dein#add('pseewald/vim-anyfold')
        call dein#add('rking/ag.vim')
        " call dein#add('Yggdroot/indentLine') " Displaying indent line
        call dein#add('mileszs/ack.vim') " For global search
        call dein#add('terryma/vim-multiple-cursors')

        " Themes
        call dein#add('vim-airline/vim-airline')
        call dein#add('tomasiser/vim-code-dark')
        call dein#add('vim-airline/vim-airline-themes')

        " For code completion
        call dein#add('Shougo/denite.nvim')
        call dein#add('Shougo/deoplete.nvim')
        call dein#add('Shougo/echodoc.vim')
        call dein#add('zchee/deoplete-jedi') " python completion for deoplete
        call dein#add('tmux-plugins/vim-tmux') " plugin for tmux.conf
        call dein#add('ekalinin/Dockerfile.vim') " plugin for dockerfile
        call dein#add('deoplete-plugins/deoplete-docker')  " plugin for docker
        call dein#add('deoplete-plugins/deoplete-zsh')  " plugin for zsh

        " Linting
        " Provide syntax checking for vim
        call dein#add('vim-syntastic/syntastic')

        call dein#end()
        call dein#save_state()
    endif

    filetype plugin indent on
    syntax enable
"}}}

" Settings {{{
	" Enable true
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	" Change cursor shape
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

	" No backup before overwritting the file
	set nowritebackup
	" Do not save backup after the file is successfully written
	set nobackup
	" Do not create swapfile during edit
	set noswapfile
	set history=100 " Set command history
	set ruler " Show the line and colum number of the cursor
	set showcmd " Show incomplete commands in the final line of the screen
	set incsearch " Incremental searching (search as you type)
	set hlsearch " Highlight search matches
	set smartcase " Ignore case in search
	set ignorecase

	set hidden
	set nowrap " Do not wrap line
	" Allowing backspacing indent, end of line (eol) and start of insert
	set backspace=indent,eol,start

	" Use the appropriate number of spaces to insert a <Tab>
	set expandtab
	set tabstop=4
	set shiftwidth=4

	set number " Print line number
	set relativenumber " Use relative line number
	" The charactor of 'tab' and trail
	set list listchars=tab:\ \ ,trail:·

	" Get rid of the delay when pressing O (for example)
	set timeout timeoutlen=1000 ttimeoutlen=100

	set laststatus=2  " Always show status line

	" Set the status line to something useful
	set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)
	set guioptions-=T
	set encoding=utf-8
	set autoread

	" Use system clipboard
	" set clipboard+=unnamed

	set splitbelow " Put new window below the current window
	set splitright " Put the new window to the right

	set cursorline  " Highlight the current line

	set visualbell " Use screen flashing instead of beeping for error message

	set wildmenu
	set lazyredraw " Do not redraw screen when running marcros
	set showmatch " For matching

	" Set built-in file system explorer to use layout similar to the
	" NERDTree plugin
	let g:netrw_liststyle=3

	" Always highlight column 80 so it's easier to see where
	" cutoff appears on longer screens
	autocmd BufWinEnter * highlight ColorColumn ctermbg=grey
	set colorcolumn=80
" }}}

" Mappings {{{
    " Clear search buffer
    :nnoremap § :nohlsearch<cr>

    " NERDTree
    " Searching the file system
    map <leader>' :NERDTreeToggle<cr>

    " File System Explorer (in horizontal split)
    map <leader>. :Sexplore<cr>

    " Make splitting Vim windows easier
    map <leader>; <C-W>s
    map <leader>` <C-W>v

    " Tmux style window selection
    map <Leader>ws :ChooseWin<cr>

    " Move between windows faster
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " Bind nohl (no highlight)
    map <Leader>n :nohl<CR>

    " Quicker saving
    noremap <C-Z> :update<CR>
    vnoremap <C-Z> <C-C>:update<CR>
    inoremap <C-Z> <C-O>:update<CR>

    " other remaps
    nnoremap ; :

    " easier moving of code blocks
    vnoremap < <gv
    vnoremap > >gv

    " tcommenting mapping
    " <C-/> can not be reliably mapped
    " vnoremap <C-/> :TComment<CR>

    " copy to osx clipboard
    " vnoremap <C-c> "*y<CR>
    " vnoremap y "*y<CR>
    " nnoremap Y "*Y<CR>

    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
" }}}

" Color {{{
    " Theme
    set termguicolors
    set background=light
    colorscheme codedark
" }}}

" Plugins {{{
    " Ack (uses Ag behind the scenes)
    let g:ackprg = 'ag --nogroup --nocolor --column'

    " airline
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "codedark"

    " deoplete
    if !empty(glob('/usr/bin/python2.7'))
        let g:python_host_prog = '/usr/bin/python2.7'
    else
        let g:python_host_prog = '/usr/local/bin/python2.7'
    endif

    if !empty(glob('/usr/bin/python3.7'))
        let g:python3_host_prog = '/usr/bin/python3.7'
    else
        let g:python3_host_prog = '/usr/local/bin/python3.7'
    endif

    let g:deoplete#enable_at_startup=1 " enable deoplete at start up
    let g:echodoc_enable_at_startup = 1 " enable echodoc at start up
    set cmdheight=2

    " deoplete-zsh
    call deoplete#custom#source('zsh', 'filetypes', ['zsh', 'sh'])

    " Syntastics
    set statusline+=%#warningmsg#
    " set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_python_checkers = ['pylint']

    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
        set conceallevel=2 concealcursor=niv
    endif

    " anyfold
    autocmd Filetype * AnyFoldActivate
    set foldlevel=99
" }}}

" Commands {{{
    " Jump to last cursor when opening
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    fun! StripTrailingWhitespace()
        " don't strip on these filetypes
        if &ft =~ 'markdown'
          return
        endif
        %s/\s\+$//e
    endfun

    autocmd BufWritePre * call StripTrailingWhitespace()

    " visual-at.vim
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

    function! ExecuteMacroOverVisualRange()
        echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction
" }}}
