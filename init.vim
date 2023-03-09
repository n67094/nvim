call plug#begin()
	Plug 'itchyny/lightline.vim' 
	Plug 'dyng/ctrlsf.vim'
	let g:plug_timeout = 300
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'Yggdroot/indentLine'
	Plug 'sainnhe/sonokai'
	Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdtree'
	Plug 'ap/vim-css-color'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'
	Plug 'weirongxu/plantuml-previewer.vim'
	Plug 'tyru/open-browser.vim'
	Plug 'aklt/plantuml-syntax'
call plug#end()

syntax on
filetype plugin indent on

set number
set autoindent
set hlsearch
set list
set conceallevel=0
set cursorline
set exrc

" Change the cursor by mode
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

noremap L gt<cr>
noremap H gT<cr>

" Remap leader key to space
let mapleader="\<space>"

" Auto generate tags file on file write of *.c and *.h files
autocmd BufWritePost *.c,*.h silent! !ctags -R &

" IndentLine
let g:indentLine_setColors=0
let g:indentLine_showFirstIndentLevel=1

" CtrlSF
let g:ctrlsf_backend = 'ag'
let g:ctrlsf_default_view_mode='compact'

" Coc.nvim
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" NeerdTree

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
         
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
         
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Sonokai
if has('termguicolors')
	set termguicolors
endif

let g:sonokai_style = 'default'
let g:sonokai_better_performance = 1

colorscheme sonokai

let g:lightline = {'colorscheme' : 'sonokai'}

" Allow to unhide backticjs vim and vim-polyglot
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" fix the fact that the NERDTree menu don't resize on exist since vim 9.xxx
let g:NERDTreeMinimalMenu=1
