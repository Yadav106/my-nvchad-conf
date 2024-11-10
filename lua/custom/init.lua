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
