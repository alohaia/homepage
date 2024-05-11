---
title: 2024-04-06
date: 2024-04-06T15:33:46+08:00
lastmod: 2024-05-11T18:45:50+08:00
comments: true
math: false
---

## Vim 小技巧

- 在插入模式输入 abcd<C-g>uefg，再回到普通模式，按 u，会只撤销 efg 变成 abcd，而不会全部撤销

## Vimscript 小技巧

- 布尔值：`v:true`，`v:false`
- 支持函数参数默认值，且可在默认值中调用函数，如 `func! Test(lnum = line('.')) ... endfunc`

## Vimscript 正则小技巧

- \\%(\\)：A pattern enclosed by escaped parentheses. Just like \\(\\), but without counting it as a sub-expression. This allows using more groups and it's a little bit faster.
- 另一个特殊的 \\(\\)：\\z(\\)
- \\{-n,m}：非贪婪匹配 n 到 m 次
- The "\\f" item stands for file name characters.（Neovim 的 Character classes）
- Vimscript 正则匹配支持偏移：/<pattern>/<offset>
- \\%x：匹配十六进制字符，如空格 \\%x20
- \\?：Just like \\=.  Cannot be used when searching backwards with the "?" command.
- \\%# 匹配光标位置
- \\%'m	Matches with the position of mark m.
- \\%\<'m	Matches before the position of mark m.
- \\%\>'m	Matches after the position of mark m.

## Neovim 与 Lua

编写 lua 脚本时可以使用的函数：

1. `vim.xxx`（首选）：如 `vim.regex()`，`vim.split()`，`vim.tbl_xxx()`，见 `:h lua`
2. `vim.api.xxx`：Neovim 提供的 API 的 Lua 版本，见 `:h api`。
3. `vim.fn.xxx`：Vimscript 函数的 Lua 版本，见 `:h function-list`

其他可能用到的接口：

- 映射：`vim.keymap`
- 高亮：`vim.highlight`
- 选项：`vim.opt`，`vim.o`，`vim.go`，`vim.bo`，`vim.wo`
- 变量：`vim.g`，`vim.b`，`vim.w`，`vim.t`，`vim.v`，`vim.env`
- 文件系统：`vim.fs`
