-- set vim.opt values

-- <space> should be leader
-- do this before plugins
-- see `:help mapleader`
vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

-- enable line numbers by default
-- optionally, have them be relative to ease jump commands
vim.opt.number = true;
vim.opt.relativenumber = true;

-- tabs n shit
vim.opt.tabstop = 4;
vim.opt.expandtab = true;
vim.opt.softtabstop = 4;
vim.opt.shiftwidth = 4;

-- sometimes the mouse is still useful, enable that shit
vim.opt.mouse = 'a'; -- `a` as in `all modes`

-- don't show mode, it's already in the status line
vim.opt.showmode = false; -- where does this apply?

-- enable sharing clipboard with the os
-- see `:help clipboard`
vim.opt.clipboard = 'unnamedplus';

-- enable break indent
-- wtf is this
vim.opt.breakindent = true;

-- save undo history (to a file i assume)
vim.opt.undofile = true;

-- case insensitive searching
-- (unless \C or capital in search) (not sure 100% if I understand that, check it)
vim.opt.ignorecase = true;
vim.opt.smartcase = true;

-- what is signcolumn
-- i guess it's on by default
vim.opt.signcolumn = 'yes';

-- decrease update time
-- update time for what?
vim.opt.updatetime = 250;
vim.opt.timeoutlen = 300;

-- configure how new splits should be opened
-- but how, what does this mean?
vim.opt.splitright = true;
vim.opt.splitbelow = true;

-- configure rendering of whitespace for certain characters
vim.opt.list = true; -- very strange name I think
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' };

-- preview substitutions live, as you type
-- I assume this is fine/replace and similar?
vim.opt.inccommand = 'split';

-- minimum number of lines above and below the cursor at all times
vim.opt.scrolloff = 10;

-- set highlight on search
vim.opt.hlsearch = true;

