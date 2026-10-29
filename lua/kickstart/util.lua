local M = {}

function M.gh(repo)
	return "https://github.com/" .. repo
end

function M.safe_require(module)
	local ok, mod = pcall(require, module)
	if not ok then
		vim.notify("Failed to load module: " .. module .. "\n" .. tostring(mod), vim.log.levels.ERROR)
		return nil
	end
	return mod
end

function M.notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO)
end

return M
