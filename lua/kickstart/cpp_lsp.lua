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
	local filename = vim.fn.expand("%")
	local ext = vim.fn.expand("%:e")
	if ext == "cpp" then
		filename = replaceLastOccurrence(filename, "src/", "incl/")
		filename = filename:gsub("cpp$", "h")
		vim.cmd("e " .. filename)
	else
		filename = replaceLastOccurrence(filename, "incl/", "src/")
		filename = filename:gsub("h$", "cpp")
		vim.cmd("e " .. filename)
	end
end

vim.keymap.set("n", "-", [[:lua PairCppFile()<CR>]], { noremap = true, desc = "Toggle .h/.cpp" })
vim.keymap.set("n", "<F2>", [[:lua PairCppFile()<CR>]], { noremap = true, desc = "Toggle .h/.cpp" })

local function createClangDFile()
	local file = io.open(".clangd", "r")
	if file then
		file:close()
		return
	end

	file = io.open(".clangd", "w")
	if not file then
		return
	end
	local is_win = vim.fn.has("win32") == 1
	local home = is_win and (os.getenv("USERPROFILE") or "C:/Users/Public") or (os.getenv("HOME") or "/home")
	local vendor_base = os.getenv("KICKSTART_VENDOR_DIR")
	if not vendor_base then
		vendor_base = is_win and (home .. "/Dev/vendor-x64-windows/T-x64-ntvc") or "/home/fsukri/Dev/vendor-x64-windows/T-x64-ntvc"
	end
	vendor_base = vendor_base:gsub("\\", "/")
	local vcpkg_include = is_win and (home .. "/Downloads/vcpkg/installed/x64-windows/include") or "/home/fsukri/Downloads/vcpkg/installed/x64-windows/include"
	vcpkg_include = vcpkg_include:gsub("\\", "/")

	local lines = {
		"CompileFlags:",
		"  Add:",
		"    - '-std=c++17'",
	}
	local function add_inc(p)
		table.insert(lines, "    - '-I" .. p .. "'")
	end
	add_inc(vendor_base .. "/qt6/include")
	add_inc(vendor_base .. "/gtest/include")
	add_inc(vendor_base .. "/cpr/include")
	add_inc(vendor_base .. "/qt6/include/QtConcurrent")
	add_inc(vendor_base .. "/qt6/include/QtCore")
	add_inc(vendor_base .. "/qt6/include/QtGui")
	add_inc(vendor_base .. "/qt6/include/QtNetwork")
	add_inc(vendor_base .. "/qt6/include/QtNetworkAuth")
	add_inc(vendor_base .. "/qt6/include/QtSql")
	add_inc(vendor_base .. "/qt6/include/QtWebChannel")
	add_inc(vendor_base .. "/qt6/include/QtWebSockets")
	add_inc(vendor_base .. "/qt6/include/QtWidgets")
	add_inc(vendor_base .. "/rapidjson-1.1.0/include")
	add_inc(vcpkg_include)
	file:write(table.concat(lines, "\n") .. "\n")

	local pwd = vim.fn.getcwd():gsub("\\", "/")
	file:write("    - '-I" .. pwd .. "/incl'\n")
	file:write("    - '-I" .. pwd .. "/src'\n")

	local extracted_path = pwd:match("(sysdev/[^/]*/[^/]*)")
	if extracted_path then
		local dev_base = is_win and (home .. "/Dev") or "/home/fsukri/Dev"
		dev_base = dev_base:gsub("\\", "/")
		file:write("    - '-I" .. dev_base .. "/" .. extracted_path .. "/arch/T-x64-ntvc/incl'\n")
		file:write("\n")
		file:write("Diagnostics:\n")
		file:write("  IgnoreHeader:\n")
		file:write("    - " .. dev_base .. "/" .. extracted_path .. "/arch/T-x64-ntvc/incl/\n")
	end
	file:close()
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-cpp-lsp", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "clangd" then
			local compile_command = io.open("compile_commands.json", "r")
			if compile_command then
				compile_command:close()
				return
			end
			createClangDFile()
		end
	end,
})
