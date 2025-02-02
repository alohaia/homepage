---
title: "Git Tips"
date: 2024-11-30T00:20:58+08:00
lastmod: 2024-11-30T01:30:02+08:00
comments: true
math: false
tags:
---

<!--more-->

## 使用 `.gitignore` 的排除规则 {#排除规则}

使用排除规则（negation rule）来排除除了特定后缀名文件以外的所有文件，一般格式如下：

```gitignore
# 排除所有文件和目录
*

# 允许递归目录
!*/

# 设置需要加入的文件类型
!*.R
!*.md
!*.Rmd

# 排除隐藏文件/目录
.*

# 排除特殊目录
site-packages
_data
_output
```

`.gitignore` 的作用范围，仅对尚未被 Git 追踪的文件有效。如果文件已被追踪，需先用以下命令将其从版本控制中移除：

```bash
git rm --cached -r .
```

使用以下命令查看文件是否被 `.gitignore` 忽略：

```bash
git check-ignore -v <filename>
```
