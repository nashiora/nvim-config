-- set up plugins with Lazy

-- see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim';
if (not vim.loop.fs_stat(lazy_path)) then
    local lazy_repo = 'https://github.com/folke/lazy.nvim.git';
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazy_repo, lazy_path };
end

vim.opt.rtp:prepend(lazy_path);

-- to check the current status of plugins, run
--   :Lazy
--
-- you can press `?` in this menu for help
-- use `:q` to close the window
--
-- to update plugins, you can run
--   :Lazy update

local lazy = require 'lazy';

lazy.setup({
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- see `:help gitsigns` to understand what the config keys do
    -- adds git related signs to the gutter, as well as utils for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                change = { text = '‾' },
                changedelete = { text = '~' },
            }
        }
    },

    -- useful plugin to show pending keybinds
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            local which_key = require 'which-key';
            which_key.setup();
            -- document existing key chains (what)
            which_key.register {
                ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
                ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
                ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
                ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
            };
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1;
                end,
            },
            'nvim-telescope/telescope-ui-select.nvim',
            -- enable if we have nerd font or a terminal with fallback?
            -- 'nvim-tree/nvim-web-devicons'
        },
        config = function()
            local telescope = require 'telescope';
            telescope.setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    }
                }
            };

            pcall(telescope.load_extension, 'fzf');
            pcall(telescope.load_extension, 'ui-select');

            local builtin = require 'telescope.builtin';
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' });
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' });
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' });
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]elect Telescope' });
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' });
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' });
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' });
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' });
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' });
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' });

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                });
            end, { desc = '[/] Fuzzily search in current buffer' });

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files';
                };
            end, { desc = '[S]earch [/] in Open Files' });

            vim.keymap.set('n', '<leader>sn', function()
                builtin.file_files { cwd = vim.fn.stdpath 'config' };
            end, { desc = '[S]earch [N]eovim files' });
        end,
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
        end,
    },

    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'tokyonight-night';
            vim.cmd.hi 'Comment gui=none';
        end,
    },

    { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    { 'xiyaowong/transparent.nvim', opts = {} },
}, {});

