---
title: Kitty scrollback intregated with Neovim
date: 2025-12-05T13:54:14+08:00
comments: true
math: false
---

Features: https://github.com/mikesmithgh/kitty-scrollback.nvim?tab=readme-ov-file#-features

- <kbd><C-S-h></kbd>: scrollback
- <kbd><C-S-g></kbd>: output of last command
- <kbd><C-S><Rightclick></kbd>: output of selected command
- <kbd><C-x><C-e></kbd>: content of current kitty commandline


Sub-mappings:

- <kbd><S-CR></kbd>: Quit Neovim and send visual selection to kitty directly
- <kbd><C-CR></kbd>: Quit Neovim, send and execute visual selection to kitty directly
- Copy (<kbd>y</kbd>) or <kbd>i</kbd> / <kbd>a</kbd>: Edit content or start with a empty window
  <kbd><S-CR></kbd> and <kbd><C-CR></kbd> are also available in this window

