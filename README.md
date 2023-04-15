# Neovim Configuration

gbroques' personal Neovim configuration with the following goals and philosophy:

* Configure Neovim with IDE features like Visual Studio Code.
* Omit specifying defaults and refer to help instead.
* Include comments for someone new to Vim / Neovim.
* Explain all mnemonics.

## Prerequisites

1. [Neovim](https://neovim.io/) (`nvim`).
2. [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip)
3. `make` (for [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation))

### Java

* Install [eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls#installation) at `~/jdt-language-server`.
* `java` version 17 or greater must be in the `PATH`.


## Setup

Clone to Neovim configuration directory depending on operating system:

| Operating System | Clone Command |
| ---------------- | ------------- |
| Linux / MacOS    | `git clone git@github.com:gbroques/neovim-configuration.git ~/.config/nvim`       |
| Windows          | `git clone git@github.com:gbroques/neovim-configuration.git ~/AppData/Local/nvim` |

`:help config`

## References

* [Christian Chiarulli](https://www.youtube.com/@chrisatmachine)
* [Neovim from Scratch YouTube Playlist](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
* [Neovim from Scratch GitHub Repository](https://github.com/LunarVim/Neovim-from-scratch)
* [More recent & stable 'Neovim from Scratch' GitHub Repository](https://github.com/LunarVim/nvim-basic-ide)
* [LunarVim](https://github.com/LunarVim/LunarVim)

