# Jobber.nvim

Very simple plugin for neovim which lets you define different command groups, each of which gets run in its own terminal split in a new window when called

## Installation

With `lazy.nvim`:
```lua
{
    "mr55p-dev/jobber.nvim",
    dependencies = { "pianocomposer321/consolation.nvim" }
}
```

## Configuration
```lua
require('jobber').setup{
    layouts = {
        ["Layout 1"] = { "cmd 1...", "cmd 2..." },
        ["Layout 2"] = { "cmd 1...", "cmd 2...", "cmd 3..." },
    }
}
```

You can define as many commands as you like, and call each group whatever you like. All commands are executed with the default shell from the current working directory.

## Usage

We register two commands:
- `Jobber`: opens a layout picker and once a selection is made, launches that layout in a new window
- `JobberKill`: broken command which should close all the terminals, but currently does not

## Todo

- Improve the `JobberKill` command (currently incorrect buffer numbers are stored by the terminal wrapper)
- Introduce some kind of loading state so nobody thinks nvim is hanging
- Create all the terminals before passing command input 
    - All terminals are created basically using `:term cmd` which doesn't work for certain very io heavy commands (looking at you `yes`)
    - Creating all the pty's and then sending the commands to them would prevent this from being an issue.

