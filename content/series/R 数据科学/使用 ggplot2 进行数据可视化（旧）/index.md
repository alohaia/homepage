---
title: "使用 ggplot2 进行数据可视化（旧）"
date: 2024-05-20T17:11:57+08:00
lastmod: 2024-05-20T18:04:59+08:00
comments: true
math: false
weight: 999
tags:
    - R
---



参考：

- [*R for Data Science*](https://r4ds.had.co.nz/)
- 《R 语言实战》

<!--more-->

`tidyverse` 是一个非常优秀的包，*R for Data Science* 需要安装该包：

```r
install.packages("tidyverse")
```

使用 `library()` 以 加载 R 包：


```r
library(tidyverse)
```



## 使用 ggplot2 进行数据可视化

### 准备

你可以使用 ggplot2 中的 `mpg` 数据框（即 `ggplot2::mpg`）用于练习。


```r
ggplot2::mpg
```

```
#> # A tibble: 234 × 11
#>    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
#>    <chr>        <chr>      <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr>
#>  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
#>  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
#>  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
#>  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
#>  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
#>  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
#>  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
#>  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
#>  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
#> 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
#> # ℹ 224 more rows
```

**数据框**是变量（列）和观测（行）的矩形集合。`mpg` 包含了由美国环境保护协会收集的 38 种车型的观测数据。
- `displ`：引擎大小，单位为升
- `hwy`：燃油效率，单位为英里/加仑（mpg）

### 绘制 ggplot 图形


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/ggplot2-introduction-1.png" group="ggplot2-introduction" alt="ggplot2-introduction" >}}

`ggplot(data = mpg)` 创建了一个空白的坐标系，`geom_point()` 就向图中添加了一个点层，这样就创建了一个散点图。

`ggplot2` 中每个几何对象都有一个 `mapping` 参数。这个参数定义了如何将数据集中的变量映射为图形属性。`mapping` 参数总是与 `aes()` 函数成对出现，`aes()` 函数的 `x` 参数和 `y` 参数分别指定了映射到 `x` 轴的变量与映射到 `y` 轴的变量。`ggplot2` 在 `data` 参数中寻找映射变量，本例中就是 `mpg`。

总结来说，要生成一张图，使用以下代码模版即可：

```r
ggplot(data = <DATA>) +
    <GEOM_FUNCTIOM>(mapping = aes(<MAPPINGS>))
```

### 图片属性映射

可以将数据集中的第三个变量，如 `class`，映射为二维散点图中的**图形属性**，如数据点的大小、形状和颜色。

将 `class` 映射为 `color`（或 `colour`），可以清晰地在图中辨别车辆的类型：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/mapping-color-1.png" group="mapping-color" alt="mapping-color" >}}

用 `aes()` 将图形属性名称关联起来，`ggplot2` 就会自动为每个变量值分配唯一的图形属性*水平*。

{{< tab style="default" >}}
因为已经用“value”表示数据的值，所以使用“level”（水平）来表示图形属性的值。
{{< /tab >}}

也可以将 `class` 映射为 `size` 图形属性：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = class))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/mapping-size-1.png" group="mapping-size" alt="mapping-size" >}}

这里出现了一条警告信息，因为将无序变量 `class` 映射为有需变量 `size` 不是一个好主意。

或者将 `class` 映射为点的透明度或形状：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/mapping-alpha,shape-1.png" group="mapping-alpha,shape" alt="mapping-alpha,shape" >}}{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/mapping-alpha,shape-2.png" group="mapping-alpha,shape" alt="mapping-alpha,shape" >}}

注意下图中的 “suv” 没有显示，这是因为 `ggplot2` 默认只支持 6 种形状。

另外，数据点的 x 轴位置 `x` 和 y 轴位置 `y` 本身也是图形属性。用数据绘图本质就是将数据中的值映射为图中的图形属性。

也可以手动为图形属性指定固定水平：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/manual-fixed-value-1.png" group="manual-fixed-value" alt="manual-fixed-value" >}}

注意不要将固定值放在 `aes()` 函数里，因为此时颜色并不是用来传达变量的信息，而只是改变图的外观。错误示范：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/manual-fixed-value-wrong-1.png" group="manual-fixed-value-wrong" alt="manual-fixed-value-wrong" >}}

其中的点的颜色都是橙色，这是因为 R 将 `"blue"` 视作数据，而不是颜色值。

此外，需要为图形属性设置一个有效值：
- 颜色名称是一个字符串
- 点的大小用毫米表示
- 点的形状是 0\~25 的一个整数值

#### 其他示例


```r
ggplot(data = mpg, mapping = aes(displ, hwy)) +
    geom_point(shape = 21, fill = "white", size = 5, stroke = 5)
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/other examples-1.png" group="other examples" alt="other examples" >}}{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/other examples-2.png" group="other examples" alt="other examples" >}}

### 分面

要在图中添加新的展示变量，除了可以用图形属性，还可以将图分隔成多个**分面**。


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~class, nrow = 2)
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/facet_wrap-1.png" group="facet_wrap" alt="facet_wrap" >}}

`facet_wrap()` 函数的第一个参数是一个公式（R 中的一种数据结构，不是数学意义上的公式），传递给 `facet_wrap()` 的参数应该是离散型的。

要通过两个变量对图进行分面，需使用 `facet_grid()` 函数，该函数的公式参数包含由 `~` 分隔的两个变量名。


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ cyl)
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/facet_grid-1.png" group="facet_grid" alt="facet_grid" >}}

如果不想在行或列的维度进行分面，可以使用 `.` 代替变量名，如 `. ~ cyl`

### 几何对象


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
    geom_smooth(mapping = aes(x = displ, y = hwy))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/geometry object-1.png" group="geometry object" alt="geometry object" >}}{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/geometry object-2.png" group="geometry object" alt="geometry object" >}}

两张图使用了同样的数据，但它们使用了不同的可视化对象。在 `ggplot2` 语法中，我们称它们使用了不同的**几何对象**。第一张图使用了点几何对象而第二张图使用了平滑曲线几何对象。

你可以在同一张图中使用多个几何对象：


```r
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = drv), size = 3) +
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/geom_smooth-1.png" group="geom_smooth" alt="geom_smooth" >}}
{#geom_smooth}

为避免代码重复，可以将所有几何对象共用的映射写在 `ggplot()` 函数中，这样 ggplot2 会将这些映射作为全局映射应用到图中的每个几何对象中。以下代码与 [上面的代码](#geom_smooth) 等效。

```r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point(size = 3) +
    geom_smooth()
```

### 统计变换


```r
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut))
```

{{< figure src="/R-figures/series/R 数据科学/使用 ggplot2 进行数据可视化（旧）/geom_bar-1.png" group="geom_bar" alt="geom_bar" >}}

注意到图中出现了一个新的变量 `count`，但是 `count` 不是 `diamonds` 中的变量。之所以会出现新的变量，是因为一些图形（如条形图）不只是绘制数据集的原始数据，而是可以绘制自己计算出的新数据。

- 条形图、直方图和频率多边形图可以对数据进行分组并计算出每组的频数。
- 平滑曲线会为数据拟合一个模型，然后绘制出模型预测值。
- ……

绘图时用来计算新数据的算法称为 `stat`（statistical transformation，**统计变换**）。几何对象（`geom_bar`）使用给出的值及映射关系（`x = cut`）计算出新数据（`count`）及映射（映射到 y 轴）。
`?geom_bar` 显示 `stat`（统计变换）的默认值为 `"count"`（注意与 `stat_count()` 计算出的 `count` 区别），这说明 `geom_bar()` 默认使用 `stat_count()` 进行统计变换。`stat_count()` 的说明也在这页，在 "Computed variables" 一节中有两个变量 `count` 和 `prop`，它们是 `stat_count()` 会计算出的新数据。

