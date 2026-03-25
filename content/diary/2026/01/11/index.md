---
title: Kitty scrollback intregated with Neovim
date: 2025-12-05T13:54:14+08:00
lastmod: 2026-03-21T00:58:07+08:00
comments: true
---

Features: https://github.com/mikesmithgh/kitty-scrollback.nvim?tab=readme-ov-file#-features

- `<C-S-h>`: scrollback
- `<C-S-g>`: output of last command
- `<C-S><Rightclick>`: output of selected command
- `<C-x><C-e>`: content of current kitty commandline


Sub-mappings:

- `<S-CR>`: Quit Neovim and send visual selection to kitty directly
- `<C-CR>`: Quit Neovim, send and execute visual selection to kitty directly
- Copy (`y`) or `i` / `a`: Edit content or start with a empty window
  `<S-CR>` and `<C-CR>` are also available in this window

