# Neovim Configuration

gbroques' personal Neovim configuration with the following goals and philosophy:

* Configure Neovim with IDE features like Visual Studio Code.
* Stable. Plugins are pinned to specific versions.
* Omit specifying defaults and refer to [`:help`](https://neovim.io/doc/user/helphelp.html) instead.
* Include comments for someone new to Vim / Neovim.
* Explain all mnemonics.
* Efficient.
  * There should not be dupicate mappings for an operation unless the alternative mapping is less keystrokes.
* Fast.
* Minimal.
* Tailored for [Colemak](https://en.wikipedia.org/wiki/Colemak) over [QWERTY](https://en.wikipedia.org/wiki/QWERTY).

## Prerequisites

1. [Neovim](https://neovim.io/) (`nvim`).
2. [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip)
    * Support ligatures and italics.
3. [ripgrep](https://github.com/BurntSushi/ripgrep#installation) (for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim))
4. `make` (for [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation))
5. Install desired language servers. See below sections.

### Java

1. Install Java 17 in the following directory:

       C:/Program Files/Java/jdk-17.0.4.1

2. Save formatter settings at `~/.vscode/formatter.xml`.

3. Install the following projects in a subdirectory within the standard data directory for your operating system:

    1. [eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls#installation) - `language-servers/jdt-language-server`
    2. [java-debug](https://github.com/microsoft/java-debug) - `java-debug`
    3. [vscode-java-test](https://github.com/microsoft/vscode-java-test) - `vscode-java-test`

    | Operating System | Data Directory |
    | ---------------- | -------------- |
    | Linux / MacOS    | `~/.local/share/nvim` |
    | Windows          | `~/AppData/Local/nvim-data` |

    `:help standard-path`

4. Install the tree-sitter Java parser from inside Neovim:

       :TSInstall java

### JavaScript

1. Install TypeScript Language Server:

       npm install -g typescript typescript-language-server

`typescript-language-server` MUST be in the `PATH`.

**Reference:** https://github.com/neovim/nvim-lspconfig/blob/v0.1.6/lua/lspconfig/server_configurations/tsserver.lua#L34

2. Install the tree-sitter JavaScript parser from inside Neovim:

       :TSInstall javascript

3. Setup ESLint for formatting and diagnostics.

`eslint` and `eslint_d` MUST be in the `PATH`.

[`eslint_d`](https://github.com/mantoni/eslint_d.js/) speeds up ESLint and can be installed globally:

    npm install -g eslint_d

An enviroment variable, `ESLINT_CONFIG_PATH`, containing the path to the ESLint configuration file MUST be set.

This is passed to `eslint`'s CLI `--config` option.

### Lua

Install [lua-language-server](https://github.com/luals/lua-language-server/wiki/Getting-Started#command-line).

`lua-language-server` MUST be in the `PATH`.

**Reference:** https://github.com/neovim/nvim-lspconfig/blob/v0.1.6/lua/lspconfig/server_configurations/sumneko_lua.lua#L45

### Tree-sitter

Install the Tree-sitter query parser for [query editor highlighting](https://github.com/nvim-treesitter/playground):

    :TSInstall query

## Setup

Clone to Neovim configuration directory depending on operating system:

| Operating System | Clone Command |
| ---------------- | ------------- |
| Linux / MacOS    | `git clone git@github.com:gbroques/neovim-configuration.git ~/.config/nvim`       |
| Windows          | `git clone git@github.com:gbroques/neovim-configuration.git ~/AppData/Local/nvim` |

`:help config`

## References

Neovim IDE Distributions:

* [LunarVim](https://github.com/LunarVim/LunarVim)
* [AstroNvim](https://github.com/AstroNvim/AstroNvim)
* [NvChad](https://github.com/NvChad/NvChad)
* [LazyVim](https://github.com/LazyVim/LazyVim)

Other sources:

* [Christian Chiarulli](https://www.youtube.com/@chrisatmachine)
* [Neovim from Scratch YouTube Playlist](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
* [Neovim from Scratch GitHub Repository](https://github.com/LunarVim/Neovim-from-scratch)
* [More recent & stable 'Neovim from Scratch' GitHub Repository](https://github.com/LunarVim/nvim-basic-ide)
* [Neovim Lua from Scratch YouTube Playlist](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)

