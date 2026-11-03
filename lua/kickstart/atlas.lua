-- ============================================================================
-- atlas.nvim — Pull requests & issues inside Neovim
-- ============================================================================
-- Review pull requests and manage issues across GitHub, GitLab, Bitbucket and
-- Jira without leaving the editor. Diff hunks, leave comments/suggestions,
-- approve or merge PRs, and triage issues, all from Neovim.
--
-- REQUIREMENTS
--   * `git` and `curl` on $PATH
--   * GitHub: the `gh` CLI, authenticated once via `gh auth login`
--     (GitHub needs no token in the config — Atlas reuses `gh` auth).
--   * GitLab / Bitbucket / Jira: tokens, set in `providers` below.
--   * Run `:checkhealth atlas` to verify your setup.
--
-- HOW TO USE
--   The `:Atlas` command is the entry point — it shows a command picker:
--
--     :Atlas                        Pick an Atlas command
--     :Atlas review [url|#num|.]    Review a PR in the diff viewer (`.` = current branch's PR)
--     :Atlas pulls [provider|.]     Browse/manage pull requests
--     :Atlas issues [provider|.]    Browse/manage issues
--     :Atlas create pr              Create a PR from the current branch
--     :Atlas search [provider|.]    Search PRs and issues
--     :Atlas open [url|key|#num|.]  Open a PR/issue by URL, Jira key, or number
--
-- KEYBINDINGS
--   Global (defined below):
--     <leader>at   Open the Atlas command picker
--     <leader>ar   Review the current branch's pull request
--     <leader>ap   Open the pull-request dashboard (current repo)
--     <leader>ai   Open the issue dashboard (current repo)
--
--   Inside Atlas buffers (`g?` shows the in-buffer help; see `:help atlas-keymaps`
--   for the full list). Common ones:
--     j/k          Next/previous item          gd   Open a PR diff
--     q            Close                       gc   Checkout a PR branch
--     <Tab>        Next panel                  gx   Open in browser
--     r            Refresh                     ?    Search / filter
--     In the diff viewer: c comment, s suggestion, <leader>ga approve,
--     <leader>gr request changes, <leader>gs submit review, ]c/[c next/prev comment.
--
--   NOTE: `<leader>ar` / `<leader>ap` / `<leader>ai` append `.` so they target
--   the current Git repository's provider automatically.
-- ============================================================================

require("kickstart.plugins").load("atlas")

require("atlas").setup({
	-- GitHub uses the `gh` CLI — no token to configure here.
	-- Uncomment and fill in the others only if you use those providers.
	providers = {
		github = {
			-- hostname = "github.company.com", -- GitHub Enterprise
		},
		-- gitlab = {
		--   base_url = "https://gitlab.com",
		--   token = vim.env.GITLAB_TOKEN, -- PAT with `api` scope
		-- },
		-- bitbucket = {
		--   user = vim.env.BITBUCKET_USER,
		--   token = vim.env.BITBUCKET_TOKEN,
		-- },
		-- jira = {
		--   base_url = "https://your-site.atlassian.net",
		--   email = "you@example.com",
		--   token = "your_jira_api_token",
		--   auth_method = "basic",
		-- },
	},
})

-- Global entry points.
vim.keymap.set("n", "<leader>at", "<cmd>Atlas<CR>", { desc = "Atlas command picker" })
vim.keymap.set("n", "<leader>ar", "<cmd>Atlas review .<CR>", { desc = "Atlas review current PR" })
vim.keymap.set("n", "<leader>ap", "<cmd>Atlas pulls .<CR>", { desc = "Atlas pull requests" })
vim.keymap.set("n", "<leader>ai", "<cmd>Atlas issues .<CR>", { desc = "Atlas issues" })
