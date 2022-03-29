autocmd TextChanged,TextChangedI * update

if exists("current_compiler")
  finish
endif
let current_compiler = "solc"

setlocal makeprg=hh\ coverage\ $*

setlocal errorformat=%f\|%l\ col\ %c\|%m

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost make nested vertical botright copen 77
augroup END

let g:tagbar_type_solidity = {
    \ 'ctagstype': 'solidity',
    \ 'kinds' : [
        \ 'n:0. Contract',
        \ 'l:1. Libraries',
        \ 'm:2. Modifiers',
        \ 'c:4. Constructor',
        \ 'f:5. Functions',
    \ ]
\ }

let g:tagbar_show_tag_count=1
let g:tagbar_compact=2
let g:tagbar_iconchars = ['≡ ', '≡ '] 

autocmd VimEnter * nested :TagbarOpen

highlight TagbarKind guifg=#95C561 
highlight TagbarHighlight guibg=#4A5057
highlight TagbarTagLineN guifg=#EEEE6D
let g:tagbar_indent=4
