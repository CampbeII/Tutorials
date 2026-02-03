# Colour Schemes
How to create your own syntax highlighting and colour themes. 

## 1. Edit your vimrc
Make the following changes to your `.vimrc` file:

```sh
syntax on

" Choose a name for your colorscheme
colorscheme mycolorscheme

" Optional 
set termguicolors
```

## 2. Read documentation
The follow 2 pages of the documentation provide details on how to declare custom colour themes. 
```sh
:help highlight
:help group-name
```

## 3. File Locations
### Language Specific Syntax Highlighting
All files for common languages are contained in the `/syntax` directory:
```sh
~/vim/vim90/syntax/ps1.vim
```

Syntax files contain multiple lines identifying patterns in your code language. They can be done using `match` if you need regular expressions or `keyword` for a string match.
```
" Match on keywords
syn keyword ps1Keyword try catch finally throw

" Match on regular expression
syn match ps1Constant +\$_+
```

At the bottom you can see the mappings and the vim groups they belong to:
```
hi def link ps1Keyword Keyword
```

## 4. Colour Scheme
Colour schemes are located in the `/colors` directory.
```sh
~/vim/vim90/colors/mycolourscheme.vim
```

To change the colour of the `Keyword` syntax to black `#000` you would write this line:
```
hi keyword guifg=#000000 guibg=NONE gui=NONE cterm=NONE
```
