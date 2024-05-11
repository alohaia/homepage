---
title: "R 与 RStudio 的使用"
date: 2024-05-04T16:39:57+08:00
lastmod: 2024-05-11T20:56:47+08:00
comments: true
math: false
tags:
    - R
---

## 获取帮助

- `?topic` 或 `type?topic` 可以获取关于 `topic` 的帮助。`?` 为 `help()` 的简便写法。
- `??pattern` 或 `field??pattern` 可以在帮助系统中查找带有字符串 `pattern` 的实例（包、类、函数等）。`??` 为 `help.search()` 的简便写法。
- `example("foo")` 可以在当前终端运行函数 `foo()` 的示例。

## 包管理

- 安装：`install.packages()`
- 移除：`remove.packages()`
- 更新：`update.packages()`

