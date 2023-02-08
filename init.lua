-- ┏━┓╋┏┓╋╋╋╋╋╋┏━━━┓╋╋╋╋╋┏━━━┓┏┓╋╋╋╋┏━┓┏━┓
-- ┃┃┗┓┃┃╋╋╋╋╋╋┗┓┏┓┃╋╋╋╋╋┃┏━┓┣┛┗┓╋╋╋┃┏┛┃┏┛
-- ┃┏┓┗┛┣┳━━┳━━┓┃┃┃┣━━┳┓┏┫┗━━╋┓┏╋┓┏┳┛┗┳┛┗┓
-- ┃┃┗┓┃┣┫┏━┫┏┓┃┃┃┃┃┃━┫┗┛┣━━┓┃┃┃┃┃┃┣┓┏┻┓┏┛
-- ┃┃╋┃┃┃┃┗━┫┗┛┣┛┗┛┃┃━╋┓┏┫┗━┛┃┃┗┫┗┛┃┃┃╋┃┃
-- ┗┛╋┗━┻┻━━┻━━┻━━━┻━━┛┗┛┗━━━┛┗━┻━━┛┗┛╋┗┛

-- This is my neovim config rewritten in lua!!

require('plugins')

local g   = vim.g
local o   = vim.o
local opt = vim.opt
local A   = vim.api

-- base config
o.number = true
o.ruler = true
o.mouse = "a"
o.tabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.autoindent = true
o.smartindent = true
o.wrap = false
o.encoding = "UTF-8"
o.visualbell = true
o.updatetime = 300
opt.termguicolors = true
o.showmode = false
o.compatible = false
o.clipboard = 'unnamedplus'
o.splitright = true
o.splitbelow = true

-- set colorscheme
vim.cmd([[colorscheme gruvbox]])

g.mapleader = ' '
--------------------

-- keybindings

local function map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

local builtin = require('telescope.builtin')

map('n', '<leader>fb', builtin.find_files)
map('n', '<leader>ff' , '<CMD>NvimTreeOpen<CR>')

-- vim bufferline scroll through the tabs
map('n', 'm', '<cmd> BufferLineCycleNext <CR>')
map('n', 'n', '<cmd> BufferLineCyclePrev <CR>')
map('n', '<leader>m', '<cmd> BufferLineMoveNext <CR>')
map('n', '<leader>n', '<cmd> BufferLineMovePrev <CR>')

-- no more arrow keys for you
map('n', '<Left>', '')
map('n', '<Right>', '')
map('n', '<Up>', '')
map('n', '<Down>', '')

map('i', '<Left>', '')
map('i', '<Right>', '')
map('i', '<Up>', '')
map('i', '<Down>', '')

map('v', '<Left>', '')
map('v', '<Right>', '')
map('v', '<Up>', '')
map('v', '<Down>', '')

-- terminal
map('n', '<leader>tt', '<cmd> terminal <CR>')

-- legacy 
vim.cmd([[
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
							  ]])

vim.cmd([[autocmd CursorHold * silent call CocActionAsync('highlight')]])
vim.cmd([[inoremap <silent><expr> <c-space> coc#refresh()]])
vim.cmd([[
	function! WinMove(key)
		let t:curwin = winnr()
		exec "wincmd ".a:key
		if (t:curwin == winnr())
			if (match(a:key,'[jk]'))
				wincmd v
			else
				wincmd s
			endif
			exec "wincmd ".a:key
		endif
	endfunction

	nnoremap <silent> <C-h> :call WinMove('h') <CR>
	nnoremap <silent> <C-j> :call WinMove('j') <CR>
	nnoremap <silent> <C-k> :call WinMove('k') <CR>
	nnoremap <silent> <C-l> :call WinMove('l') <CR>
]])
--------------------
-- plugin configuration

-- nvim-tree
require("nvim-tree").setup {
	auto_reload_on_write = true,
	create_in_closed_folder = false,

	diagnostics = {
		enable = true,
	},

}


-- notify
vim.notify = require("notify")

function notify(msg, title)
	vim.notify(msg, nil, {
		title = title,
		render = "simple",
		stages = "fade",
	})
end
