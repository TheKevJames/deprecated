set expandtab     " spaces > tabs
set hlsearch      " show highlights on search
set laststatus=0  " hide statusline
set number        " show line numbers
set shiftwidth=4  " tabs are 4 spaces
set showmatch     " show matching bracket on insertion

filetype plugin indent on  " enable filetype detection
syntax on                  " show syntax highlighting

autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

autocmd FileType text setlocal textwidth=79
