local wk = require("which-key")
local ts_builtin = require("telescope.builtin")
local gs = require("gitsigns")
local harpoon = require("harpoon")
local conform = require("conform")

local function cat_table(x1, x2)
    local tmp = {}
    for k, v in pairs(x1) do
            tmp[k] = v
    end
    for k, v in pairs(x2) do
            tmp[k] = v
    end
    return tmp
end

local custom_diff = function()
    if vim.wo.diff then
        local buffers = vim.api.nvim_list_bufs()
        for _, bufnr in ipairs(buffers) do
            -- Check if the buffer name starts with 'gitsigns:/'
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("^gitsigns:/") then
                vim.api.nvim_buf_delete(bufnr, { force = true })
            end
        end
    else
        gs.diffthis()
    end
end

local oil_custom = function()
    local buffers = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("^oil:/") then
            vim.api.nvim_buf_delete(bufnr, { force = true })
                return
        end
    end
    vim.cmd("Oil")
end

vim.g.mapleader = " "

-- Regster categories in which_key
wk.register({
        f = { name = "File" },
        b = { name = "Buffer" },
        g = { name = "Git" },
        h = { name = "Help/Misc" },
        m = { name = "Marks" },
        TAB = { name = "Tabs" },
}, { prefix = "<leader>" })

-- Generic
vim.keymap.set({ "i", "n" }, "<Esc>", "<Esc>:nohls<CR>", { silent = true })

--Files specific
vim.keymap.set("n", "<leader>ff", ts_builtin.fd, { desc = "Find file" })
vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep, { desc = "Grep in file" })
vim.keymap.set({ "n", "v" }, "=", function()
        conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, { desc = "Format file" })
vim.keymap.set("n", "<leader>fe", oil_custom, { desc = "Open file explorer" })

-- Buffers
vim.keymap.set("n", "<leader>,", ts_builtin.buffers, { desc = "Buffer Switch" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { silent = true, desc = "Buffer Next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { silent = true, desc = "Buffer Previous" })
vim.keymap.set("n", "<leader>bk", "<cmd>bd<CR>", { silent = true, desc = "Buffer Kill" })

-- Tabs
vim.keymap.set("n", "<leader><TAB>+", "<cmd>tabnew<CR>", { silent = true, desc = "Tab New" })
vim.keymap.set("n", "<leader><TAB>n", "<cmd>tabnext<CR>", { silent = true, desc = "Tab Next" })
vim.keymap.set("n", "<leader><TAB>p", "<cmd>tabprevious<CR>", { silent = true, desc = "Tab Previous" })
vim.keymap.set("n", "<leader><TAB>c", "<cmd>tabclose<CR>", { silent = true, desc = "Tab Close" })

-- Help/Misc
vim.keymap.set("n", "<leader>hl", ts_builtin.help_tags, { desc = "Help entries" })
vim.keymap.set("n", "<leader>ht", ts_builtin.colorscheme, { desc = "Change colorscheme" })
vim.keymap.set("n", "<leader>hk", ts_builtin.keymaps, { desc = "Show keybindings" })
vim.keymap.set("n", "<leader>hm", ts_builtin.man_pages, { desc = "Show Manpages" })
vim.keymap.set("n", "<leader>hrr", "<cmd>so $HOME/.config/nvim/init.lua<cr>", { desc = "Reload Config" })
vim.keymap.set("n", "<leader>hp", "<cmd>Lazy<cr>", { desc = "Plugin Manager" })

-- Git
vim.keymap.set("n", "<leader>gf", ts_builtin.git_files, { desc = "Find file in repo" })
vim.keymap.set("n", "<leader>gB", ts_builtin.git_branches, { desc = "Branches" })
vim.keymap.set("n", "<leader>gs", ts_builtin.git_status, { desc = "Status" })
vim.keymap.set("n", "<leader>gcr", ts_builtin.git_commits, { desc = "Commit history" })
vim.keymap.set("n", "<leader>gcb", ts_builtin.git_bcommits, { desc = "File's commit history" })
vim.keymap.set("n", "<leader>gd", custom_diff, { desc = "Diff file" })
vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
end, { desc = "Line blame" })

-- Marks
vim.keymap.set("n", "<leader>ml", ts_builtin.marks, { desc = "Mark list" })

-- later..
vim.keymap.set("n", "<leader>z=", ts_builtin.spell_suggest, { desc = "Spell suggestions" })

-- Harpoon
vim.keymap.set("n", "<leader>ba", function()
        harpoon:list():add()
end, { desc = "Append to harpoon list" })
vim.keymap.set("n", "<leader><", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle harpoon list" })

vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
end, { desc = "Go to harpoon buffer 1" })
vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
end, { desc = "Go to harpoon buffer 2" })
vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
end, { desc = "Go to harpoon buffer 3" })
vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
end, { desc = "Go to harpoon buffer 4" })
vim.keymap.set("n", "<leader>5", function()
        harpoon:list():select(5)
end, { desc = "Go to harpoon buffer 5" })
