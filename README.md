# nvimrc

A simple plugin to automatically source your local neovim configuration file.

## Installation
    
With `lazy.nvim`: add the following to your `require("lazy").setup({})`
```lua
	{ "012e/nvimrc", config = {}, },
```

## Usage

If you didn't specify `config = {}`, add `require("012e/nvimrc").setup()` somewhere in your config file.

- Default configuration:
```lua
require("nvimrc").setup({
    -- The file name pattern to search for
    pattern = ".nvimrc",
})
```

## How it works

- If your current directory is in in a git repo:
  - If file `.nvimrc` is found at the git root, the following command is ran `source /your/git/root/.nvimrc`.
  - If file `.nvimrc.lua` is found at the git root, the following command is ran `luafile /your/git/root/.nvimrc.lua`.
- Else the plugin checks your current directory and do the exact same thing.
