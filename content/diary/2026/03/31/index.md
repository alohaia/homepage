---
title: 2026-03-31
date: 2026-03-31T16:40:17+08:00
lastmod: 2026-03-31T17:13:03+08:00
comments: true
---

<!--more-->

[Fcitx5](https://wiki.archlinux.org/title/Fcitx5#Software_using_Wayland_input_protocol_cannot_obtain_Wayland_popup_window)

Wayland 对 per-program state 和 pre-edit 的支持不太好，可能最好全部禁用。

更新：还是用 KDE 的 x11 session（`plasma-x11-session` 包）吧。


## 2026-04-02

[A Guide to `vim.pack`](https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack)

Neovim 0.12 版本更新中，新增了内置的 *package* 管理器 `vim.pack`。所谓 *package*，就是一系列要一起配合使用的插件。


- Neovim 的标准 data 目录：`~/.local/share/nvim`（`stdpath("data")` 或 `$XDG_DATA_HOME/nvim`，见 `:h standard-path`）。
- 


使用 `vim.pack.add()` 可以加载或安装插件，插件会安装为 `core` package 的 `opt` 插件，因此 `core` package 中的插件应该只通过 `vim.pack` 管理，不应该手动更新或删除等。

> [!NOTE]
> 只有作为 Git 仓库的插件可以通过 `vim.pack` 管理，对于类型的插件或本地插件，推荐创建 `core` 以外的 package 自行管理。


