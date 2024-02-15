local opt = vim.opt
local g = vim.g

-------------------------------------- options -----------------------------------------
opt.laststatus = 3
opt.showmode = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.termguicolors = true
-- opt.statusline = "%!v:lua.require('plugins.statusline.st').run()"

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
-- opt.softtabstop = 2

-- characters to fill the statuslines
-- 'eob' uses for empty lines at the end of a buffer
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
-- 'a' means mouse support for normal mode, visual mode, insert mode and command-line mode 
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false -- show the line and column number of the cursor position

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("LazyUpdate", function()
  require("lazy").update()
end, {})

new_cmd("LazyProfile", function()
  require("lazy").profile()
end, {})
------------------------------------ autocommands ----------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- redraw statusline on LspProgressUpdaate
autocmd("User", {
  pattern = "LspProgressUpdate",
  callback = function()
    vim.cmd "redrawstatus"
  end,
})
