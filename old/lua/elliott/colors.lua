function ColorMyPencils(color)
	color = color or "moonfly"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.g.moonflyTerminalColors = true
    vim.g.moonflyTransparent = true
    vim.g.moonflyWinSeparator = 2
    vim.cmd("hi statusline guibg=none")
end

ColorMyPencils()
