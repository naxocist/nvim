-- CONSTANT
local diag_current_line = false

-- OPTIONS
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = "single"
vim.opt.list = true
vim.opt.listchars = { tab = "▏ ", trail = "·", extends = ">", precedes = "<" }

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		vim.keymap.set("i", "<C-s>", "<esc>", { buffer = args.data.buf_id })
		vim.keymap.set("n", "<M-h>", "<left>",  { buffer = args.data.buf_id })
		vim.keymap.set("n", "<M-l>", "<right>", { buffer = args.data.buf_id })
		vim.keymap.set("n", "<leader>e", function() MiniFiles.close() end, { buffer = args.data.buf_id })
	end,
})

-- KEYMAPS
local map = function(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>")
map("n", "<C-p>", "<cmd>lua MiniPick.builtin.files()<cr>")
map("n", "<C-g>", "<cmd>lua MiniPick.builtin.grep_live()<cr>")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><esc>")
map("n", "<leader>q", "<cmd>q<cr>")
map({ "n", "i" }, "<esc>", "<esc><cmd>nohl<cr>")
map("n", "<leader>gs", "<cmd>lua MiniGit.show_at_cursor()<cr>")
map("n", "<leader>gg", function()
	vim.cmd("botright 60split | terminal lazygit")
	vim.cmd("startinsert")
end)
map("n", "<leader>gd", "<cmd>lua MiniDiff.toggle_overlay()<cr>")
map("n", "<leader>td", function()
	diag_current_line = not diag_current_line
	vim.diagnostic.config({ virtual_text = diag_current_line })
end)

-- DIAGNOSTICS
vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	signs = true,
	underline = true,
	severity_sort = true,
})

-- LSP
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				indexing = false,
			},
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local m = function(k, v)
			vim.keymap.set("n", k, v, { buffer = ev.buf, silent = true })
		end
		m("gd", vim.lsp.buf.definition)
		m("gr", vim.lsp.buf.references)
		m("K", vim.lsp.buf.hover)
		m("<leader>rn", vim.lsp.buf.rename)
		m("<leader>ca", vim.lsp.buf.code_action)
		m("<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end)
		m("[d", function()
			vim.diagnostic.jump({ count = -1 })
		end)
		m("]d", function()
			vim.diagnostic.jump({ count = 1 })
		end)
		m("<leader>d", vim.diagnostic.open_float)
	end,
})

-- LAZY.NVIM BOOTSTRAP
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "enter",
				["<C-y>"] = { "show", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
			},
			completion = { menu = { auto_show = true } },
			snippets = { preset = "mini_snippets" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = { "lua", "python", "javascript", "typescript", "bash", "json", "yaml", "c" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.icons").setup()
			require("mini.snippets").setup({
				snippets = { require("mini.snippets").gen_loader.from_lang() },
			})
			require("mini.pick").setup({
				mappings = {
					move_down = "<C-j>",
					move_up = "<C-k>",
				},
			})
			require("mini.files").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.git").setup()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "+", change = "~", delete = "-" },
				},
			})
			require("mini.base16").setup({
				palette = {
					base00 = "#111111",
					base01 = "#1a1a1a",
					base02 = "#222222",
					base03 = "#6e6a86",
					base04 = "#908caa",
					base05 = "#e0def4",
					base06 = "#e0def4",
					base07 = "#f7f3f3",
					base08 = "#eb6f92",
					base09 = "#f6c177",
					base0A = "#ea9a97",
					base0B = "#3e8fb0",
					base0C = "#9ccfd8",
					base0D = "#c4a7e7",
					base0E = "#f6c177",
					base0F = "#56526e",
				},
			})
			vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#587c0c" })
			vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#0c7d9d" })
			vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#94151b" })
			vim.api.nvim_set_hl(0, "MiniDiffOverAdd",       { bg = "#1e4620" })
			vim.api.nvim_set_hl(0, "MiniDiffOverChange",    { bg = "#3d3000" })
			vim.api.nvim_set_hl(0, "MiniDiffOverChangeBuf", { bg = "#3d3000" })
			vim.api.nvim_set_hl(0, "MiniDiffOverDelete",    { bg = "#5c1111" })
			require("mini.statusline").setup()
		end,
	},
})
