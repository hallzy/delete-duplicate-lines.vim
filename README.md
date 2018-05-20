# Delete Duplicate Lines

This plugin provides a way to delete duplicated lines without the need to sort
the lines.

In normal mode, the plugin operates on the current paragraph, but you can also
define your own region by visually selecting some lines.

## Installation

Use your favourite Vim plugin manager

### Vim-plug

```vim
Plug 'hallzy/delete-duplicate-lines.vim'
```

## Usage

There is a visual and normal mode mapping you need to provide in your vimrc.

Choose whatever mapping you want. I personally use `<leader>d`.

```vim
nmap <leader>d <Plug>DeleteDuplicateLines<cr>
vmap <leader>d <Plug>DeleteDuplicateLinesVisual<cr>
```

When you use the plugin, the lines that are deleted will be saved in register
`d` for future reference. This can be changed with a configuration variable
explained lower down in this file.

The plugin will also print a message saying how many lines were removed.

### Configuration

#### Register to Save Deleted Lines

Set this variable to a single character to denote what register to save the
lines to.

If nothing is provided, they will be saved to register `d`

```vim
let g:delete_duplicate_lines#register = 'd'
```

If you do not want the data to be saved, set this variable to be either empty,
or `_` (This is the black hole register of Vim).

```vim
let g:delete_duplicate_lines#register = '_'
" or
let g:delete_duplicate_lines#register = ''
" or
let g:delete_duplicate_lines#register = ' '
```

If you enter more than one character, it will use the first character of the
string

```vim
" Uses register 'h'
let g:delete_duplicate_lines#register = 'hello'
```
