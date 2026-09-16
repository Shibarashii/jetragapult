return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      opts = {
        -- Replaces all 4 manual listeners below
        auto_toggle = true,
        winbar = {
          controls = { enabled = true },
        },
        -- Inline variable values next to the current line (requires nvim 0.12+)
        virtual_text = {
          enabled = true,
        },
      },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = {
        ensure_installed = { "python", "js" },
        handlers = {},
      },
    },
  },
  keys = {
    { "<F5>",  function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
    { "<F9>",  function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<F10>", function() require("dap").step_over() end,         desc = "Debug: Step Over" },
    { "<F11>", function() require("dap").step_into() end,         desc = "Debug: Step Into" },
    { "<F12>", function() require("dap").step_out() end,          desc = "Debug: Step Out" },
    { "<leader>dt", function() require("dap-view").toggle() end,                                        desc = "Debug: Toggle view" },
    { "<leader>dh", function() require("dap-view").hover() end,   mode = { "n", "v" },                  desc = "Debug: Hover variable" },
    { "<leader>dR", function() require("dap").run_last() end,                                           desc = "Debug: Run last" },
    { "<leader>dq", function() require("dap").terminate() end,                                          desc = "Debug: Terminate" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end,          desc = "Debug: Conditional breakpoint" },
  },
  config = function()
    local dap = require("dap")

    -- Prevents nvim-dap from jumping into a winfixbuf-protected
    -- window (like dap-view's panels) when stepping/hitting a breakpoint.
    -- See dap-view FAQ: "Why is nvim-dap overriding one of the windows..."
    dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab"

    -- ── Signs ─────────────────────────────────────────────────────────────
    -- linehl highlights the entire line the debugger is stopped/breakpoint on.
    -- See :h sign_define() and nvim-dap docs on Signs Configuration.
    vim.fn.sign_define("DapStopped", {
      text = "▶",
      texthl = "DiagnosticWarn",
      linehl = "debugPC",       -- built-in hl group for the current debug line
      numhl = "DiagnosticWarn",
    })
    vim.fn.sign_define("DapBreakpoint", {
      text = "●",
      texthl = "DiagnosticError",
      numhl = "DiagnosticError",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "◆",
      texthl = "DiagnosticWarn",
      numhl = "DiagnosticWarn",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "○",
      texthl = "DiagnosticHint",
      numhl = "DiagnosticHint",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "◉",
      texthl = "DiagnosticInfo",
      numhl = "DiagnosticInfo",
    })
  end,
}
