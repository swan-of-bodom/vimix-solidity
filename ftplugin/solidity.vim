"IMPORTANT - Autosaves on every file update!!! needed for solc, else
"disable and :w when you want solc linting
autocmd TextChanged,TextChangedI * update

if exists("current_compiler")
  finish
endif
let current_compiler = "solc"

setlocal makeprg=hh\ coverage\ $*

setlocal errorformat=%f\|%l\ col\ %c\|%m

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost  make nested vertical botright copen 77
augroup END

"TagBar
"Tags you will see on tagbar
let g:tagbar_type_solidity = {
    \ 'ctagstype': 'solidity',
    \ 'kinds' : [
        \ 'n:Contract',
        \ 'l:Libraries',
        \ 'm:Modifiers',
        \ 'c:Constructor',
        \ 'f:Functions',
    \ ]
\ }

autocmd VimEnter * nested :TagbarOpen
highlight TagbarKind guifg=#95C561 
highlight TagbarHighlight guibg=#4A5057
highlight TagbarTagLineN guifg=#EEEE6D

let g:tagbar_show_tag_count=1
let g:tagbar_compact=2
let g:tagbar_iconchars = ['≡ ', '≡ '] 
let g:tagbar_indent=2

"Neoformat
let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
let g:neoformat_run_all_formatters = 1
" for <C-y> autofix
nmap <C-y> :Neoformat <CR>

"ALE
let g:ale_enabled = 1

highlight ALEWarningSign guifg=LightGoldenrod1

let g:ale_cache_executable_check_failures = v:null
let g:ale_command_wrapper = ''
let g:ale_completion_delay = v:null
let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = '■'
let g:ale_echo_msg_format = "[%linter%] %s (%code%)"
let g:ale_echo_msg_info_str = '💡'
let g:ale_echo_msg_warning_str = '■'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_list_window_size = 10
let g:ale_loclist_msg_format = '[%linter%] %s (%code%)'
let g:ale_max_buffer_history_size = 20
let g:ale_max_signs = -1
let g:ale_open_list = 1
let g:ale_pattern_options = v:null
let g:ale_pattern_options_enabled = v:null
let g:ale_set_balloons = 1
let g:ale_set_highlights = 1
"disabled for solc compiling
let g:ale_set_quickfix = 0
"enabled for solhint/prettier
let g:ale_set_loclist = 1
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_sign_offset = 1000000
let g:ale_type_map = {'solhint': {'ES': 'W', 'E':'W'}, 'solc': {'W': 'E', 'WS': 'E'} }
let g:ale_sign_error = '■'
let g:ale_sign_info = '💡'
let g:ale_sign_warning = '■'
let g:ale_use_global_executables = v:null
let g:ale_virtualtext_cursor = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
"go to next lint error/warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"vim's omnicomplete using <C-n> <C-p>
set wildmode=longest,list
set wildmenu

"close if only quickfix and nerdtree
function! s:CloseIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        \ || &buftype == 'quickfix'
    q
  endif
endfunction

augroup CloseIfOnlyControlWinLeft
  au!
  au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END

let g:tagbar_width=35
