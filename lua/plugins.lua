local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

        -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
        use "neovim/nvim-lspconfig"
        use "glepnir/lspsaga.nvim"
        use "kabouzeid/nvim-lspinstall"

        -- Telescope
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-telescope/telescope.nvim"
				-- EmmetInstall
				use 'mattn/emmet-vim'
        -- Debugging
        use 'puremourning/vimspector'
				-- use "mfussenegger/nvim-dap"

        -- Autocomplete
        use "hrsh7th/nvim-compe" --completion
				use {'tzachar/compe-tabnine', requires = 'hrsh7th/nvim-compe'}
				use "hrsh7th/vim-vsnip"
        use "rafamadriz/friendly-snippets"
				use "dsznajder/vscode-es7-javascript-react-snippets"
        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use "windwp/nvim-ts-autotag"

        -- Explorer
        use "kyazdani42/nvim-tree.lua"
        -- TODO remove when open on dir is supported by nvimtree
        use "kevinhwang91/rnvimr"
		--use 'francoiscabrol/ranger.vim'
		--use 'rbgrouleff/bclose.vim'
        -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
        use "lewis6991/gitsigns.nvim"
        use "liuchengxu/vim-which-key"
        use "ChristianChiarulli/dashboard-nvim"
        use "windwp/nvim-autopairs"
        use "terrortylor/nvim-comment"
        use "kevinhwang91/nvim-bqf"

        -- Color
        use "christianchiarulli/nvcode-color-schemes.vim"
        -- Icons
        use "kyazdani42/nvim-web-devicons"

        -- Status Line and Bufferline
        use {"glepnir/galaxyline.nvim",
            branch = 'main',
            requires = {'kyazdani42/nvim-web-devicons'}
        }
        use "romgrk/barbar.nvim"
				-- Require plugings to be loaded during nvim launch
				require_plugin("compe-tabnine")
				require_plugin("vimspector")
				require_plugin("nvim-lspconfig")
				require_plugin("lspsaga.nvim")
        require_plugin("nvim-lspinstall")
        require_plugin("popup.nvim")
        require_plugin("plenary.nvim")
        require_plugin("telescope.nvim")
        require_plugin("nvim-compe")
        require_plugin("vim-vsnip")
        require_plugin("nvim-treesitter")
        require_plugin("nvim-ts-autotag")
        require_plugin("nvim-tree.lua")
        require_plugin("gitsigns.nvim")
        require_plugin("vim-which-key")
        require_plugin("dashboard-nvim")
        require_plugin("nvim-autopairs")
        require_plugin("nvim-comment")
        require_plugin("nvim-bqf")
        require_plugin("nvcode-color-schemes.vim")
        require_plugin("nvim-web-devicons")
        require_plugin("galaxyline.nvim")
        require_plugin("barbar.nvim")
    end
)
