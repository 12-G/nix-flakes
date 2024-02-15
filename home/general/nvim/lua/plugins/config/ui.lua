local ui = {}

ui.catppuccin = {
  flavour = "frappe",
  background = {
    dark = "frappe"
  },
  integrations = {
    lsp_saga = true,
    mason = true,
    neotree = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
  },
}

ui.treesitter = {
  ensure_installed = {
    "lua",
    "python",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },

}

ui.devicons = {
  override = {
    default_icon = {
      icon = "󰈚",
      name = "Default",
    },

    c = {
      icon = "",
      name = "c",
    },

    css = {
      icon = "",
      name = "css",
    },

    dart = {
      icon = "",
      name = "dart",
    },

    deb = {
      icon = "",
      name = "deb",
    },

    Dockerfile = {
      icon = "",
      name = "Dockerfile",
    },

    html = {
      icon = "",
      name = "html",
    },

    jpeg = {
      icon = "󰉏",
      name = "jpeg",
    },

    jpg = {
      icon = "󰉏",
      name = "jpg",
    },

    js = {
      icon = "󰌞",
      name = "js",
    },

    kt = {
      icon = "󱈙",
      name = "kt",
    },

    lock = {
      icon = "󰌾",
      name = "lock",
    },

    lua = {
      icon = "",
      name = "lua",
    },

    mp3 = {
      icon = "󰎆",
      name = "mp3",
    },

    mp4 = {
      icon = "",
      name = "mp4",
    },

    out = {
      icon = "",
      name = "out",
    },

    png = {
      icon = "󰉏",
      name = "png",
    },

    py = {
      icon = "",
      name = "py",
    },

    ["robots.txt"] = {
      icon = "󰚩",
      name = "robots",
    },

    toml = {
      icon = "",
      name = "toml",
    },

    ts = {
      icon = "󰛦",
      name = "ts",
    },

    ttf = {
      icon = "",
      name = "TrueTypeFont",
    },

    rb = {
      icon = "",
      name = "rb",
    },

    rpm = {
      icon = "",
      name = "rpm",
    },

    vue = {
      icon = "󰡄",
      name = "vue",
    },

    woff = {
      icon = "",
      name = "WebOpenFontFormat",
    },

    woff2 = {
      icon = "",
      name = "WebOpenFontFormat2",
    },

    xz = {
      icon = "",
      name = "xz",
    },

    zip = {
      icon = "",
      name = "zip",
    },
  },
}

return ui
