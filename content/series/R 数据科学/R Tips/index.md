---
title: "R Tips"
date: 2024-10-06T15:14:37+08:00
lastmod: 2025-05-18T17:36:13+08:00
comments: true
math: false
weight: 99
tags:
    - R
---

<!--more-->

## 数据操作

### 检查数据

- `glimpse()` 可以将数据框“逆时针旋转 90°”，以便能尽可能多地展示更多数据。
- 使用 `tibble` 代替 `data.frame`。`tibble` 的展示函数更加友好。

{{< tab style="success" >}}
`tibble` 被认为是 `data.frame` 的现代化版本，主要特点是正确性和便利性，但数据处理性能方面似乎不显著优于 `data.frame`。如何想要更好的性能，可以使用 `data.table`。
{{< /tab >}}

### 添加新项

数据框和列表均可以直接添加新项：


``` r
df <- data.frame(
    a = c(1, 2, 3),
    b = c("b")
)
df$c <- c("a", "b", "c")
df
```

```
#>   a b c
#> 1 1 b a
#> 2 2 b b
#> 3 3 b c
```


``` r
lt <- list(
    a <- matrix(1:10, nrow = 2),
    b <- "test_string"
)
lt[["c"]] <- "additional entry"
lt
```

```
#> [[1]]
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1    3    5    7    9
#> [2,]    2    4    6    8   10
#> 
#> [[2]]
#> [1] "test_string"
#> 
#> $c
#> [1] "additional entry"
```

向量可以使用 `c()` 或 `append()` 插入新项：


``` r
vc <- c(1, 2, 3)
c(vc, 4)
c(4, vc)
append(vc, after = 0, 0)            # 在最前面插入
append(vc, after = length(vc), 4)   # 在最后面插入
append(vc, 4)                       # 默认在最后面插入
```

```
#> [1] 1 2 3 4
#> [1] 4 1 2 3
#> [1] 0 1 2 3
#> [1] 1 2 3 4
#> [1] 1 2 3 4
```

### 选取操作

对于列表，`$` 和 `[[]]` 几乎一样，返回值是子项；而 `[]` 的返回值则是子集，类型仍然是列表。


``` r
lt <- list(
    a = c(1, 2, 3),
    b = "string"
)

cat("lt$a:\n")
lt$a
cat("lt[[\"a\"]]:\n")
lt[["a"]]
cat("lt[\"a\"]:\n")
lt["a"]
cat("lt[1:2]:\n")
lt[1:2]
```

```
#> lt$a:
#> [1] 1 2 3
#> lt[["a"]]:
#> [1] 1 2 3
#> lt["a"]:
#> $a
#> [1] 1 2 3
#> 
#> lt[1:2]:
#> $a
#> [1] 1 2 3
#> 
#> $b
#> [1] "string"
```

### 管道

除了 `%>%`，R 语言（4.1+）提供了原生的管道运算符 `|>`。在 Rstudio 中，通过 “Tools” → “Global Options...” → “Editing” → “Use native pipe operator, |> (requires R 4.1+)” 来启用。
默认快捷键是 <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>m</kbd>。

### 将数据储存在 Excel 表的不同 Sheets

可以使用 `xlsx` 包，但这个包依赖 Java。因此，推荐使用 `openxlsx` 包。

```r
library(openxlsx)

# Create a blank workbook
OUT <- createWorkbook()

# Add some sheets to the workbook
addWorksheet(OUT, "Sheet 1 Name")
addWorksheet(OUT, "Sheet 2 Name")

# Write the data to the sheets
writeData(OUT, sheet = "Sheet 1 Name", x = dataframe1)
writeData(OUT, sheet = "Sheet 2 Name", x = dataframe2)

# Reorder worksheets
worksheetOrder(OUT) <- rev(1:3)

# Export the file
saveWorkbook(OUT, "My output file.xlsx")
```

### 数据降维

一个 list，包含多个 vectors，需要将其变为一个 vector。


``` r
l <- list(
    a = c(1, 2, 3, 4, 5, 6, 7),
    b = c(3, 4, 5, 6, 7, 8, 9)
)

# 获取在任一 vector 中出现的元素
do.call(c, l)
# 获取在所有 vector 中都出现的元素
Reduce(intersect, l)
```

```
#> a1 a2 a3 a4 a5 a6 a7 b1 b2 b3 b4 b5 b6 b7 
#>  1  2  3  4  5  6  7  3  4  5  6  7  8  9 
#> [1] 3 4 5 6 7
```

### 处理大型数据

见[使用 dplyr 操作数据#tab_处理大型数据]({{< relref "/series/R 数据科学/tidyverse/使用 dplyr 操作数据#tab_处理大型数据" >}})。

### 稀疏矩阵


``` r
library(Matrix)

mat_a <- as(regMat, "sparseMatrix")       # see also `vignette("Intro2Matrix")`
```

```
#> Error: 找不到对象'regMat'
```

``` r
mat_b <- Matrix(regMat, sparse = TRUE)    # Thanks to Aaron for pointing this out
```

```
#> Error: 找不到对象'regMat'
```

``` r
identical(mat_a, mat_b)
```

```
#> Error: 找不到对象'mat_a'
```

``` r
mat_a
```

```
#> Error: 找不到对象'mat_a'
```


### 移除变量

`remove()` 或 `rm()`。

### 计算每一行或列的和

- 简单计算：`rowSums()`、`colSums()`
- 根据一个分组变量（grouping variable）计算行的和：`rowsum()`

### Reduce 函数


``` r
Reduce(
    function(init, xi) {
        print(sprintf("%d + %d", init, xi))
        init + xi
    },
    c(1, 2, 3),
    10
)
```

```
#> [1] "10 + 1"
#> [1] "11 + 2"
#> [1] "13 + 3"
#> [1] 16
```


## 绘图

### 绘图布局

同时绘制几个 plot：


``` r
# 设置绘图区域为 2 行 2 列
par(mfrow = c(2, 2))

plot(1:10, rnorm(10), main = "Plot 1", col = "blue", pch = 16)
plot(1:10, runif(10), main = "Plot 2", col = "red", pch = 16)
plot(1:10, rnorm(10, 5), main = "Plot 3", col = "green", pch = 16)
plot(1:10, runif(10, 0, 5), main = "Plot 4", col = "purple", pch = 16)

# 恢复默认的单个图形布局
par(mfrow = c(1, 1))
```

{{< figure src="/R-figures/series/R 数据科学/R Tips/unnamed-chunk-7-1.png" group="unnamed-chunk-7" alt="unnamed-chunk-7" >}}

使用 `mfcol` 参数会先填充列：


``` r
# 设置绘图区域为 2 列 2 行
par(mfcol = c(2, 2))

plot(1:10, rnorm(10), main = "Plot 1", col = "blue", pch = 16)
plot(1:10, runif(10), main = "Plot 2", col = "red", pch = 16)
plot(1:10, rnorm(10, 5), main = "Plot 3", col = "green", pch = 16)
plot(1:10, runif(10, 0, 5), main = "Plot 4", col = "purple", pch = 16)

# 恢复默认的单个图形布局
par(mfrow = c(1, 1))
```

{{< figure src="/R-figures/series/R 数据科学/R Tips/unnamed-chunk-8-1.png" group="unnamed-chunk-8" alt="unnamed-chunk-8" >}}

### 常用绘图函数

- `par()`：设置一些重要参数
- `plot()`: 基本的绘图函数，或用于为其他一些函数创建“画板”
- `rasterImage()`：绘制像素图像
- `text()`：在任意位置绘制文本
- `title()`：绘制标题、副标题以及 X、Y 轴标签。

### `ggplot2` 注意

- 注意：在 `for` 循环中，需要显式地使用 `print()` 函数来显示图像。

### 排列多个图像

- 使用 [`patchwork` 包](https://patchwork.data-imaginist.com/)可以方便的用 `+`、`|`、`/`、`()` 来排列图像。
- `cowplot` 与 `ggplot2` 集成良好。函数 `plot_grid()` 可用来布局，功能类似 `gridExtra::grid.arrange()`，但语法更加简洁。


``` r
library(ggplot2)
library(cowplot)

plot1 <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
plot2 <- ggplot(mtcars, aes(x = hp, y = mpg)) + geom_point()
plot3 <- ggplot(mtcars, aes(x = cyl, y = mpg)) + geom_point()
plot_list <- list(plot1, plot2, plot3)

# 通过 do.call 合并 plot_list
combined_plot <- do.call(plot_grid, c(plot_list, ncol = 2))
combined_plot

# 也可以直接用 plotlist 参数
plot_grid(plotlist = plot_list, ncol = 2)
```

{{< figure src="/R-figures/series/R 数据科学/R Tips/使用 cowplot 自动排列 plots-1.png" group="使用 cowplot 自动排列 plots" alt="使用 cowplot 自动排列 plots" >}}{{< figure src="/R-figures/series/R 数据科学/R Tips/使用 cowplot 自动排列 plots-2.png" group="使用 cowplot 自动排列 plots" alt="使用 cowplot 自动排列 plots" >}}
> base graphics and ggplot2 can sit side by side;[^knit manual]

[^knit manual]: https://yihui.org/knitr/demo/manual/


``` r
fit <- lm(dist ~ speed, data = cars) # linear regression
par(mar = c(4, 4, 1, 0.1), mgp = c(2, 1, 0))
with(cars, plot(speed, dist, panel.last = abline(fit)))
text(10, 100, "$Y = \\beta_0 + \\beta_1x + \\epsilon$")
library(ggplot2)
qplot(speed, dist, data = cars) + geom_smooth()
```

{{< figure src="/R-figures/series/R 数据科学/R Tips/unnamed-chunk-9-1.png" group="unnamed-chunk-9" alt="unnamed-chunk-9" >}}{{< figure src="/R-figures/series/R 数据科学/R Tips/unnamed-chunk-9-2.png" group="unnamed-chunk-9" alt="unnamed-chunk-9" >}}


### 控制坐标轴

- `coord_fixed(ratio = 1)`：设置 x、y 坐标比例为 1:1。
- `scale_x_continuous(limits = c(2, 5))`：设置横坐标范围。
- `scale_x_continuous(breaks = c(0, 100, 200, 300, 350), labels = c(0, 100, 200, 300, "infinite"))`：设置刻度线和标签。
- `scale_x_continuous(transform = "log10")`（`trans` 已被废弃）：设置坐标轴转换。
  > Built-in transformations include "asn", "atanh", "boxcox", "date", "exp", "hms", "identity", "log", "log10", "log1p", "log2", "logit", "modulus", "probability", "probit", "pseudo_log", "reciprocal", "reverse", "sqrt" and "time".


``` r
# 注意命名方式，scale_x_continuous 会自动查找 transform_xxx 函数
transform_log10 <- scales::trans_new(
    name = "trans_log10",
    transform = function(x) log10(x),
    inverse = function(x) 10 ^ x,
    breaks = function(limits) 10 ^ pretty(log10(limits))
)

xs <- seq(1, 100, by = 0.2)
ggplot(data.frame(x = xs, y = xs ^ 2 - 20 * xs)) +
    geom_smooth(mapping = aes(x, y))
ggplot(data.frame(x = xs, y = xs ^ 2 - 20 * xs)) +
    geom_smooth(mapping = aes(x, y)) +
    scale_x_continuous(transform = "log10")
```

{{< figure src="/R-figures/series/R 数据科学/R Tips/模仿 log10 坐标变换-1.png" group="模仿 log10 坐标变换" alt="模仿 log10 坐标变换" >}}{{< figure src="/R-figures/series/R 数据科学/R Tips/模仿 log10 坐标变换-2.png" group="模仿 log10 坐标变换" alt="模仿 log10 坐标变换" >}}


## 其他

### Rmarkdown 选项

- https://yihui.org/knitr/options/
- [knitr manual](https://yihui.org/knitr/demo/manual/)

进阶设置——Hooks：

根据其他选项决定某一选项：

```r
knitr::opts_hooks$set(fig.width = function(options) {
  if (options$fig.width < options$fig.height) {
    options$fig.width = options$fig.height
  }
  options
})
```


``` r
str(knitr::opts_chunk$get())
```

```
#> List of 55
#>  $ eval               : logi TRUE
#>  $ echo               : logi TRUE
#>  $ results            : chr "hold"
#>  $ tidy               : logi FALSE
#>  $ tidy.opts          : NULL
#>  $ collapse           : logi FALSE
#>  $ prompt             : logi FALSE
#>  $ comment            : chr "#>"
#>  $ highlight          : logi TRUE
#>  $ size               : chr "normalsize"
#>  $ background         : chr "#F7F7F7"
#>  $ strip.white        : 'AsIs' logi TRUE
#>  $ cache              : logi TRUE
#>  $ cache.path         : chr "../.cache/series/R 数据科学/R Tips/"
#>  $ cache.vars         : NULL
#>  $ cache.lazy         : logi TRUE
#>  $ dependson          : NULL
#>  $ autodep            : logi FALSE
#>  $ cache.rebuild      : logi FALSE
#>  $ fig.keep           : chr "high"
#>  $ fig.show           : chr "hold"
#>  $ fig.align          : chr "default"
#>  $ fig.path           : chr "../static/R-figures/series/R 数据科学/R Tips/"
#>  $ dev                : chr "png"
#>  $ dev.args           : NULL
#>  $ dpi                : num 120
#>  $ fig.ext            : NULL
#>  $ fig.width          : num 10
#>  $ fig.height         : num 6
#>  $ fig.env            : chr "figure"
#>  $ fig.cap            : NULL
#>  $ fig.scap           : NULL
#>  $ fig.lp             : chr "fig:"
#>  $ fig.subcap         : NULL
#>  $ fig.pos            : chr ""
#>  $ out.width          : NULL
#>  $ out.height         : NULL
#>  $ out.extra          : NULL
#>  $ fig.retina         : num 1
#>  $ external           : logi TRUE
#>  $ sanitize           : logi FALSE
#>  $ interval           : num 1
#>  $ aniopts            : chr "controls,loop"
#>  $ warning            : logi FALSE
#>  $ error              : logi TRUE
#>  $ message            : logi FALSE
#>  $ render             : NULL
#>  $ ref.label          : NULL
#>  $ child              : NULL
#>  $ engine             : chr "R"
#>  $ split              : logi FALSE
#>  $ include            : logi TRUE
#>  $ purl               : logi TRUE
#>  $ tiry               : logi TRUE
#>  $ unnamed.chunk.label: chr ""
```

#### 设置 RMarkdown 的根目录

在 Rstudio 中，不同于普通的 R script，RMarkdown 的默认的工作目录是其所在目录。使用 `opts_knit$set()`（注意不是 `opts_chunk$set()`）设置根目录为项目根目录：

``rmarkdown

``` r
knitr::opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())
```
``

### 图形交互界面

- `shiny`

### R 语言小特点

- 索引从 1 开始
- 没有 `continue`，取而代之的是 `next`
- 没有 `return` 关键字，取而代之的是 `return()` 函数
- 函数默认会返回函数体中的最后一个输出
