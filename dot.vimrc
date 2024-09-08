set cursorline
set fileencodings=utf-8,cp932
set hlsearch
set incsearch
set smartindent
set laststatus=2
set number
syntax enable
colorscheme industry

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

" OS判別してIME制御を切り替え
if has('macunix')
    " Mac用IME制御コマンド
    command! ImeOff silent !osascript -e 'tell application "System Events" to set input source to "com.apple.keylayout.US"'
    command! ImeOn silent !osascript -e 'tell application "System Events" to set input source to "com.apple.inputmethod.Kotoeri.Hiragana"'

    function! ImeAutoOff()
        let w:ime_status=system('osascript -e "tell application \"System Events\" to get name of current input source"')
        if w:ime_status =~ "Hiragana"
            :silent ImeOff
        endif
    endfunction

    function! ImeAutoOn()
        if !exists('w:ime_status')
            let w:ime_status=0
        endif
        if w:ime_status =~ "Hiragana"
            :silent ImeOn
        endif
    endfunction
else
    command! ImeOff silent !imectrl 0
    command! ImeOn silent !imectrl 1

    function! ImeAutoOff()
        let w:ime_status=system('imests')
        :silent ImeOff
    endfunction

    function! ImeAutoOn()
        if !exists('w:ime_status')
            let w:ime_status=0
        endif
        if w:ime_status == 1
            :silent ImeOn
        endif
    endfunction
endif

" IME off when in insert mode
augroup InsertHook
    autocmd!
    autocmd InsertLeave * call ImeAutoOff()
    autocmd InsertEnter * call ImeAutoOn()
augroup END

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

