local E = {}
local fn = vim.fn

E.echo = function(str) -- used for show messages in cmdline.
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

local function shell_call(args)
  local output = fn.system(args)
  -- 'vim.v.shell_error == 0' means no problem, and when it turns to false, assert() would issue an error.
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

E.lazy = function(install_path)
  --------- lazy.nvim ---------------
  E.echo "  Installing lazy.nvim & plugins ..."
  local repo = "https://github.com/folke/lazy.nvim.git"
  shell_call { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  vim.opt.rtp:prepend(install_path)

  -- install plugins
  require "plugins"
end

return E
