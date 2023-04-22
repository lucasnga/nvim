" source every plugin configs
for file in split(glob("~/nvim/pluggedconf/rust/*.nvimrc"), '\n')
    exe 'source' file
endfor
