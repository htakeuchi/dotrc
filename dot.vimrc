set cursorline
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set hlsearch
set incsearch
set smartindent
set laststatus=1
set number
syntax enable
colorscheme pablo

if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' .. undo_path
    set undofile
endif

" let NERDTreeShowHidden=0
let mapleader = " "
map <C-z> :NERDTreeToggle<CR>
map <C-a> <Home>
map <C-e> <End>
map <silent> <C-p> <Cmd>normal! gk<CR>
map <silent> <C-n> <Cmd>normal! gj<CR>
map <C-s> <C-o>:w<CR>
map <C-l> gt
map <C-h> gT

nnoremap <silent><expr> <F2> IME_toggle()
inoremap <silent><expr> <F2> IME_toggle()
nnoremap <Leader>mn  :MemoNew<CR>
nnoremap <Leader>ml  :MemoList<CR>
nnoremap <Leader>mg  :MemoGrep<CR>

augroup IME_autotoggle
  autocmd!
  autocmd InsertEnter * if get(b:, 'IME_autoenable', v:false) | call Enable() | endif
  autocmd InsertLeave * call Disable()
  autocmd CmdLineEnter /,\? if get(b:, 'IME_autoenable', v:false) | cnoremap <CR> <Plug>(kensaku-search-replace)<CR>| endif
  autocmd CmdLineEnter /,\? if !get(b:, 'IME_autoenable', v:false) | silent! cunmap <CR> | endif
augroup END

function! IME_toggle() abort
  let b:IME_autoenable = !get(b:, 'IME_autoenable', v:false)
  if b:IME_autoenable ==# v:true
    echomsg '日本語入力モードON'
    if mode() == 'i'
      call Enable()
    endif
  else
    echo '日本語入力モードOFF'
    if mode() == 'i'
      call Disable()
    endif
  endif
  return ''
endfunction

function! Enable() abort
  if has('mac')
    " Karabina
  elseif has('unix')
    call system('imectrl 1')
  else
    call system('zenhan 1')
  endif
endfunction

function! Disable() abort
  if has('mac')
    " Karabina
  elseif has('unix')
    call system('imectrl 0')
  else
    call system('zenhan 0')
  endif
endfunction

nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>

""""""""""""""""""""""""""""""""""""
" vim-jetpack
""""""""""""""""""""""""""""""""""""
packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'mattn/vim-sonictemplate'
Jetpack 'plasticboy/vim-markdown'
Jetpack 'godlygeek/tabular'
Jetpack 'preservim/nerdtree'
Jetpack 'glidenote/memolist.vim'
"Jetpack 'tpope/vim-surround'
"Jetpack 'kien/ctrlp.vim'

call jetpack#end()

