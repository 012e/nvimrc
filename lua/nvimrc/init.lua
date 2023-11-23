local utils = require("nvimrc/utils")

local M = {}

local function source_if_exists(name)
	if utils.exists(name) then
		vim.cmd("source " .. name)
		print("source " .. name)
	end
end

local function luafile_if_exists(name)
	if utils.exists(name) then
		vim.cmd("luafile " .. name)
		print("luafile " .. name)
	end
end

function M.setup(config)
	config = config or { pattern = ".nvimrc" }
	config.pattern = config.pattern or ".nvimrc"
	local lua_file = config.pattern .. ".lua"
	local vim_file = config.pattern

	-- Get exit code of git command
	local code = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }):wait().code
	if code == 0 then
		local git_root = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait().stdout
    print("root: "..git_root)
		print("path: " .. git_root .. utils.path_separator .. vim_file)
    print(config.pattern)
		source_if_exists(git_root .. utils.path_separator .. vim_file)
		luafile_if_exists(git_root .. utils.path_separator .. lua_file)
	else
		source_if_exists(vim_file)
		luafile_if_exists(lua_file)
	end
end

return M
