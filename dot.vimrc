set cursorline
set fileencodings=utf-8,cp932
set hlsearch
set incsearch
set smartindent
set laststatus=2
set number
syntax enable
colorscheme ron

if has('persistent_undo')
    let undo_path = expand('~/.vim/undo')
    exe 'set undodir=' .. undo_path
    set undofile
endif

""""""""""""""""""""""""""""""""""""
" 日本語入力関連
""""""""""""""""""""""""""""""""""""
" 行頭へ移動
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
" 行末へ移動
cnoremap <C-e> <End>
inoremap <C-e> <End>
" 単語移動
inoremap <silent> <C-b> <Cmd>normal! b<CR>
inoremap <silent> <C-f> <Cmd>normal! w<CR>
" 行移動
inoremap <silent> <C-p> <Cmd>normal! gk<CR>
inoremap <silent> <C-n> <Cmd>normal! gj<CR>
" 保存
inoremap <C-s> <C-o>:w<CR>


let g:is_macos = has('mac')
nnoremap <silent><expr> <F2> IME_toggle()
inoremap <silent><expr> <F2> IME_toggle()

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
    call system('/path/to/im-select com.justsystems.inputmethod.atok33.Japanese')
  elseif has('unix')
    call system('imectrl 1')
  else
    call system('zenhan 1')
  endif
endfunction

function! Disable() abort
  if has('mac')
    call system('/path/to/im-select com.apple.keylayout.ABC')
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
"Jetpack 'tpope/vim-surround'
"Jetpack 'scrooloose/nerdtree'
"Jetpack 'kien/ctrlp.vim'

call jetpack#end()

