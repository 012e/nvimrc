local M = {}

-- checks if a file exists
local function exists(path)
	local f = io.open(path, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local function source_if_exists(name)
	if exists(name) then
		vim.cmd("source " .. name)
		print("source " .. name)
	end
end

local function luafile_if_exists(name)
	if exists(name) then
		vim.cmd("luafile " .. name)
		print("luafile " .. name)
	end
end

function M.setup(config)
	config = config or { pattern = ".nvimrc" }
	local lua_file = config.pattern .. ".lua"
	local vim_file = config.pattern

	-- Get exit status of git command
	vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
	if vim.v.shell_error == 0 then
		local git_root = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
		source_if_exists(git_root .. "/" .. vim_file)
		luafile_if_exists(git_root .. "/" .. lua_file)
	else
		source_if_exists(vim_file)
		luafile_if_exists(lua_file)
	end
end

return M
