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

Choose whatever mapping you want. I personally use `<leader>`.

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

* If nothing is provided, they will be saved to register `d`
* If the variable is set to an empty string, it won't be saved
* If you enter more than one character, it will use the first character of the
  string
* Non-alpha characters are not allowed

```vim
let g:delete_duplicate_lines#register = 'd'
```
