# Vimix: Ethereum Remix in NeoVim!

Making NeoVim feel as close as possible to Ethereum's Remix, without bloating it or missing any core functions of Remix.

Vimix is a combination of plugins that work well with NeoVim/Vim and Solidity (0.8.9), not a plugin itself, thus none of the work here is my own. This is just the setup which I have been using to write solidity that I wish I found much earlier...

I have included my own configurations below for anyone to get started quickly.

## Features

- Very light and vim-like speed while writing solidity with important features from Remix. Tested extensively with Solidity 0.7 and up to 0.8.9.

- Hardhat compiling without having to leave the text editor, outputing errors in Vim directly.

- Quickfix buffer for compiler errors and location lists for linting errors.

- ftdetect and ftplugin to only enable specific aucmds for solidity (**red important below**)

- Solhint and Prettier warnings marked in yellow and easy to see while you type

![image](https://user-images.githubusercontent.com/97303883/160103484-143eb1a8-3920-4fb3-bc93-b6c638ec7a5c.png)

- Hardhat compiler errors marked in red and easy to see while you type

![image](https://user-images.githubusercontent.com/97303883/160103725-7064c79f-c831-449a-b701-7b9b83cb7678.png)

**Important**: Due to the way ALE works, it requires for solc files to be saved to show linting/compiler errors. To fix this, the ftplugin has a TextChanged, TextChangedI * update auto command which writes the file as you modify. This only enables it for solidity files.

## Showcase 

### Lints at runtime with Solhint and Solc + autofix with prettier-solidity
![formatandlint](https://user-images.githubusercontent.com/97303883/160021496-6a94be63-b744-4867-9359-08d35152bf0d.gif)
### Compile the whole project with Hardhat
![compile](https://user-images.githubusercontent.com/97303883/160021529-693e2468-2d18-47a1-9e97-82e1ae712280.gif)

## Requirements

* [Hardhat](https://hardhat.org/) - To compile the whole project. The reason to use hardhat's compiler here is to be able to compile the whole project and not just the file with solc. Uses the quickfix buftype.
* [vim-solidity](https://github.com/TovarishFin/vim-solidity) - For syntax keyword highlights.
* [Solc-Select](https://github.com/crytic/solc-select) - Solc version manager to change according to each project. Since ALE uses the solc executable it will adjust to whichever solc-select version you are using and which pragma you declare. Uses Location List buffer.
* [ALE](https://github.com/dense-analysis/ale/) - For linting at runtime with solhint and solc. Uses Location List buffer. 
* [Prettier-Solidity](https://github.com/prettier-solidity/prettier-plugin-solidity) - For displaying format warnings. 
* [Neoformat](https://github.com/sbdchd/neoformat) - For auto-fixing prettier's warnings.

## Installation 

1. Before anything else, you must have Hardhat installed for Vimix to work. Read here for more info: https://hardhat.org/getting-started/

`npm install --save-dev hardhat`

Make sure to also install shorthand **globally** (https://hardhat.org/guides/shorthand.html).


2. Then install requirements with any vim Plugin manager. Using Plug:

```
Plug 'dense-analysis/ale'

Plug 'crytic/solc-select'

Plug 'sbdchd/neoformat'

Plug 'TovarishFin/vim-solidity'
```

3. Install 

`Plug '0xhyoga/vimix-solidity'`

and enable ftplugin on .vimrc

`filetype plugin on`

## Configuration

In project folder make sure to install prettier solidity plugin and to create a solhint.json file

`npm install --save-dev prettier prettier-plugin-solidity`

My Solhint config:

```
{
  "extends": "solhint:recommended",
  "plugins": ["prettier"],
  "rules": {
    "compiler-version": ["error", "0.8.4"],
    "const-name-snakecase": "off",
    "constructor-syntax": "error",
    "max-line-length": ["error", 80],
    "not-rely-on-time": "off",
    "prettier/prettier": [
      "error",
      {
        "endOfLine": "auto"
      }
    ],
    "reason-string": ["warn", { "maxLength": 64 }]
  }
}
```

My ALE config in .vimrc:

```
let g:ale_enabled = 1

let g:ale_cache_executable_check_failures = v:null
let g:ale_command_wrapper = ''
let g:ale_completion_delay = v:null

let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '[%linter%] %s (%code%)'
let g:ale_echo_msg_info_str = 'Info'
let g:ale_echo_msg_warning_str = 'Warning'

let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_list_window_size = 10

let g:ale_loclist_msg_format = '[%linter%] %s (%code%)'

let g:ale_max_buffer_history_size = 20
let g:ale_max_signs = -1

let g:ale_open_list = 1

let g:ale_set_highlights = 1
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
let g:ale_set_signs = 1

let g:ale_type_map = {'solhint': {'ES': 'W', 'E':'W'}, 'solc': {'W': 'E', 'WS': 'E'} }

let g:ale_sign_column_always = 1
let g:ale_sign_offset = 1000000

let g:ale_sign_error = '■'
let g:ale_sign_info = '■'
let g:ale_sign_warning = '■'

highlight ALEWarningSign guifg=LightGoldenrod1

let g:ale_use_global_executables = v:null
let g:ale_virtualtext_cursor = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_sign_highlight_linenrs = 1

"no go to previous error or warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

"no go to next error or warning
nmap <silent> <C-j> <Plug>(ale_next_wrap)

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost make nested :vert :botright copen 60
augroup END

"replace with own keybind  
nmap <C-y> :Neoformat <CR>
```
