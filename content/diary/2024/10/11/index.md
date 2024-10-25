---
title: 2024-10-11 Cellphone
date: 2024-10-11T10:16:33+08:00
lastmod: 2024-10-11T23:32:49+08:00
comments: true
math: false
---

<!--more-->

参考链接：

- [Cell Ranger 和 Loupe](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/what-is-cell-ranger)
- [Cellphone notebooks](https://github.com/ventolab/CellphoneDB/blob/master/notebooks)
- [Cellphone documentation](https://cellphonedb.readthedocs.io/en/latest/RESULTS-DOCUMENTATION.html)
- `ktplots` - [Plotting CellPhoneDB results](https://zktuong.github.io/ktplots/articles/vignette.html)
- [lima1/sttkit](https://github.com/lima1/sttkit): [Utility Functions for SpatialTranscriptomics](https://rdrr.io/github/lima1/sttkit/)
- Cellchat - [Inference and analysis of cell-cell communication using CellChat](https://htmlpreview.github.io/?https://github.com/jinworks/CellChat/blob/master/tutorial/CellChat-vignette.html)


```R
oli_count <- read.delim("SX12-2/Oligodendrocytes_count.xls", row.names = 1, header = TRUE)
```

如果你的数据非常大，`read.csv()` 可能会较慢，建议使用 `fread()` 来读取大型 CSV/TSV 文件。

```R
library(data.table)

expr_matrix <- fread("path/to/your/matrix.csv", sep = "\t", header = T) # header 默认为 TRUE
# 将第一列设为行名，并删除该列
# fread 没有 row.names 参数，需要手动转换
rownames(expr_matrix) <- expr_matrix[[1]]  # 将第一列设为行名
expr_matrix[[1]] <- NULL  # 删除第一列（基因名列）
```

转换为稀疏矩阵

```R
Matrix(expr_matrix, sparse = TRUE)
```

## CellphoneDB

{{< tab style="info" summary="CellphoneDB 注意" details=true >}}
- 支持微环境（Micronevironments）
{{< /tab >}}

### CellphoneDB 安装和 Python 操作

1. Create python=>3.8 environment
   - Using conda: `conda create -n cpdb python=3.8`
   - Using virtualenv: `python -m venv cpdb`
2. Activate environment
   - Using conda: `source activate cpdb`
   - Using virtualenv: `source cpdb/bin/activate`
3. Install CellphoneDB `pip install cellphonedb`
4. Set up the kernel for the Jupyter notebooks.
   - Install the ipython kernel: `pip install -U ipykernel`.
   - Add the environment as a jupyter kernel: `python -m ipykernel install --user --name 'cpdb'`.
   - Open/Start Jupyter and select the created kernel.
5. Download the database.
   - Follow this [tutorial](https://github.com/ventolab/CellphoneDB/blob/master/notebooks/T0_DownloadDB.ipynb).

https://github.com/ventolab/CellphoneDB/blob/master/notebooks/DEGs_calculation/0_prepare_your_data_from_Seurat.ipynb

### Wrokflow

1. 在 RStudio 中导入表达矩阵（已分类）并标准化（`NormalizeData()`）。
2. 创建 Seurat 对象。
3. 使用 `sttkit` 包的 `cellphone_for_seurat()` 函数，用 Seurat 对象生成 `cellphonedb/XXX_counts.txt` 和 `cellphonedb/XXX_mdtadata.txt` 文件。

{{< tab style="warning" >}}
读取的 anndata 对象中，`obs_names` 应为细胞名（Barcodes），`var_names` 应为基因名。
{{< /tab >}}

## `sttkit`

注释用数据库：

```R
BiocManager::install("AnnotationDbi")
BiocManager::install("org.Hs.eg.db")	# 人类基因注释数据库。
BiocManager::install("org.Mm.eg.db")	# 小鼠基因注释数据库。

library(AnnotationDbi)
library(org.Hs.eg.db)

orgdb <- org.Hs.eg.db
```

- 人类：`org.Hs.eg.db`
- 小鼠：`org.Mm.eg.db`
- 大鼠：`org.Rn.eg.db`
- 酵母：`org.Sc.sgd.db`
- 果蝇：`org.Dm.eg.db`
- 拟南芥：`org.At.tair.db`















获取 Seurat 对象的 counts 矩阵，并使用 `log(x + 1)` 标准化：

```R
boso@assays$RNA$counts |> log1p()
```
