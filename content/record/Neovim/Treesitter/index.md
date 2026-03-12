---
title: "Treesitter"
date: 2026-03-12T00:48:45+08:00
lastmod: 2026-03-12T17:54:58+08:00
comments: true
math: false
tags:
    - Neovim
---

<!--more-->

## Parsers

Neovim 内置了 C、Lua、Markdown、Vimscript、Vimdoc 以及 Treesitter query files 等 ***parser***s. Parsers 位于 `runtimepath` 的 `parser/{lang}.*`，使用 [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) 插件可自动管理额外 parsers。

- 加载 parser：
  ```lua
    vim.treesitter.language.add('python', { path = "/path/to/python.so" })
    ```
- 为文件类型注册额外 parser，如为 `svg` 和 `xslt` 文件类型注册 `xml` parser：
    ```lua
    vim.treesitter.language.register('xml', { 'svg', 'xslt' })
    ```

## Queries

> **Queries 只能使用 parser 解析好的节点，而不能新定义节点。**

Queries 是用[一种类似 Lisp 的语言](https://tree-sitter.github.io/tree-sitter/using-parsers/queries/1-syntax.html)（[S 表达式](https://en.wikipedia.org/wiki/S-expression)）写的。Neovim 会在 `runtimepath` 中查找 `queries` 目录下的 `*.scm` 文件，比如 `queries/lua/highlights.scm` 是用来定义 Lua 语言的高亮的。通常会直接按照“用户 > 插件 > 默认”的顺序完全替换，使用 [`treesitter-query-modeline-extends`](https://neovim.io/doc/user/treesitter/#treesitter-query-modeline-extends) 可以指定扩展而非替代。Neovim 还提供了 Lua 接口 [`vim.treesitter.query`](https://neovim.io/doc/user/treesitter/#lua-treesitter-query)。


使用以下 Vim 命令可以查看有哪些 queries：

```vim
echo globpath(&rtp, "queries/markdown_inline/*.scm", 0, 1)
echo globpath(&rtp, "syntax/markdown**", 0, 1)
```

匹配一个给定节点的表达式包括用*括号*包围的*两部分*：

1. 这个节点的类型；
2. 一系列匹配该节点的子节点的其他表达式。

TODO
