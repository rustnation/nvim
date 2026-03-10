# NeoVIM Configuration

## Project Overview

NeoVIM configuration specialized for Rust and Go development.

## Tech Stack

- NeoVim v0.11.6
- LuaJIT 2.1.1772619647
- Lazy.nvim v11.17.5

## Constraints

- **Git**: Do not run any `git` commands (commit, push, checkout). I handle version control manually.
- **Tools**: Do not install new Neovim plugins without asking first.
- **Deletions**: Never delete `.lua` files; move them to a `backup/` folder instead.
