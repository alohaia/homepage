---
title: "Git 常用操作"
date: 2026-03-16T15:15:34+08:00
lastmod: 2026-03-16T15:25:22+08:00
comments: true
math: false
tags:
    - Git
---

<!--more-->

## 撤销更改

- 撤销工作区（未 `add`）的更改：
    ```bash
    git restore content/diary/2026/02/12/index.{md,Rmd} # 可使用通配符
    ```
- 撤销暂存区（已 `add`，未 `commit`）的更改：
    ```bash
    git restore --staged path/to/files
    ```
- 同时撤销暂存 + 工作区修改：
    ```bash
    git restore --staged --worktree path/to/files
    ```
- 指定版本：
    ```bash
    git restore --source=HEAD~1 path/to/files
    git restore --source=<commit hash> path/to/files
    ```
- 撤销已提交更改：查看历史版本，手动修改到旧内容，再重新提交新提交。

