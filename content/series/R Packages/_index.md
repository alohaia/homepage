---
title: "R Packages"
date: 2026-03-23T11:57:54+08:00
lastmod: 2026-03-24T10:32:18+08:00
comments: true
math: false
weight: 1
tags:
    - "R Packages"
---

<!--more-->

Short tutorial:

{{< youtube id="XjolVT16YNw?list=PLmNrK_nkqBpIZlWa3yGEc2-wX7An2kpCL" >}}

Free online e-book: [R Packages (2e)](https://r-pkgs.org/).

## Preparations

### 开发环境

- 推荐使用 RStudio。
- 版本控制工具：Git。
- `devtools` 包是“the public face of a set of packages that support various aspects of package development”，包括 `usethis` 包。
    ``` r
    library(devtools)
    packageVersion("devtools")
    ```
    ```
    #> [1] '2.4.6'
    ```
- 安装、帮助文档、质控工作流：
    - `roxygen2`：函数的独立文档
    - `testthat`：单元测试
    - `README.Rmd` 文件：整个包的文档
