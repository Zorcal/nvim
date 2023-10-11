return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('nvim-dap-virtual-text').setup {
      enabled = true,

      -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
      enabled_commands = false,

      -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_changed_variables = true,
      highlight_new_as_changed = true,

      -- prefix virtual text with comment string
      commented = false,

      show_stop_reason = true,

      -- experimental features:
      virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    }

    require('mason-nvim-dap').setup {
      automatic_installation = true,

      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug (from vscode-go)',
        request = 'launch',
        showLog = false,
        program = '${file}',
        dlvToolPath = vim.fn.exepath 'dlv', -- Adjust to where delve is installed
      },
      {
        type = 'go',
        name = 'Debug (No File)',
        request = 'launch',
        program = '',
      },
      {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
        showLog = true,
        -- console = "externalTerminal",
        -- dlvToolPath = vim.fn.exepath "dlv",
      },
      {
        type = 'go',
        name = 'Debug test',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
      },
      {
        name = 'Test Current File',
        type = 'go',
        request = 'launch',
        showLog = true,
        mode = 'test',
        program = '.',
        dlvToolPath = vim.fn.exepath 'dlv',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>B', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Install golang specific config.
    require('dap-go').setup()
  end,
}
