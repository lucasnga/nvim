vim.g.lightline = {
    colorscheme = 'wombat',
    active = {
        left = { { 'mode', 'paste' }, { 'readonly', 'filename','gitbranch', 'modified', 'neospinner' } },
        right = { { 'lineinfo' }, { 'percent', 'wordcount', 'charcount' }, { 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' } },
    },
    component = {
        charvaluehex = '0x%B'
    },
    component_function = {
        wordcount = 'general#WordCount',
        caarcount = 'general#CharCount',
        gitbranch = 'FugitiveHead',
        neospinner = 'SpinnerText',
    },
}

function MyFiletype()
    return vim.fn.winwidth(0) > 70 and (strlen(vim.bo.filetype) and vim.bo.filetype .. ' ' .. WebDevIconsGetFileTypeSymbol() or 'no ft') or ''
end

function MyFileformat()
    return vim.fn.winwidth(0) > 70 and (vim.bo.fileformat .. ' ' .. WebDevIconsGetFileFormatSymbol()) or ''
end
