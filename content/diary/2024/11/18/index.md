---
title: 2024-11-18
date: 2024-11-18T23:25:34+08:00
lastmod: 2024-11-19T10:22:07+08:00
comments: true
math: false
---

<!--more-->

- [Biostars 论坛](https://www.biostars.org/)
- [安装 Cell Ranger](https://www.10xgenomics.com/cn/support/software/cell-ranger/latest/tutorials/cr-tutorial-in)
- [Cell Ranger 配置要求](https://www.10xgenomics.com/cn/support/software/cell-ranger/latest/tutorials/cr-tutorial-in#sitecheck)
- [salmon](https://salmon.readthedocs.io/en/latest/alevin.html)

> I'm a little confused by your question. So you're looking for software that will take your raw single-cell FASTQ and create a file that can be fed into Seurat? If so, this depends on which company did the sequencing. If it was 10XGenomics, they have software called Cell Ranger that'll take your raw FASTQ files, and turn it into a matrix that can be read by Seurat (using the Read10X function.)[^1]

[^1]: https://www.biostars.org/p/418251/
