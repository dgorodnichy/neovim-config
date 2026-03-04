return {
{
  "folke/tokyonight.nvim",
  opts = {
      style = "moon",
      terminal_colors = true,
      comments = { italic = true },
      keywords = { italic = true },
      on_highlights = function(hl, c)
        hl.Visual = {
          bg = c.orange,
          fg = c.bg,
          bold = true,
        }

        hl.VisualNOS = {
          bg = c.orange,
          fg = c.bg,
        }
      end
  },
},
}
