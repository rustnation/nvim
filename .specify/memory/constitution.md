<!--
SYNC IMPACT REPORT
==================
Version change: [TEMPLATE] → 1.0.0 (initial ratification — all placeholders replaced)

Modified principles:
  [PRINCIPLE_1_NAME] → I. Lua-First Configuration
  [PRINCIPLE_2_NAME] → II. Plugin Economy
  [PRINCIPLE_3_NAME] → III. Language Optimization for Rust & Go
  [PRINCIPLE_4_NAME] → IV. Preservation Over Deletion
  [PRINCIPLE_5_NAME] → V. Simplicity & Focused Changes

Added sections:
  - Tech Stack Constraints (replaces generic [SECTION_2_NAME])
  - Development Workflow (replaces generic [SECTION_3_NAME])

Removed sections:
  - None (all template sections retained with concrete content)

Templates requiring updates:
  ✅ .specify/memory/constitution.md — this file (written now)
  ✅ .specify/templates/plan-template.md — Constitution Check section references
     "gates determined based on constitution file"; dynamically filled per feature,
     no structural change needed
  ✅ .specify/templates/spec-template.md — no principle-driven mandatory sections
     added or removed; compatible as-is
  ✅ .specify/templates/tasks-template.md — task categories (Setup, Foundational,
     User Stories, Polish) align with Principle V (Simplicity); no changes needed
  ✅ .specify/init-options.json — informational only, no updates needed

Deferred TODOs:
  - None. All fields resolved from project context.
-->

# NeoVIM Configuration Constitution

## Core Principles

### I. Lua-First Configuration

All configuration MUST be written in Lua. Vimscript is permitted only when a
third-party plugin's API requires it and no Lua alternative exists. New
configuration files MUST use the `.lua` extension and follow idiomatic NeoVIM
Lua conventions (e.g., `vim.keymap.set`, `vim.api.*`).

**Rationale**: NeoVIM v0.11+ treats Lua as the primary configuration language.
Lua-first ensures consistency, performance, and long-term maintainability across
the configuration.

### II. Plugin Economy

New Neovim plugins MUST NOT be installed without explicit user approval. Before
proposing a plugin, prefer leveraging built-in NeoVIM capabilities or existing
Lazy.nvim-managed plugins. Each proposed addition MUST include a clear
justification of the gap it fills.

**Rationale**: Plugin sprawl increases startup time, maintenance burden, and
conflict risk. Every dependency is a liability; the bar for new plugins is high.

### III. Language Optimization for Rust & Go

Configuration changes affecting LSP, formatting, linting, debugging, or test
runners MUST preserve correct behavior for both Rust (rust-analyzer, cargo) and
Go (gopls, go test). A change that improves one language MUST NOT regress the
other. Both languages are first-class citizens of this configuration.

**Rationale**: The sole purpose of this configuration is Rust and Go development
ergonomics. Regressions in either language undermine the configuration's core
value.

### IV. Preservation Over Deletion

Lua files MUST NEVER be deleted from the repository. Deprecated or replaced
`.lua` files MUST be moved to a `backup/` folder instead of removed. Destructive
filesystem operations targeting `.lua` configuration files are prohibited.

**Rationale**: Lua configuration files encode accumulated knowledge and effort.
Accidental deletions are difficult to recover; the backup pattern guarantees
reversibility and historical reference.

### V. Simplicity & Focused Changes

Changes MUST be minimal and targeted — only what is directly requested or clearly
necessary to fulfil the request. Adding unrequested features, refactoring
surrounding code, introducing unnecessary abstractions, or adding boilerplate
(comments, type annotations, docstrings) to unmodified code is prohibited.

**Rationale**: Editor configuration must remain stable and predictable. Scope
creep causes regressions, erodes trust, and makes the configuration harder to
reason about over time.

## Tech Stack Constraints

- **NeoVim**: v0.11.6 — MUST be the runtime target; APIs unavailable before this
  version MUST NOT be used as fallbacks.
- **LuaJIT**: 2.1.x — Lua 5.1-compatible syntax MUST be used throughout;
  LuaJIT-specific extensions MAY be used only when clearly documented.
- **Lazy.nvim**: v11.x — all plugin management MUST go through Lazy.nvim;
  alternative plugin managers MUST NOT be introduced.
- **Primary languages**: Rust (rust-analyzer, cargo) and Go (gopls, go test) are
  the only language toolchains with first-class support obligations.

## Development Workflow

- **Version Control**: The user manages all git operations. Agents MUST NOT run
  `git commit`, `git push`, `git checkout`, `git reset`, or any other git
  command that modifies repository state.
- **Plugin Changes**: Propose any plugin addition with a clear justification and
  await explicit user approval before modifying plugin specs or `lazy.lua`.
- **File Safety**: Before editing any `.lua` file, read its current contents in
  full. Never overwrite without understanding the existing state.
- **Validation**: After making changes to LSP, keybindings, or tooling
  integration, confirm that both Rust and Go workflows remain intact before
  considering a task complete.

## Governance

This constitution supersedes all informal practices and agent default behaviors.
Amendments require:

1. A clear rationale for the change.
2. A version increment per semantic versioning rules:
   - **MAJOR**: Backward-incompatible governance change, principle removal, or
     principle redefinition that invalidates prior interpretations.
   - **MINOR**: New principle or section added, or existing principle materially
     expanded with new obligations.
   - **PATCH**: Clarifications, wording improvements, or non-semantic refinements
     that do not change the obligations.
3. A Sync Impact Report (HTML comment at top of file) listing all changes and
   template update statuses.
4. Propagation of any structural changes to dependent templates
   (plan-template.md, spec-template.md, tasks-template.md).

All feature plans MUST include a Constitution Check gate (verified against this
file) before implementation begins. Any violation of a principle MUST be
justified in the plan's Complexity Tracking table before work proceeds.

**Version**: 1.0.0 | **Ratified**: 2026-03-24 | **Last Amended**: 2026-03-24
