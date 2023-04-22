" Declare the general config group for autocommand
augroup js
    autocmd!
augroup END

setlocal ts=2 sts=2 sw=2 expandtab 

autocmd js FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/js/*.nvimrc"), '\n')
    exe 'source' file
endfor

