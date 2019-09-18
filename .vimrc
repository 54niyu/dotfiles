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
" nmap <leader>w :w!<cr>
" " :W sudo saves the file 
" " (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null
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

set list lcs=tab:\|\ 
let g:netrw_liststyle=3
let g:netrw_fastbrowse=0

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
Plug 'Yggdroot/indentLine'
Plug '54niyu/vim-go'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'cespare/vim-toml'
Plug 'solarnz/thrift.vim'
Plug 'voldikss/vim-floaterm'
if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
elseif has('mac')
    Plug '/usr/local/opt/fzf'
endif

Plug 'junegunn/fzf.vim'

"Theme
Plug 'flazz/vim-colorschemes'
Plug 'joshdick/onedark.vim'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" runtimepath
let g:airline#extensions#tabline#enabled = 1

" theme
set background=dark
"colorscheme gruvbox
"colorscheme molokai 
colorscheme onedark

" vim-go
" let g:go_def_mapping_enabled = 0
" let g:go_fmt_autosave = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions=1
"let g:go_highlight_function_calls = 1
" rainbow 
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>r :Rg<CR>
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'
" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)
  " 90% of the height
  let height = float2nr(&lines * 0.9)
  " 60% of the height
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = 1
  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height
        \ }
  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

" vim-autoformat
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
noremap <leader>f :Autoformat<CR>
au BufWrite *.py,*.go :Autoformat

" floaterm
noremap  <silent> <F7>           :FloatermToggle<CR>i
noremap! <silent> <F7>           <Esc>:FloatermToggle<CR>i
tnoremap <silent> <F7>           <C-\><C-n>:FloatermToggle<CR>

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"""""""""" airline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" snipper
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"ale
" Error and warning signs.
"let g:ale_enabled = 1
"let g:ale_linters_explicit = 1
"let g:ale_set_highlights = 0
"let g:ale_completion_delay = 500
"let g:ale_echo_delay = 20
"let g:ale_lint_delay = 500
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"let g:ale_sign_error = 'x'
"let g:ale_sign_warning = 'o'
"let g:ale_lint_on_text_changed = 'normal'
"let g:ale_lint_on_insert_leave = 1
"let g:ale_lint_on_enter = 0
"" Enable integration with airline.
"let g:airline#extensions#ale#enabled = 1
"let g:ale_linters = {
"    \  'go': ["golint","go build","go vet"],
"    \  'c': ["clang","cppcheck"],
"    \  'proto': ['prototool lint'],
"\}
"let g:ale_change_sign_column_color = 1
hi link ALESignColumnWithErrors  None
hi link ALESignColumnWithoutErrors  None

" prototool
function! PrototoolFormat() abort
    silent! execute '!prototool format -w %'
    silent! edit
endfunction

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
let g:completionchosen = "coc"
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
    nmap <silent> gf :call CocAction('format')<CR>

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
        \ 'go': ['gopls']
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

"let $NVIM_COC_LOG_LEVEL = 'debug'
