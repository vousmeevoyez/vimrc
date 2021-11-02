set nocompatible              " required
set encoding=utf-8
filetype off                  " required
set splitbelow
set splitright
set number relativenumber "hybrid
syntax on
filetype plugin indent on    " required

"split navigation
"
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Core
Plugin 'gmarik/Vundle.vim'
Plugin 'nvie/vim-flake8'
Plugin 'junegunn/fzf.vim'
Plugin 'ycm-core/YouCompleteMe'

"colorscheme
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'connorholyday/vim-snazzy'
Plugin 'drewtempelmeyer/palenight.vim'

" python
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'kien/ctrlp.vim' useless
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
"Plugin 'psf/black'
Plugin 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" AIRLINE
Plugin 'vim-airline/vim-airline'

Plugin 'w0rp/ale'

"" JS
Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
Plugin 'leafoftree/vim-vue-plugin'
Plugin 'mattn/emmet-vim'
Plugin 'jparise/vim-graphql'
Plugin 'heavenshell/vim-jsdoc'

"" Typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'

"" PHP
Plugin 'StanAngeloff/php.vim'

call vundle#end()            " required

"" DART + FLUTTER
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'natebosch/vim-lsc'
Plugin 'natebosch/vim-lsc-dart'
Plugin 'neoclide/coc.nvim'


"minimal for nerdtree"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:SimpylFold_docstring_preview = 0

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme dracula
  highlight Normal ctermbg=NONE
endif

" map nerd tree with ctrl + n
map <C-n> :NERDTreeToggle<CR>

" AIRLINE
set t_Co=256
set noshowmode

set rtp+=/usr/local/opt/fzf

let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'vue': ['eslint']
\}
let g:ale_fixers = {
  \    'python': ['autopep8','isort'],
  \    'javascript': ['prettier'],
  \    'typescript': ['prettier'],
  \    'vue': ['prettier'],
  \    'scss': ['prettier'],
  \    'html': ['prettier'],
  \    'reason': ['refmt']
\}

nmap <F10> :ALEFix<CR>

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:vim_vue_plugin_load_full_syntax = 1

""" YCM FOR PYTHON
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
nnoremap gtd :YcmCompleter GoToDefinition<CR>
nnoremap gtr :YcmCompleter GoToReferences<CR>
nnoremap gt :YcmCompleter GoTo<CR>
let g:pydocstring_formatter = 'numpy'
let g:pydocstring_doq_path = '/Users/kelvindesman/.pyenv/shims/doq'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error

" COPY TO CLIPBOARD
vmap '' :w !pbcopy<CR><CR>

"" PYTHON
let python_highlight_all=1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"autocmd BufWritePre *.py execute ':Black'


" PEP 8 Indentation
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

"" JAVASCRIPT
au FileType vue setlocal formatprg=prettier
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
"autocmd BufEnter *.js,*.vue,*.html,*.ts set background=dark colorscheme palenight
au BufNewFile,BufRead *.js,*.html,*.css,*.vue,*.ts,*.dart
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set expandtab |
	\ set autoindent 
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

"" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"" EMMET
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

"" ALE
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

"" LEHRE
let g:jsdoc_lehre_path = '/usr/local/lib/node_modules/lehre/bin/lehre'

"" DART SPECIFIC
let dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1
