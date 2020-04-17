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
command W w !sudo tee % > /dev/null

set encoding=utf8
set mouse=a
set number
set relativenumber

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Turn on the Wild menu
set wildmenu
set maxmempattern=10000

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

"set list lcs=tab:\|\
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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'honza/vim-snippets'
Plug 'uber/prototool', { 'rtp':'vim/prototool' }
Plug 'dense-analysis/ale'
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
Plug 'diepm/vim-rest-console'
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

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif


call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1

" theme
set background=dark
colorscheme gruvbox
"hi Normal ctermbg=none
"hi NonText ctermbg=none
"colorscheme molokai
"colorscheme onedark

" vim-go
let g:go_gopls_enabled = 0
let g:go_def_mapping_enabled = 0
"let g:go_fmt_autosave = 1
"let g:go_highlight_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions=1
"let g:go_highlight_function_calls = 1

" rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

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
    let win = nvim_open_win(buf, v:true, opts)
    " call nvim_win_set_option(win, 'winhl', 'Normal:gruvbox')
    hi def NvimFloatingWindow ctermbg=none
    call nvim_win_set_option(win, 'winhl', 'Normal:NvimFloatingWindow')
endfunction

"vim-autoformat
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
noremap <leader>f :Autoformat<CR>
"au BufWrite *.go,*.py :Autoformat

" coc.nvim go format
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" floaterm
noremap  <silent> <leader>tt     :FloatermToggle<CR>
noremap! <silent> <leader>tt     <Esc>:FloatermToggle<CR>
tnoremap <silent> <leader>tt     <C-\><C-n>:FloatermToggle<CR>

" easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

"""""""""" airline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" snipper
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"ale
" Error and warning signs.
let g:ale_enabled = 1
let g:ale_linters_explicit = 1
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
            \  'proto': ["prototool-lint"],
            \}
let g:ale_change_sign_column_color = 1
hi link ALESignColumnWithErrors  None
hi link ALESignColumnWithoutErrors  None

" mapping
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ns :nohl<CR>
" nnoremap <leader>tt :botright 10split term://zsh<cr>a
" nnoremap <leader>nt :tabnew term://zsh<cr>a
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Completion coc.nvim
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

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gf :call CocAction('format')<CR>
nnoremap <leader>ls :<C-u>CocList outline<cr>
nnoremap <leader>lt :<C-u>CocList diagnostics<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

"let $NVIM_COC_LOG_LEVEL = 'debug'
"
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Defx
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })

nmap <silent> <Leader>e :Defx <cr>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
