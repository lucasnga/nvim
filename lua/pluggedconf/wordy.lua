vim.g["wordy#ring"] = { 
    'weak',
    { 'being', 'passive-voice' },
    'business-jargon',
    'weasel',
    'puffery',
    { 'problematic', 'redundant' },
    { 'colloquial', 'idiomatic', 'similies' },
    'art-jargon',
    { 'contractions', 'opinion', 'vague-time', 'said-synonyms' },
    'adjectives',
    'adverbs',
}

vim.keymap.set("n","<F8>",  ":<C-u>NextWordy<cr>", { noremap=true, silent = true })
vim.keymap.set({'x', 'n'},"<F8>", ":<C-u>NextWordy<cr>", { noremap=true, silent = true })
vim.keymap.set({'i', 'n'},"<F8>", "<C-o>:NextWordy<cr>", { noremap=true, silent = true }) 
