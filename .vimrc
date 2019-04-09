filetype off                  " required
filetype plugin on
filetype indent on
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
" Set to auto read when a file is changed from the outside
set autoread
" Fast saving
nmap <leader>w :w!<cr>
" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

set encoding=utf8
set mouse=a
set number
set relativenumber

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Turn on the Wild menu
set wildmenu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

set colorcolumn=80
set hlsearch
set showcmd 
set ignorecase "检索时忽略大小写
set smartcase
set clipboard=unnamed
set lazyredraw 
set cindent
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
Plug 'Valloric/YouCompleteMe'
"Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'cespare/vim-toml'
Plug 'solarnz/thrift.vim'
Plug 'ybian/smartim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"Theme
Plug 'flazz/vim-colorschemes'
"Plugin 'dracula/vim'
"Plugin 'jdkanani/vim-material-theme'
"Plugin 'morhetz/gruvbox'
"Plugin 'joshdick/onedark.vim'
"Plugin 'rakr/vim-one'

" completion
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" runtimepath
set runtimepath^=~/.vim/plugged/ag.vim
set runtimepath+=~/.vim/plugged/LanguageClient-neovim

"nerdtree
"execute pathogen#infect()
map <F2> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:airline#extensions#tabline#enabled = 1
" vim-go
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
nnoremap <silent> <F7> :GoInfo<CR>
nnoremap <leader>gn :cnext<CR>
nnoremap <leader>gp :cprevious<CR>
nnoremap <leader>gc :cclose<CR>
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
"let g:go_auto_type_info = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"let g:go_addtags_transform = 'camelcase'
let g:go_addtags_transform = 'snakecase'

"theme
set background=dark
colorscheme gruvbox
"set background=light
"colorscheme solarized
"colorscheme hybrid_material
"colorscheme onedark
"colorscheme dracula

" rainbow 
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ag
" fzf
" The Silver Searcher
let g:ag_working_path_mode="r"
nnoremap <silent> <C-p> :Files<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<space>

" vim-autoformat
noremap <leader>f :Autoformat<CR>

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" airline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" snipper
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"ale
" Error and warning signs.
let g:ale_enabled = 1
" let g:ale_linters_explicit = 1
let g:ale_set_highlights = 0
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_sign_error = 'x'
let g:ale_sign_warning = 'o'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
    \  'go': ["golint","go build","go vet"],
    \  'c': ["clang","cppcheck"],
\}
let g:ale_change_sign_column_color = 1
hi link ALESignColumnWithErrors  None
hi link ALESignColumnWithoutErrors  None

" mapping
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ns :nohl<CR>
nnoremap <leader>tt :botright 10split term://zsh<cr>a
nnoremap <leader>nt :tabnew term://zsh<cr>a
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Completion Configuration
let g:completionchosen = "ncm2"
let g:coc_start_at_startup = 0
let g:LanguageClient_autoStart = 0
let g:loaded_youcompleteme = 0
let g:ncm2_loaded = 0

if g:completionchosen == "coc" 
    " coc.nvim
    let g:coc_start_at_startup = 1 
	" Smaller updatetime for CursorHold & CursorHoldI
	set updatetime=300
    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

elseif g:completionchosen == "ncm2"

    "let g:ncm2_loaded = 1
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " Use <TAB> to select the popup menu:
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    "let g:deoplete#enable_at_startup = 1
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_serverCommands = {
        \ 'go': ['bingo'],
        \ 'php': ['php', '/Users/Bing/WorkSpace/php-language-server/bin/php-language-server.php'],
        \ 'c': ['ccls'],
        \ 'cpp': ['ccls'],
        \ }
    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    nnoremap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<CR>
elseif g:completionchosen == "ycm"
    " YCM
    unlet g:loaded_youcompleteme
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
else
    echo 'no completion loaded'
endif
