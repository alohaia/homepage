---
title: "Git 常用操作"
date: 2026-03-16T15:15:34+08:00
lastmod: 2026-10-27T15:09:32+08:00
comments: true
tags:
    - Git
---

<!--more-->

[廖雪峰 Git 教程](https://liaoxuefeng.com/books/git/introduction/index.html)

## 基本概念

### 四个工作区域

{{< figure src="working_dirs.png" title="Git 工作区域" >}}

### 文件的四种状态

{{< figure src="git_status.png" title="文件的 Git 状态" >}}

1. `Untracked`（未跟踪）：文件在工作区，但没有加到仓库中
    - 通过 `git add` 变更为 `Staged`
2. `Unmodified`（未修改）：文件已入库，且工作区的该文件与仓库内的一致
    - 修改工作区文件，变为 `Modified`
    - 使用 `git rm` 移出仓库，变为 `Untracked`
3. `Modified`（已修改）：文件已入库，工作区的该文件与仓库内的不一致
    - 通过 `git add` 变为 `Staged`
    - 使用 `git checkout` 丢弃工作区修改（`git checkout` 就是从仓库中拿出原文件覆盖工作区文件）
4. `Staged`（已暂存）：文件在暂存区

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

### git reset

`reset` 命令用来移动当前分支的位置。

`git reset --soft` 是 `reset` 的最小操作，只移动分支。初始仓库状态：

    HEAD -> main -> <commit_orig>

用 `git reset --soft <commit_another>` 会变成：

    HEAD -> main -> <commit_another>


### 上次提交多提交了文件怎么办？

#### 方法一：修改暂存区内容，再修改提交

首先查看上次的提交详情，`--name-only` 只显示文件名不显示 diff：

```bash
git show --name-only HEAD
```
    commit ecb447a73e8713ac636ce5358ab74e9933719504 (HEAD -> main)
    ...
    mesh.sh
    system/controlDict
    system/decomposeParDict
    system/fvSchemes
    system/fvSolution


先用重置（`git restore`）暂存区（`--cached`）中上次提交的修改：

```bash
git restore --source=HEAD~ --staged system/*
```
    位于分支 main
    要提交的变更：
    （使用 "git restore --staged <文件>..." 以取消暂存）
        修改：     system/controlDict
        修改：     system/decomposeParDict
        修改：     system/fvSchemes
        修改：     system/fvSolution

    尚未暂存以备提交的变更：
    （使用 "git add <文件>..." 更新要提交的内容）
    （使用 "git restore <文件>..." 丢弃工作区的改动）
        修改：     system/controlDict
        修改：     system/decomposeParDict
        修改：     system/fvSchemes
        修改：     system/fvSolution

    未跟踪的文件:
    （使用 "git add <文件>..." 以包含要提交的内容）
        simulate.sh

用暂存区的内容修改上次提交（`git commit --amend`），并且不打开编辑界面（`--no-edit`）：

```bash
git commit --amend --no-edit
```
    [main 9a47c36] mv run to mesh.sh
    Date: Mon Oct 26 17:55:32 2026 +0800
    5 files changed, 142 deletions(-)
    rename run => mesh.sh (100%)
    delete mode 100644 system/controlDict
    delete mode 100644 system/decomposeParDict
    delete mode 100644 system/fvSchemes
    delete mode 100644 system/fvSolution

#### 方法二：撤销提交，重新提交

```bash
git reset --mixed HEAD~1
```
    重置后取消暂存的变更：
    D	run
    M	system/controlDict
    M	system/decomposeParDict
    M	system/fvSchemes
    M	system/fvSolution

> [!NOTE]
> `git reset` 默认使用 `--mixed` 模式，同时修改仓库和暂存区。改为 `--soft` 可以只修改仓库内容，保留暂存区内容，而使用 `--hard` 同时修改仓库、暂存区和工作树。

> [!NOTE]
> 如果用 `git reset` 退回到上一次提交，那么这次提交就会被隐藏，无法再 `git log` 中看到。要再次回到最新的提交，可以使用 `git reflog` 查看操作前处于哪个 commit，并用 `git reset` 回到目标 commit。
