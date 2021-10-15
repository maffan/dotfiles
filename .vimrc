if has('win32')
    let $VIMDIR = "~/vimfiles"
else
    let $VIMDIR = "~/.vim"
endif

let $PLUGDIRECTORY = $VIMDIR . "/plugged"

" Plugin stuff {{{
" vim-plug {{{
if empty(glob($VIMDIR . '/autoload/plug.vim'))
if has("win32")
    silent !iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni $HOME/vimfiles/autoload/plug.vim -Force
else
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

endif

" Set leader
let mapleader = "\\"
let maplocalleader = "\<space>"

call plug#begin($PLUGDIRECTORY)
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
Plug 'glench/vim-jinja2-syntax'
" Plug 'tpope/vim-flagship'
Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'
Plug 'embear/vim-localvimrc'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mtth/scratch.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'ycm-core/YouCompleteMe'
if !has("win32")
  if executable('ctags')
    Plug 'yegappan/taglist'
  endif
endif
call plug#end()
" vim-plug }}}

" UltiSnip

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" YCM
" Lookup symbol in entire workspace
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
" Lookup symbol in current document
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
" Find declaration
nmap <leader>yd :YcmCompleter GoToDeclaration<CR>
" Find all references
nmap <leader>yr :YcmCompleter GoToReferences<CR>
" Toggle hover box
nmap <leader>d <Plug>(YCMHover)

let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_collect_identifiers_from_tags_filesmap=1
let g:ycm_extra_conf_globlist=['/mnt/c/repos/*']
let g:force_test=0
let g:ycm_extra_conf_vim_data=['g:force_test']
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_disable_for_files_larger_than_kb = 3000

" Taglist
nnoremap <leader>tl :TlistToggle<CR>
let g:Glist_Show_One_File=1

" commentary
augroup c_comment
    autocmd!
    autocmd FileType c setlocal commentstring=//%s
augroup END

" flagship
" set showtabline=2
" set guioptions-=e

" localvimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

" CtrlP
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = "ra"
" let g:ctrlp_user_command = 'find %s -type f'

" NERDtree
noremap <F2> :NERDTreeToggle<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFocus<CR>
nnoremap <Leader>nb :NERDTreeFind<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Colorscheme
let g:gruvbox_italic=1
set termguicolors
set background=dark
colorscheme gruvbox

" pandoc
let g:pandoc#modules#disabled = ["folding"]

" cscope
if has('cscope')
    if has('win32')
        set csprg=\cygwin64\bin\cscope
    endif
    set cscopetag
    if filereadable("cscope.out")
        set nocscopeverbose
        set csto=0
        cs add cscope.out
        set cscopeverbose
    endif
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    " Prepare for references lookup
    nnoremap <leader>cfr :cscope find s 
    " Prepare for definition lookup
    nnoremap <leader>cfd :cscope find g 
    " Lookup calls to the function under cursor
    nnoremap <leader>cfc :cscope find c 

    " Lookup references for symbol under cursor
    nnoremap <leader>cr :cscope find s <C-R>=expand("<cword>")<CR><CR>
    " Lookup definition of symbol under cursor
    nnoremap <leader>cd :cscope find g <C-R>=expand("<cword>")<CR><CR>
    " Lookup calls to the function under cursor
    nnoremap <leader>cc :cscope find c <C-R>=expand("<cword>")<CR><CR>
endif


" Terminal
tnoremap <C-[> <C-\><C-n>
tnoremap <Leader>sm <C-\><C-n>mSa
tnoremap <Leader>gm <C-\><C-n>`S

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Plugin stuff }}}

" Standard stuff
" No bells please
set belloff=all
" Mouse integration when available
set mouse=a
" Tab handling
set tabstop=4
set shiftwidth=4
" Always UTF-8
set encoding=UTF-8
" Smart case search
set ignorecase
set smartcase
" Try to complete, otherwice show list, then cycle through possibilities
set wildmode=longest,list,full
" Ignore some file endings
set wildignore+=*.o,*.d,*.lst
" Make whitespace visable
set list
" Show extra line a bottom with some useful info
set showcmd
" Always show the status line
set laststatus=2
" The default value doesn't work on windows systems, since tags and TAGS maps
" to the same file
" First look for 'tags' file in current directory, 
set tags=./tags,tags


" Truncate the line at the start
set statusline=%<
" Filename
set statusline+=%f
" Space
set statusline+=\ 
" Filetype
set statusline+=%y
" [help]
set statusline+=%h
" [+]
set statusline+=%m
" [RO]
set statusline+=%r
" Git information
set statusline+=%{FugitiveStatusline()}
" Align following to the right
set statusline+=%=
" Left justify with minimum width of 14, no maximum width
set statusline+="%-14."
" Group containing line number, Column number and Virtual column number
set statusline+="(%l,%c%V%)"
" Space
set statusline+=\ 
" Percentage of file displayed
set statusline+=%P


" Functions
function! TemplateReplace()
    " Replace '-' and '_' with spaces
    " Use provided title if available
    if !empty($TEMPLATE_TITLE)
      let l:title = $TEMPLATE_TITLE
    else
      " Generate title from file name
      let l:title = tr(tr(expand('%:r'), '-', ' '), '_', ' ')
      " Make title case
      let l:title = substitute(l:title, '\<\(\w\)\(\w*\)\>', '\u\1\L\2', 'g')
    endif
    let l:date = strftime('%B, %e %Y')
    exec "%s/{{date}}/" . l:date . "/ge"
    exec "%s/{{title}}/" . l:title . "/ge"
    normal! G
endfun

function! MD2PDF()
    if &modified
        echoe "Save changes first"
        return 1
    endif
    let l:mdfile = expand("%")
    let l:pdffile = expand("%:r") . ".pdf"
    execute '!pandoc ' . l:mdfile . ' -o ' . l:pdffile . ' && zathura ' . l:pdffile
endfunction

" Abbrevs
" Email address
iabbrev @@ marcus.flyckt@gmail.com
" Signature
iabbrev ssig --<cr>Marcus Flyckt<cr>marcus.flyckt@gmail.com

" Mappings
" Move line down
nnoremap - ddp
" Move line up
nnoremap _ kddpk
" Edit vimrc in split
nnoremap <leader>ev :vsplit $MYVIMRC<cr><c-w>H
" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Edit local vimrc
nnoremap <leader>elv :LocalVimRCEdit<cr>
" Reload local vimrc
nnoremap <leader>slv :LocalVimRC<cr>
" Disable arrow keys
nnoremap <up> <nop>
nnoremap <right> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
" Create session file, save all buffers and quit
nnoremap <leader>sq :mksession!<cr>:wqa<cr>
" Replace any occurence of register f with register t inside curly braces
nnoremap <leader>frn vi{:s/<c-r>f/<c-r>t/gc<cr>
" Yank the word under the cursor
nnoremap Y yiw
" Replace the word under the cursor with register t
nnoremap <leader>rw viw"tp
" Replace current line and start inserting
nnoremap <leader>c ^C
" Insert current date
nnoremap <leader>id "=strftime('%B, %e %Y')<cr>p
" Toggle line numbers
nnoremap <leader>ln :set number!<CR>
" Toggle relative line numbers
nnoremap <leader>rln :set relativenumber!<CR>

" Remove current line while remaining in insert mode
inoremap <leader><c-d> <esc>ddi
" Exit insert mode
inoremap jk <esc>
" Replace current line
inoremap <leader>c <esc>^C
" Turn current word uppercase
inoremap <c-u> <esc>viwUea

" Replace any occurence of register f with register t inside selection
vnoremap <leader>rn :s/<c-r>f/<c-r>t/gc<cr>

" Commands
" Plugsort: Sorts vim-plug rows
command! -range Plugsort <line1>,<line2>sort i /.*\/\(vim-\)\=/

" Autocommands {{{
augroup templates
  autocmd!
  let templatefile = "$VIMDIR/templates/skeleton.md"
  if filereadable(templatefile)
      autocmd BufNewFile *.md 0r $VIMDIR/templates/skeleton.md | call TemplateReplace()
  endif
augroup END

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup nowrap_group
  autocmd!
  autocmd FileType html,xml setlocal nowrap
augroup END

augroup filetype_c
  autocmd!
  autocmd FileType c :iabbrev <buffer> mmain int main(int argc, char *argv[])<cr>{<cr>}<up>
augroup END

augroup filetype_md
    autocmd!
    autocmd FileType md :nnoremap <maplocalleader>tpdf :call MD2PDF()
augroup END

" autocommands }}}

" Aros specific {{{
if isdirectory('Sw/A_Xmc')
    function! ArosMakeArgs(A,L,P)
        return "all\nclean\nrebuild\nheaders\nhelp"
    endfun
    function! ArosCompile(target)
        execute '!cd Sw/A_Xmc' . '& make.bat ' . a:target
    endfun
    function! ArosStartDaVinci()
        execut 'silent !cd Sw/A_Xmc & start_DaVinci.bat'
    endfun
    command! -nargs=? -complete=custom,ArosMakeArgs Amake call ArosCompile(<f-args>)
    command! -nargs=0 ADV call ArosStartDaVinci()
endif
" Aros }}}
