---
title: 2025-06-10 Count，GeneRatio，BgRatio，RichFactor 和 FoldEnrichment
date: 2025-06-10T21:44:44+08:00
lastmod: 2025-06-11T14:12:58+08:00
comments: true
math: false
---

<!--more-->

先定义几个概念：

- 输入基因列表（`gi`）：作为富集分析的输入的感兴趣基因列表，如差异分析获得的所有差异基因
- 目标*基因集*（geneset）（`gt`）：如“epidermal cell differentiation”基因集——`KRT17/KRT16/KRT6A/KRT6B/S100A7/KRT75`
- 所有基因集的集合（`G`）：比如 GO 中包含的所有基因集（包含“epidermal cell differentiation”）的集合

下面用伪代码表示 Count、RichFactor 等：

```r
Count <- overlap_size(gi, gt)

GeneRatio <- overlap_size(gi, gt) / overlap_size(gi, unique(G))
BgRatio <- size(gt) / size(unique(G))

RichFactor <- overlap_size(gi, gt) / size(gt)

FoldEnrichment <- GeneRatio / BgRatio
```
