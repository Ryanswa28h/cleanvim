# CleanVim

> [!NOTE]
> CleanVim is **NOT** a Neovim distribution, it is a configuration, that means it won't get auto updated and it is yours to improve.

CleanVim is a simple, minimal Neovim configuration.

Based of the [botak.nvim](https://github.com/Ryanswa28h/botak.nvim) config. With modifications to make it lighter and more minimal.

---

# Differences with [botak.nvim](https://github.com/Ryanswa28h/botak.nvim)

Current differences are:

- Replaced bufferline with mini.tabline
- Replaced lualine with mini.statusline
- Disabled satellite.nvim
- Disabled noice.nvim
- Disabled catpuccin.nvim

---

# 📋 Requirements

Before installing, ensure your system has the required core utilities and external dependencies installed.

### 1. Core Runtime (Required)

- **Neovim >= 0.10.0** (Built with LuaJIT)
- **Git** (For plugin management via `lazy.nvim`)
- **Curl** (For downloading LSP servers, linters, and Mason binaries)

### 2. External System Dependencies (Highly Recommended)

These binaries must be accessible in your system's `$PATH` for the respective plugins to function:

| Dependency                 | Required By                           | Purpose                                                  |
| :------------------------- | :------------------------------------ | :------------------------------------------------------- |
| `ripgrep` (`rg`)           | `fzf-lua`, `snacks.nvim`, `telescope` | Lightning-fast global text searching                     |
| `fzf`                      | `fzf-lua`                             | Command-line fuzzy finder engine                         |
| `fd`                       | `fzf-lua`, `snacks.nvim`              | Fast alternative to `find` for locating files            |
| `Node.js` (`node` & `npm`) | `mason.nvim`, `copilot.lua`           | Runtime for Copilot and various LSP/formatters           |
| `Python3` & `pip`          | `nvim-dap-python`                     | Debugging runtime and environment management             |
| Treesitter CLI             | `nvim-treesitter`                     | Installation of treesitter parsers                       |
| `unzip` / `tar` / `gzip`   | `mason.nvim`                          | Decompressing downloaded language servers                |
| `xclip` / `wl-clipboard`   | Neovim System Clipboard               | Syncing Vim registers with system clipboard (Linux only) |

DAP (Debug Adapter Protocol) dependencies:

| Dependency                 | Required By                           | Purpose                                               |
| :------------------------- | :------------------------------------ | :---------------------------------------------------- |
| `node`                     | `pwa-node` adapter (js-debug-adapter) | Runs the JS debug server process                      |
| `python3`                  | `nvim-dap-python`                     | Executes debugpy for Python debugging                 |
| `debugpy`                  | `nvim-dap-python`                     | Python debug adapter (`python3 -m debugpy` must work) |
| `cpptools` (mason)         | `dap.configurations.cpp`              | C/C++ debug adapter installed via mason               |
| `js-debug-adapter` (mason) | `pwa-node` adapter                    | JS/TS debug adapter server installed via mason        |

### 3. Advanced / AI Plugin Dependencies

Because this config leverages cutting-edge AI utilities (`avante.nvim`), you must install these compilation tools:

- **`make`** or **`cmake`** (Required to compile `avante.nvim` native code)
- **A C Compiler** (`gcc` or `clang`)
- **`luarocks`** (To manage Lua dependencies for Avante)
- **`xclip` / `wl-clipboard` / `pbcopy`** (Required by `img-clip.nvim` to grab screenshots into your Markdown notes)

---

### 📦 Quick Installation Commands

Choose the command for your operating system to fetch all dependencies at once:

For the Treesitter CLI, [TS CLI Install Guide](https://tree-sitter.github.io/tree-sitter/creating-parsers/1-getting-started.html)

#### MacOS (Homebrew)

```bash
brew install neovim git curl ripgrep fzf fd nodejs luarocks cmake
```

#### Linux

```bash
sudo apt update && sudo apt install -y neovim git curl ripgrep fzf fd-find nodejs luarocks cmake build-essential xclip # debian/ubuntu
sudo pacman -S neovim git curl ripgrep fzf fd nodejs luarocks cmake base-devel xclip # archlinux
```

#### Windows (Native)

For winget installation, run this command inside **PowerShell** (as Administrator):

```powershell
winget install -e --id Neovim.Neovim
winget install -e --id Git.Git
winget install -e --id BurntSushi.Ripgrep
winget install -e --id sharkdp.fd
winget install -e --id junegunn.fzf
winget install -e --id OpenJS.NodeJS
winget install -e --id LLVM.LLVM
winget install -e --id CMake.CMake
pip install luarocks
```

or Chocolatey:

```powershell
choco install neovim git ripgrep fd fzf nodejs luarocks cmake llvm -y
```

> [!NOTE]
>
> 1. **The C Compiler (`LLVM` / `gcc`)**: Because `avante.nvim` requires compiling native code, Windows users _must_ have a compiler in their system environment. Installing `LLVM` (which includes `clang`) or installing MinGW via `choco install mingw -y` ensures that `make` and compilation blocks won't crash during the lazy-load setup.
> 2. **Path Refresh**: Remind your users that after running these setup commands on Windows, they **must close and restart their terminal** for the newly installed tools to register in their environment `$PATH`.

---

# 📝 License

This configuration is open-source under the **MIT License**.

Copyright (c) 2025 Ryan Alvaro Emmyson
