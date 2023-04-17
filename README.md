# Neovim Configuration

gbroques' personal Neovim configuration with the following goals and philosophy:

* Configure Neovim with IDE features like Visual Studio Code.
* Omit specifying defaults and refer to [`:help`](https://neovim.io/doc/user/helphelp.html) instead.
* Include comments for someone new to Vim / Neovim.
* Explain all mnemonics.
* Tailored for [Colemak](https://en.wikipedia.org/wiki/Colemak) over [QWERTY](https://en.wikipedia.org/wiki/QWERTY).

## Prerequisites

1. [Neovim](https://neovim.io/) (`nvim`).
2. [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip)
3. `make` (for [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation))
4. Install desired language servers. See below sections.

### Java

Install [eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls#installation) in a subdirectory `language-servers/jdt-language-server` within the standard data directory for your operating system.

| Operating System | Data Directory |
| ---------------- | -------------- |
| Linux / MacOS    | `~/.local/share/nvim` |
| Windows          | `~/AppData/Local/nvim` |

`:help standard-path`

`java` version 17 or greater must be in the `PATH`.

### JavaScript

Install TypeScript Language Server:

    npm install -g typescript typescript-language-server

`typescript-language-server` MUST be in the `PATH`.

**Reference:** https://github.com/neovim/nvim-lspconfig/blob/v0.1.6/lua/lspconfig/server_configurations/tsserver.lua#L34

### Lua

Install [lua-language-server](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line).

`lua-language-server` MUST be in the `PATH`.

**Reference:** https://github.com/neovim/nvim-lspconfig/blob/v0.1.6/lua/lspconfig/server_configurations/sumneko_lua.lua#L45

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
* [Neovim Lua from Scratch YouTube Playlist](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)

