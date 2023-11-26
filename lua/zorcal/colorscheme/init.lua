local M = {}

-- :so $VIMRUNTIME/syntax/hitest.vim

local colors = {
  bg = '#ffffdd',
  text = '#202224',
  accent = '#00769c',
  comment = '#808080',
  ok = '#00ffa9',
  error = '#e41b40',
  warning = '#ffba00',
  info = '#00b2ff',
  hint = '#00d6ff',
  add = '#31b61b',
  delete = '#ff2900',
  change = '#0056ff',
  string = 'green',
}

-- https://neovim.io/doc/user/syntax.html#highlight-groups
--- Apply groups highlighting.
local function set_groups()
  local groups = {
    -- Base.
    Normal = { fg = colors.text, bg = colors.bg },
    NormalFloat = { fg = colors.text, bg = colors.bg },
    FloatBorder = { fg = colors.text, bg = colors.bg },
    FloatTitle = { fg = colors.text, bg = colors.bg },
    ColorColumn = { fg = colors.text, bg = colors.bg },
    Cursor = { fg = colors.text, bg = colors.bg },
    lCursor = { fg = colors.text, bg = colors.bg },
    CursorIM = { fg = colors.text, bg = colors.bg },
    CursorColumn = { fg = colors.text, bg = colors.bg },
    CursorLine = { fg = colors.text, bg = colors.bg },
    CursorLineSign = { fg = colors.text, bg = colors.bg },
    CursorLineFold = { fg = colors.text, bg = colors.bg },
    CursorLineNr = { fg = colors.text, bg = colors.bg },
    LineNr = { fg = colors.text, bg = colors.bg },
    Folded = { fg = colors.text, bg = colors.bg },
    FoldColumn = { fg = colors.text, bg = colors.bg },
    SignColumn = { fg = colors.text, bg = colors.bg },
    SpecialKey = { fg = colors.text, bg = colors.bg },
    Directory = { fg = colors.text },
    ModeMsg = { fg = colors.text },
    MoreMsg = { fg = colors.text },
    Question = { fg = colors.text },
    Pmenu = { fg = colors.bg, bg = colors.text },
    PmenuSel = { fg = colors.bg, bg = colors.accent },
    NonText = { fg = colors.accent, bg = colors.bg },
    Visual = { fg = colors.bg, bg = colors.text },
    WarningMsg = { fg = colors.warning },
    MatchParen = { fg = colors.accent, bg = colors.bg },
    qfLineNr = { fg = colors.text },
    qfError = { fg = colors.text },
    Conceal = { fg = colors.text },
    CursorLineConceal = { fg = colors.text },
    RedrawDebugNormal = { fg = colors.text, bg = colors.bg },
    RedrawDebugClear = { fg = colors.text, bg = colors.bg },
    RedrawDebugComposed = { fg = colors.text, bg = colors.bg },
    RedrawDebugRecompose = { fg = colors.text, bg = colors.bg },
    Substitute = { fg = colors.bg, bg = colors.text },

    -- Neovim syntax.
    Constant = { fg = colors.text },
    String = { fg = colors.string },
    Comment = { fg = colors.comment },
    Character = { fg = colors.text },
    Number = { fg = colors.text },
    Boolean = { fg = colors.text },
    Float = { fg = colors.text },
    Identifier = { fg = colors.text },
    Function = { fg = colors.text },
    Statement = { fg = colors.text },
    Conditional = { fg = colors.text },
    Repeat = { fg = colors.text },
    Label = { fg = colors.text },
    Operator = { fg = colors.text },
    Keyword = { fg = colors.text },
    Exception = { fg = colors.text },
    PreProc = { fg = colors.text },
    Include = { fg = colors.text },
    Define = { fg = colors.text },
    Macro = { fg = colors.text },
    PreCondit = { fg = colors.text },
    Type = { fg = colors.text },
    StorageClass = { fg = colors.text },
    Structure = { fg = colors.text },
    Typedef = { fg = colors.text },
    Special = { fg = colors.text },
    SpecialChar = { fg = colors.text },
    Tag = { fg = colors.text },
    Delimiter = { fg = colors.text },
    SpecialComment = { fg = colors.comment },
    Debug = { fg = colors.text },
    Underlined = { fg = colors.text },
    Ignore = { fg = colors.text },
    Error = { fg = colors.error },
    Todo = { fg = colors.comment },

    -- TreeSitter syntax.
    ['@property'] = { fg = colors.text },
    ['@field'] = { fg = colors.text },
    ['@parameter'] = { fg = colors.text },
    ['@namespace'] = { fg = colors.text },
    ['@variable.builtin'] = { fg = colors.text },
    ['@text.title'] = { fg = colors.text },
    ['@type.qualifier'] = { fg = colors.text },
    ['@storageclass'] = { fg = colors.text },
    ['@tag'] = { fg = colors.text },
    ['@tag.attribute'] = { fg = colors.text },
    ['@tag.delimiter'] = { link = 'Delimiter' },
    ['@constant.comment'] = { fg = colors.comment },
    ['@punctuation.bracket.comment'] = { fg = colors.comment },
    ['@variable'] = { fg = colors.text },
    ['@lsp.type.namespace'] = { link = '@namespace' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.class'] = { link = '@type' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.interface'] = { link = '@type' },
    ['@lsp.type.struct'] = { link = '@structure' },
    ['@lsp.type.parameter'] = { fg = colors.lsp_parameter },
    ['@lsp.type.field'] = { link = '@field' },
    ['@lsp.type.variable'] = { link = '@variable' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.function'] = { link = '@function' },
    ['@lsp.type.method'] = { link = '@method' },
    ['@lsp.type.macro'] = { link = '@macro' },
    ['@lsp.type.decorator'] = { link = '@function' },
    ['@lsp.mod.constant'] = { link = '@constant' },

    -- LSP.
    DiagnosticOk = { fg = colors.ok },
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticUnderlineOk = { fg = colors.ok },
    DiagnosticUnderlineError = { fg = colors.error, underline = true },
    DiagnosticUnderlineWarn = { fg = colors.warning, underline = true },
    DiagnosticUnderlineInfo = { fg = colors.info, underline = true },
    DiagnosticUnderlineHint = { fg = colors.hint, underline = true },

    -- Git.
    DiffText = { fg = colors.text },
    DiffAdd = { fg = colors.add },
    DiffChange = { fg = colors.change },
    DiffDelete = { fg = colors.delete },
    GitSignsAdd = { fg = colors.add },
    GitSignsAddLn = { fg = colors.add },
    GitSignsAddPreview = { fg = colors.add },
    GitSignsStagedAdd = { fg = colors.add },
    GitSignsStagedAddNr = { fg = colors.add },
    GitSignsStagedAddLn = { fg = colors.add },
    GitSignsChange = { fg = colors.change },
    GitSignsChangeLn = { fg = colors.change },
    GitSignsStagedChange = { fg = colors.change },
    GitSignsStagedChangeLn = { fg = colors.change },
    GitSignsStagedChangeNr = { fg = colors.change },
    GitSignsStagedChangedelete = { fg = colors.change },
    GitSignsStagedChangedeleteLn = { fg = colors.change },
    GitSignsStagedChangedeleteNr = { fg = colors.change },
    GitSignsDelete = { fg = colors.delete },
    GitSignsDeleteVirtLn = { fg = colors.delete },
    GitSignsDeletePreview = { fg = colors.delete },
    GitSignsStagedDelete = { fg = colors.delete },
    GitSignsStagedDeleteNr = { fg = colors.delete },
    GitSignsStagedTopdelete = { fg = colors.delete },
    GitSignsStagedTopdeleteNr = { fg = colors.delete },

    -- Completion.
    CmpItemAbbr = { fg = colors.bg, bg = colors.text },
    CmpItemMenu = { fg = colors.bg, bg = colors.text },
    CmpItemKind = { fg = colors.bg, bg = colors.text },
    CmpItemAbbrDefault = { fg = colors.bg, bg = colors.text },
    CmpItemMenuDefault = { fg = colors.bg, bg = colors.text },
    CmpItemKindDefault = { fg = colors.bg, bg = colors.text },

    -- Telescope.
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/plugin/telescope.lua
    TelescopeMatching = { default = true, fg = colors.accent },
  }

  for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
  end
end

function M.setup()
  vim.api.nvim_command 'hi clear'
  if vim.fn.exists 'syntax_on' then
    vim.api.nvim_command 'syntax reset'
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'zorcal'

  set_groups()
end

return M
