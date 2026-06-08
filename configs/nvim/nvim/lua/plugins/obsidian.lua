return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Obsidian_Directory",
        path = "/home/manish/Obsidian",
      },
      -- {
      --   name = "React_Couse",
      --   path = "/home/manish/Obsidian_React_Course",
      -- },
      -- {
      --   name = "Docker_course",
      --   path = "/home/manish/Obsidian_Docker_Course/",
      -- },
      {
        name = "Kubernetes_course",
        path = "/home/manish/Obsidian/Obsidian_Kubernetes_Course",
      },
      {
        name = "Python_Course",
        path = "/home/manish/Obsidian/Obsidian_Python_Course",
      },
      {
        name = "Git_Course",
        path = "/home/manish/Obsidian/Obsidian_GitCourse",
      },
    },
    attachments = {
      img_folder = "assets/imgs",
      img_name_func = function()
        return string.format("%s-", os.time())
      end,


      img_text_func = function(_, path)
        return string.format("\n![[../assets/imgs/%s]]\n", path.filename:match("[^/]+$"))
      end


    },
    ui = {
      enable = true,          -- set to false to disable all additional syntax features
      update_debounce = 200,  -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
        -- Replace the above with this if you don't have a patched font:
        -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

        -- You can also add more custom ones...
      },
      -- Use bullet marks for non-checkbox lists.
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
  },
  config = function(_, opts)
  require("obsidian").setup(opts)

  -- 🧠 Keymap for pasting clipboard image into correct vault
  vim.keymap.set("n", "<leader>op", function()
    local current_file = vim.fn.expand("%:p")

    -- Prompt for image name
    local img_name = vim.fn.input("📸 Enter image name (without extension): ")
    if img_name == "" then
      vim.notify("❌ Cancelled: No image name provided", vim.log.levels.WARN)
      return
    end

    -- Run your clipboard-to-file script
    local img_path = vim.fn.system(
      string.format("~/.local/bin/paste_img_from_clipboard.sh %s %s",
        vim.fn.shellescape(current_file),
        vim.fn.shellescape(img_name)
      )
    ):gsub("\n", "")

    if vim.v.shell_error ~= 0 or img_path == "" then
      vim.notify("❌ No image in clipboard or failed to save image", vim.log.levels.ERROR)
      return
    end

    -- Get vault-relative path (everything after /Obsidian/<vault>/)
    local rel_path = img_path:match(".*/Obsidian/[^/]+/(.*)")
    if rel_path and not rel_path:match("^%.%.") then
      rel_path = "../" .. rel_path
    end
    if not rel_path then rel_path = img_path end

    -- Insert link
    vim.api.nvim_put({ string.format("![[%s]]", rel_path) }, "l", true, true)
    vim.notify("✅ Image pasted as: " .. rel_path)
  end, { desc = "Paste clipboard image into correct Obsidian vault" })
end,
}
