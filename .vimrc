set nocompatible              " be iMproved, required
filetype off                  " required

" BAD HABIT FIX
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Utilities 
Plugin 'tpope/vim-obsession'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tmux-plugins/vim-tmux-focus-events'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'sjl/gundo.vim'
Plugin 'ConradIrwin/vim-bracketed-paste'

"Navigation
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-vinegar'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'benmills/vimux'
Plugin 'kien/ctrlp.vim'

" Color "
Plugin 'godlygeek/csapprox'
Plugin 'ap/vim-css-color'
Plugin 'nanotech/jellybeans.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'tpope/vim-vividchalk'
Plugin 'goatslacker/mango.vim'
Plugin 'sjl/badwolf'
Plugin 'flazz/vim-colorschemes'

" Language support "
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/VimClojure'
Plugin 'kchmck/vim-coffee-script'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'burnettk/vim-angular'
Plugin 'elzr/vim-json'
Plugin 'millermedeiros/vim-esformatter'
Plugin 'marijnh/tern_for_vim'
Plugin 'sidorares/node-vim-debugger'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-perl/vim-perl'

" Editing "
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-unimpaired'"
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'scrooloose/syntastic'
" Plugin 'myint/syntastic-extras'
" Plugin 'mattn/emmet-vim'
" Plugin 'terryma/vim-multiple-cursors'
"  Plugin 'chrisbra/NrrwRgn'

" Tag Support "
" Plugin 'vim-scripts/taglist.vim'
" Plugin 'tmhedberg/matchit'
" Plugin 'tpope/vim-surround'

call vundle#end()            " required

set linespace=2
set showtabline=2
set tabpagemax=15

set background=dark
colorscheme bvemu

" make shell not suck Thanks Modules :(
set shellcmdflag+=f

"use visual bell instead of beeping
set vb

"set incremental search
set incsearch

"syntax highlighting
"set bg=light
syntax on
filetype plugin indent on

"Compatability"
set encoding=utf8

" Toggle relative numbers  on FocusLost
autocmd FocusLost * :set number norelativenumber
" Using vim-tmux-navigator bindings, on FocusLost ^[[O was left behind
autocmd FocusLost * silent redraw!
autocmd FocusGained * :set number relativenumber
" Toggle relative numbers in insert mode
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set number relativenumber

"autoindent
"autocmd FileType perl set autoindent|set smartindent

"2 space tabs
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

" Word wrap w/o line breaks "
set wrap
set linebreak
set list
set nostartofline

" Delays
set timeoutlen=1000
set ttimeoutlen=10

"Prevent comments from continuing
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"show matching brakets
autocmd FileType perl set showmatch

"show line numbers
set number

"Customization and plugin mapping "
let mapleader=","


" Screw backups "
set nobackup nowritebackup noswapfile

"Perl"
"check perl code with make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

"Perl Critic
set errorformat+=%m\ at\ %f\ line\ %l\.
set errorformat+=%m\ at\ %f\ line\ %l
noremap ,c :!time perlc --critic %<cr>

" dont' use Q for Ex mode
" map Q :q

" make tab in v ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" paste mode - this avoid unexpceted effects pasting from other window
set pastetoggle=<F11>

" comment/uncomment blocks of code 
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

" my perl includes pod
let perl_include_pod = 1

" syntax color complex thing like@{${FOO}}
let perl_extended_vars = 1

" Tidy selected lines (or entire files) with _t:
nnoremap <silent> _t :%!perltidy -ce -i=2 -q<Enter>
vnoremap <silent> _t :!perltidy -ce -i=2 -q<Enter>

" Deparse obfuscated code
nnoremap <silent> _d :.!perl -MO=Deparse 2>/dev/null<cr>
vnoremap <silent> _d :!perl -MO=Deparse 2>/dev/null<cr>

"Ctrlp "
noremap <Leader>b <ESC>:CtrlPBuffer<CR>
noremap <Leader><SPACE> <ESC>:CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = '\v[\/](_build|(\.(git|hg|svn)))$'
let g:ctrlp_max_depth = 10
let g:ctrlp_max_files = 0 "
set wildignore+=*/tmp/*,*.o,*.so,*.swp,*.zip,*.jar,*.class,*.pdf,*.gif,*.png,*.jpg,*.o,*.hi "
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
        \ }
endif

" vimux "
function VimuxMakeRun()
  :VimuxInterruptRunner
  :VimuxInterruptRunner
  :VimuxRunCommand("clear;make")
endfunction
noremap <Leader>r :exec VimuxMakeRun()<CR>

"Airline "
set laststatus=2   " Always show the statusline "
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline) "
autocmd VimEnter * AirlineToggleWhitespace
"let g:airline_powerline_fonts=1
let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_section_y='%{ObsessionStatus()}'

" gundo "
nnoremap <Leader>u :GundoToggle<CR>

" folds! "
set foldenable
set foldmethod=syntax
set foldnestmax=2
set foldlevel=1
set foldlevelstart=1
set foldminlines=10
set fillchars=vert:\|,fold:\
noremap <Leader>f zR
" Toggle folds with space "
fu! ToggleFold()
  if foldlevel('.') == 0
    normal! l
  else
    if foldclosed('.') < 0
      . foldclose
    else
      . foldopen
    endif
  endif
  echo
endf
noremap <space> :call ToggleFold()<CR>

"Easycommenting "
autocmd FileType js,coffee,c,cpp,java,javascript let b:comment_leader = '// '
autocmd FileType vim,rc let b:comment_leader = '" ' "
autocmd FileType conf,fstab,ruby,python,perl let b:comment_leader = '# '
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"Search help "
set incsearch ignorecase hlsearch
set autoread
set smartcase
set magic
set showmatch
set mat=2
set ai
set si
set wrap
set nu

" Systastic "
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list=1
let g:syntastic_javascript_checkers = ['json_tool']
let g:syntastic_make_checkers = ['gnumake']
noremap <Leader><Tab> :Errors<CR>

" Taglist "
noremap <silent> <Leader>t :TlistToggle<CR>
let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Ctags_Cmd='/usr/bin/ctags'

set foldenable
set foldmethod=syntax
set foldnestmax=2
set foldlevel=1
set foldlevelstart=1
set foldminlines=10
set fillchars=vert:\|,fold:\
noremap <Leader>f zR
" Toggle folds with space "
fu! ToggleFold()
  if foldlevel('.') == 0
    normal! l
  else
    if foldclosed('.') < 0
      . foldclose
    else
      . foldopen
    endif
  endif
  echo
endf
noremap <space> :call ToggleFold()<CR>
