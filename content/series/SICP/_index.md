---
title: "SICP"
date: 2026-03-23T11:10:27+08:00
lastmod: 2026-03-30T18:48:26+08:00
comments: true
weight: 1
tags:
    - SICP
---

<!--more-->

- [learning-sicp](https://github.com/deathking/learning-sicp)
- [yast-cn -- Yet Another Scheme Tutorial: Scheme 入门教程（中文）](https://deathking.github.io/yast-cn/)
- [MIT Scheme](https://www.gnu.org/software/mit-scheme/)
- [nvim-lspconfig - racket_langserver](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#racket_langserver)

## 配置环境

```bash
paru -S racket

raco pkg install sicp
raco pkg install racket-langserver
```

配合 `racket`（`scheme` 可选）Treesitter parser。

测试文件（`test.rkt`）：

```racket
#lang sicp

(define (square x)
  (* x x))

(square 5)
```


