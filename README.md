# Mattern

Custom Line Marks based on Pattern matching

![Screenshot](https://github.com/domsch1988/mattern.nvim/assets/1961154/c46ec6d9-3605-43b5-a4c2-021e5f5b3f31)

## 📦 Installation

Install the plugin with your preferred package manager:

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
return {
    'domsch1988/mattern.nvim',
    config = function()
        require('mattern').setup({
            markers = {
                { 'asgard:', 'Matched ASGARD', "@comment.error", "yaml" },
            }
        })
    end
}
```

### Setup

Mattern comes with the following defaults:

```lua
{
    position = "eol",   -- Where the marks should be displayed: "eol", "overlay", "right_align", "inline"
    hl_mode = "blend",  -- How the Highlightgroup should be applied: "replace", "combine", "blend"
    markers = {         -- A list of your Rules
        -- Our Custom Marker Definitions
        -- | Pattern      | Text to Write   | HL Group        | Optional Filetype |
        { 'mattern', 'A default for Testing', "@comment.error", "lua" },
    }
}
```

## 🚀 Usage

Mattern sets up a Autocommand for BufEnter and BufWinEnter by default.
The function `require('mattern').mattern_print()` can be used to set up your own Autocommands or Keybinds
