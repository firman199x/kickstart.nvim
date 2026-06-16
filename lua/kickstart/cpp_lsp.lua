local function replaceLastOccurrence(str, find, replace)
  local reversed_str = str:reverse()
  local reversed_find = find:reverse()
  local reversed_replace = replace:reverse()

  local start, finish = reversed_str:find(reversed_find)
  if start then
    reversed_str = reversed_str:sub(1, start - 1) .. reversed_replace .. reversed_str:sub(finish + 1)
  end

  return reversed_str:reverse()
end

function _G.PairCppFile()
  local filename = vim.fn.expand '%'
  local ext = vim.fn.expand '%:e'
  if ext == 'cpp' then
    filename = replaceLastOccurrence(filename, 'src/', 'incl/')
    filename = filename:gsub('cpp$', 'h')
    vim.cmd('e ' .. filename)
  else
    filename = replaceLastOccurrence(filename, 'incl/', 'src/')
    filename = filename:gsub('h$', 'cpp')
    vim.cmd('e ' .. filename)
  end
end

vim.keymap.set('n', '-', [[:lua PairCppFile()<CR>]], { noremap = true, desc = 'Toggle .h/.cpp' })
vim.keymap.set('n', '<F2>', [[:lua PairCppFile()<CR>]], { noremap = true, desc = 'Toggle .h/.cpp' })

local function createClangDFile()
  local file = io.open('.clangd', 'r')
  if file then file:close(); return end

  file = io.open('.clangd', 'w')
  file:write [[
CompileFlags:
  Add:
    - '-std=c++17'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/gtest/include'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/cpr/include'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtConcurrent'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtCore'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtGui'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtNetwork'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtNetworkAuth'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtSql'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtWebChannel'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtWebSockets'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/qt6/include/QtWidgets'
    - '-I/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc/rapidjson-1.1.0/include'
    - '-I/home/fsukri/Downloads/vcpkg/installed/x64-windows/include'
]]

  local pwd = vim.fn.getcwd()
  file:write("    - '-I" .. pwd .. "/incl'\n")
  file:write("    - '-I" .. pwd .. "/src'\n")

  local extracted_path = pwd:match '(sysdev/[^/]*/[^/]*)'
  if extracted_path then
    file:write("    - '-I/home/fsukri/Dev/" .. extracted_path .. "/arch/T-x64-ntvc/incl'\n")
    file:write '\n'
    file:write "Diagnostics:\n"
    file:write "  IgnoreHeader:\n"
    file:write("    - /home/fsukri/Dev/" .. extracted_path .. "/arch/T-x64-ntvc/incl/\n")
  end
  file:close()
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-cpp-lsp', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == 'clangd' then
      local compile_command = io.open('compile_commands.json', 'r')
      if compile_command then compile_command:close(); return end
      createClangDFile()
    end
  end,
})
