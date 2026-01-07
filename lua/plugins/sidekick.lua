return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = {
    cli = {
      mux = {
        enabled = true,
        backend = "tmux",
      },
    },
  },
  keys = {
    { "<C-.>", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI", mode = { "n", "t", "i", "x" } },
    { "<leader>ac", function() require("sidekick.cli").toggle() end, desc = "Toggle AI CLI" },
    { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select AI Tool" },
    { "<leader>ax", function() require("sidekick.cli").close() end, desc = "Close AI Session" },
    { "<leader>ap", function() require("sidekick.cli").prompt() end, desc = "AI Prompts", mode = { "n", "x" } },
    { "<leader>ae", function() require("sidekick.cli").send({ msg = "Explain {this}" }) end, desc = "AI Explain", mode = { "n", "x" } },
    { "<leader>ar", function() require("sidekick.cli").send({ msg = "Review {file}" }) end, desc = "AI Review File" },
    { "<leader>af", function() require("sidekick.cli").send({ msg = "Fix {this}" }) end, desc = "AI Fix", mode = { "n", "x" } },
    { "<leader>at", function() require("sidekick.cli").send({ msg = "Write tests for {this}" }) end, desc = "AI Write Tests", mode = { "n", "x" } },
    { "<leader>ad", function() require("sidekick.cli").send({ msg = "Add documentation to {this}" }) end, desc = "AI Document", mode = { "n", "x" } },
    { "<leader>ao", function() require("sidekick.cli").send({ msg = "Optimize {this}" }) end, desc = "AI Optimize", mode = { "n", "x" } },
    { "<leader>ak", function() require("sidekick.nes").clear() end, desc = "Clear NES" },
    {
      "<Tab>",
      function()
        if require("sidekick").nes_jump_or_apply() then
          return
        end
        return "<Tab>"
      end,
      mode = "n",
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
  },
}
