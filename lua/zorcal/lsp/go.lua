local lspconfig_util = require 'lspconfig.util'

local Path = require 'plenary.path'

local root_finder = lspconfig_util.root_pattern('go.work', 'go.mod', '.git')

local function strsplit(s)
  s = s or ''
  if s:sub(-1) ~= '\n' then
    s = s .. '\n'
  end
  return s:gmatch '(.-)\n'
end

local cached_configs = {}

local extract_module_name = function(gomod_path)
  local module_name = nil

  local lines = gomod_path:head(5) -- assume module name is present in the first 5 lines
  local prefix = 'module '
  for line in strsplit(lines) do
    if line:find(prefix, 1, true) == 1 then
      module_name = string.sub(line, #prefix, #line)
      module_name = string.gsub(module_name, '%s+', '')
      break
    end
  end

  return module_name
end

local M = {}

-- Returns the module name extracted from the go.mod file closest to the current
-- buffer. Returns nil if no valid go.mod file exists.
M.module_name = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local path = Path:new(vim.api.nvim_buf_get_name(bufnr)):absolute()

  if cached_configs[path] == nil then
    local file_path = Path:new(path)
    local root_path = Path:new(root_finder(path))

    -- Check if we are already at the root.
    if file_path:absolute() == root_path:absolute() then
      local gomod_path = Path:new { root_path, 'go.mod' }
      local module_name = extract_module_name(gomod_path)
      if module_name ~= nil then
        cached_configs[path] = module_name
      end
      return module_name
    end

    local file_parents = file_path:parents()
    local root_parents = root_path:parents()

    local relative_diff = #file_parents - #root_parents
    for index, dir in ipairs(file_parents) do
      if index > relative_diff then
        break
      end

      local gomod_path = Path:new { dir, 'go.mod' }
      if gomod_path:exists() then
        local module_name = extract_module_name(gomod_path)
        if module_name ~= nil then
          cached_configs[path] = module_name
        end
        return module_name
      end
    end
  end

  return cached_configs[path]
end

return M
