return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    opts_extend = { "sources.completion.enabled_providers" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      { "saghen/blink.compat", opts = {} },
    },
    event = "InsertEnter",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      windows = {
        autocomplete = {
          draw = "reversed",
        },
        documentation = {
          auto_show = true,
        },
        ghost_text = {
          enabled = true,
        },
      },

      -- experimental auto-brackets support
      accept = { auto_brackets = { enabled = true } },

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } }
      sources = {
        completion = {
          -- remember to enable your providers here
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
      },

      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },

  -- add icons
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.kind_icons = LazyVim.config.icons.kinds
    end,
  },

  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        completion = {
          -- add lazydev to your completion providers
          enabled_providers = { "lazydev" },
        },
        providers = {
          lsp = {
            -- dont show LuaLS require statements when lazydev has items
            fallback_for = { "lazydev" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
    },
  },
}