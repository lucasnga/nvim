vim.g.startify_list_order = { 'bookmarks' }

function CommandToStartifyTable(command)
    return function()
        local cmd_output = vim.fn.systemlist(command .. " 2>/dev/null")
        local files =
        vim.tbl_map(
            function(v)
                return {line = v, path = v}
            end,
            cmd_output
        )
        return files
    end
end

vim.g.startify_lists = {
    { type = 'files',     header = { '   MRU' }            },
    { type = 'dir',       header = { '   MRU '.. vim.fn.getcwd() } },
    { type = 'sessions',  header = { '   Sessions' }       },
    { type = 'bookmarks', header = { '   Bookmarks' }      },
    { type = CommandToStartifyTable('git ls-files -m'),  header = { '   git modified' }},
    { type = CommandToStartifyTable('git ls-files -o --exclude-standard '), header = { '   git untracked' }},
    { type = 'commands',  header = { '   Commands' }       },
}
