local vim = vim
local opt = vim.opt

vim.g.loaded_matchparen = 1

-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Function to create class properties from constructor parameters, handling default values
function CreateClassProperties()
  local line = vim.fn.getline('.')
  
  -- Match constructor parameters
  local params = line:match("constructor%((.-)%)")
  if not params then
    print("No parameters found in constructor.")
    return
  end

  -- Split parameters by commas, remove spaces, and handle default values
  local vars = {}
  for param in params:gmatch("[^,]+") do
    param = vim.fn.trim(param)
    param = vim.fn.trim(param:match("([^=]+)"))  -- Remove default values (anything after '=')
    table.insert(vars, param)
  end

  -- Insert 'this.param = param;' lines
  local insert_lines = {}
  for _, var in ipairs(vars) do
    table.insert(insert_lines, "    this." .. var .. " = " .. var .. ";")
  end

  -- Insert lines below current line
  vim.fn.append(vim.fn.line('.'), insert_lines)
end

-- Map the function to a command for easy use
vim.api.nvim_set_keymap('n', '<leader>cp', ':lua CreateClassProperties()<CR>', { noremap = true, silent = true })

-- Uncomment this if you wanna use educationallsp
--
-- ---@diagnostic disable-next-line: missing-fields
-- local client = vim.lsp.start_client {
--   name = "educationallsp",
--   cmd = { "/Users/macbook/Desktop/Programming/educationallsp/main" },
--   on_attach = function(client, bufnr)
--     local dg_fun = function()
--       vim.diagnostic.open_float { border = "rounded" }
--     end,
--     -- Set up hover mapping
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', { noremap = true, silent = true })
--   end
-- }
--
-- if not client then
--   vim.notify "hey, you didn't do the client thing"
--   return
-- end
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function ()
--     vim.lsp.buf_attach_client(0, client)
--   end,
-- })
