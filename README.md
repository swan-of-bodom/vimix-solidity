# Vimix: Ethereum Remix in Vim

Making NeoVim feel as close as possible to Ethereum's Remix, without bloating it or missing any core functions of Remix.

Vimix is a combination of plugins that work well with NeoVim/Vim and Solidity (0.8.9), not a plugin itself, thus none of the work here is my own. This is just the setup which I have been using to write solidity that I wish I found much earlier...

I have included my own configurations below for anyone to get started quickly.

If you find any errors or anything to add please let me know! 

## Requirements

* [Hardhat](https://hardhat.org/) - To compile the whole project. The reason to use hardhat's compiler here is to be able to compile the whole project and not just the file with solc. Uses the quickfix buftype.
* [Solc-Select](https://github.com/crytic/solc-select) - Solc version manager to change according to each project. Since ALE uses the solc executable it will adjust to whichever solc-select version you are using and which pragma you declare. Uses Location List buffer.
* [ALE](https://github.com/dense-analysis/ale/) - For linting at runtime with solhint and solc. Uses Location List buffer.  

## Showcase 

Fix all format errors automatically, show function tags, compile, test and coverage with Hardhat. All without leaving Vim!

![Neoformat+Sol cover](https://user-images.githubusercontent.com/97303883/160896058-9e10f2f0-ef69-417a-b20a-a5214760228f.gif)

## Features

- Very light and fast while keeping all the core functionalities of Remix. Tested extensively with Solidity 0.7 and up to 0.8.9.

- Compile the whole project with Hardhat without leaving Vim.

- Runtime Solc compiler errors 🟥 and Solhint/Prettier syntax warnings 🟨. Scroll through each one with <C-j> and <C-k>

![image](https://user-images.githubusercontent.com/97303883/160899340-825e77fa-3bfa-479c-a68e-68b58d394e03.png)
![image](https://user-images.githubusercontent.com/97303883/160895526-93f9706f-b293-49fd-8031-acd4ee4a508e.png)

- Fix all solhint/prettier warnings with Neoformat <C-l>.

- Customized quickfix window to show Hardhat Test and Coverage outputs

![image](https://user-images.githubusercontent.com/97303883/160899744-64b7a33c-41cd-44bf-92c0-e099eef7be77.png)

- CTags to show functions and quickly go through each one. Scroll through each one with <C-b> and <C-n>

**Important**: Due to the way ALE works with Solc, it requires for .sol files to be saved BEFORE linting/compiling errors. To fix this, the ftplugin has an auto command which writes the file as you modify. This only enables it for solidity files.

 
## Installation 

1. Before anything else, you must have Hardhat installed for Vimix to work. Read here for more info: https://hardhat.org/getting-started/

`npm install --save-dev hardhat`

Make sure to also install shorthand **globally** (https://hardhat.org/guides/shorthand.html).

2. Then install requirements with any vim Plugin manager. Using Plug:

```
Plug 'dense-analysis/ale'

Plug 'crytic/solc-select'

Plug 'sbdchd/neoformat'

```

3. Install 

`Plug '0xhyoga/vimix-solidity'`

and put this in your .vimrc:

`filetype plugin on`


## Configuration

In Solidity project folder make sure to install prettier solidity plugin and to create a .solhint.json file

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
let g:ale_sign_info = 💡
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

```

## Optional

I use the following to automate some processes like auto-formatting and showing tags:

* [Neoformat](https://github.com/sbdchd/neoformat) - For auto-fixing prettier-solidity warnings.
* Ctags
* Tagbar 

### Ctags and Tagbar

For universal CTags you can follow here for instructions https://github.com/universal-ctags/ctags

Depending on your setup, you will need to create a .ctags file with the regex rules:

```
--langdef=Solidity                                                              

--langmap=Solidity:.sol                                                         

--regex-Solidity=/^contract[ \t]+([a-zA-Z0-9_]+)/\1/n,contract/                 

--regex-Solidity=/[ \t]*constructor\(/Constructor/c,constructor/

--regex-Solidity=/[ \t]*function[ \t]+([a-zA-Z0-9_]+)*\(/\1/f,function/

--regex-Solidity=/[ \t]*event[ \t]+([a-zA-Z0-9_]+)*\(/\1/e,event/

--regex-Solidity=/[ \t]*mapping[ \t]+\(([a-zA-Z0-9_]+)[ \t]*=>[ \t]*([a-zA-Z0-9_]+)\)[ \t]+([a-zA-Z0-9_]+)/\3 (\1=>\2)/m,mapping
 ```

If you are adding more rules, make sure to edit the ftplugin/solidity.vim file to add the rules:

```
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
```
 
 Tagbar should then automatically pick up the tags you have created :)
