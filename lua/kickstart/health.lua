local M = {}

local function has(executable)
	return vim.fn.executable(executable) == 1
end

function M.check()
	vim.health.start("kickstart.nvim")

	vim.health.info("Neovim version: " .. tostring(vim.version()))

	local required = { "git", "rg", "fd" }
	for _, exe in ipairs(required) do
		if has(exe) then
			vim.health.ok(exe .. " is available")
		else
			vim.health.warn(exe .. " is not available")
		end
	end

	local servers = { "clangd", "lua-language-server", "stylua" }
	for _, exe in ipairs(servers) do
		if has(exe) then
			vim.health.ok(exe .. " is available")
		else
			vim.health.warn(exe .. " is not available (install via Mason or your package manager)")
		end
	end
end

return M
