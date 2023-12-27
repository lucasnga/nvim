if vim.g.vdebug_options ~= 0 then
    vim.g.vdebug_options = {}
end

vim.g.vdebug_options['break_on_open'] = 0
vim.g.vdebug_options['watch_window_style'] = 'compact'
vim.g.vdebug_options["port"] = 9000

vim.g.vdebug_keymap = {
    run = "<F5>",
    run_to_cursor = "<F9>",
    step_over = "<F2>",
    step_into = "<F3>",
    step_out = "<F4>",
    close = "<F6>",
    detach = "<F7>",
    set_breakpoint = "<F10>",
    get_context = "<F11>",
    eval_under_cursor = "<F12>",
    eval_visual = "<F8>",
}

-- map the project when used in a vagrant / vm | vm path : host past
vim.g.vdebug_options['path_maps'] = {}

-- redefine the characters
vim.cmd([[ exec "autocmd VimEnter * sign define breakpt text= texthl=DbgBreakptSign linehl=DbgBreakptLine" ]])
vim.cmd([[ exec "autocmd VimEnter * sign define current text= texthl=DbgCurrentSign linehl=DbgCurrentLine" ]])
