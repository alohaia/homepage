---
title: "使用 dplyr 操作数据"
date: 2024-10-27T20:19:46+08:00
lastmod: 2024-10-29T09:42:24+08:00
comments: true
math: false
weight: 1
tags:
    - R
    - Tidyverse
---

`dplyr` 是一种数据操作语法（“A Grammar of Data Manipulation”），提供了一组连贯的*动词*来帮助处理常见的数据操作。

<!--more-->

- [“single-table” 动词](#单表格动词)（见 `vignette("dplyr")`）：
    1. `mutate()` adds new variables that are functions of existing variables.
    1. `select()` picks variables based on their names.
    1. `filter()` picks cases based on their values.
    1. `summarise()` reduces multiple values down to a single summary.
    1. `arrange()` changes the ordering of the rows.
- “two-table” 动词（见 `vignette("two-table")`）

和 `group_by()` 组合使用这些函数，可以“by group”地进行任何操作。

> If you are new to dplyr, the best place to start is the [data transformation chapter](https://r4ds.hadley.nz/data-transform) in R for Data Science.

{{< tab style="success" summary="使用其他 backends 处理大型数据" details=false id="tab_处理大型数据" >}}
In addition to data frames/tibbles, dplyr makes working with other computational backends accessible and efficient. Below is a list of alternative backends:

1. `arrow` for larger-than-memory datasets, including on remote cloud storage like AWS S3, using the Apache Arrow C++ engine, Acero.
1. `dtplyr` for large, in-memory datasets. Translates your dplyr code to high performance `data.table` code.
1. `dbplyr` for data stored in a relational database. Translates your dplyr code to SQL.
1. `duckplyr` for using duckdb on large, in-memory datasets with zero extra copies. Translates your dplyr code to high performance duckdb queries with an automatic R fallback when translation isn’t possible.
1. `duckdb` for large datasets that are still small enough to fit on your computer.
1. `sparklyr` for very large datasets stored in Apache Spark.
{{< /tab >}}

## 准备


``` r
library(dplyr)
```

示例数据 `starwars`：


``` r
typeof(starwars)
glimpse(starwars)
```

```
#> [1] "list"
#> Rows: 87
#> Columns: 14
#> $ name       <chr> "Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader", "Leia Or…
#> $ height     <int> 172, 167, 96, 202, 150, 178, 165, 97, 183, 182, 188, 180, 2…
#> $ mass       <dbl> 77.0, 75.0, 32.0, 136.0, 49.0, 120.0, 75.0, 32.0, 84.0, 77.…
#> $ hair_color <chr> "blond", NA, NA, "none", "brown", "brown, grey", "brown", N…
#> $ skin_color <chr> "fair", "gold", "white, blue", "white", "light", "light", "…
#> $ eye_color  <chr> "blue", "yellow", "red", "yellow", "brown", "blue", "blue",…
#> $ birth_year <dbl> 19.0, 112.0, 33.0, 41.9, 19.0, 52.0, 47.0, NA, 24.0, 57.0, …
#> $ sex        <chr> "male", "none", "none", "male", "female", "male", "female",…
#> $ gender     <chr> "masculine", "masculine", "masculine", "masculine", "femini…
#> $ homeworld  <chr> "Tatooine", "Tatooine", "Naboo", "Tatooine", "Alderaan", "T…
#> $ species    <chr> "Human", "Droid", "Droid", "Human", "Human", "Human", "Huma…
#> $ films      <list> <"A New Hope", "The Empire Strikes Back", "Return of the J…
#> $ vehicles   <list> <"Snowspeeder", "Imperial Speeder Bike">, <>, <>, <>, "Imp…
#> $ starships  <list> <"X-wing", "Imperial shuttle">, <>, <>, "TIE Advanced x1",…
```

## 单表格动词

dplyr 旨在为数据操作的每个基础动词提供一个函数。这些动词可以根据其使用的数据集成分分为三类：

- 行：
    - `filter()` 根据列的值选择行。
    - `slice()` 根据位置选择行。
    - `arrange()` 更改行的顺序。
- 列：
    - `select()` 选择列。
    - `rename()` 更改列名。
    - `mutate()` 更改列的值并创建新列。
    - `relocate()` 更改列的顺序。
- 行组（groups of rows）：
    - `summarise()` 将一个组压缩为一行。
{.wrap}

{{< tab style="success" summary="管道操作符" details=false >}}
`magrittr` 包提供了管道操作符 `%>%`。相比于 R 的原生管道操作符 `|>`，`%>%` 使用时处理可以默认传递数据到函数的第一个参数，还可以通过 `.` 明确指定要传递的位置。


``` r
mtcars %>% .[.$mpg > 20, ]
```

```
#>                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> Merc 240D      24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> Merc 230       22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```
{{< /tab >}}

### 操纵行的单表格动词

#### 使用 `filter()` 过滤行 {#filter}


``` r
starwars %>% filter(skin_color == "light", eye_color == "brown")
```

```
#> # A tibble: 7 × 14
#>   name      height  mass hair_color skin_color eye_color birth_year sex   gender
#>   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#> 1 Leia Org…    150    49 brown      light      brown             19 fema… femin…
#> 2 Biggs Da…    183    84 black      light      brown             24 male  mascu…
#> 3 Padmé Am…    185    45 brown      light      brown             46 fema… femin…
#> 4 Cordé        157    NA brown      light      brown             NA <NA>  <NA>  
#> 5 Dormé        165    NA brown      light      brown             NA fema… femin…
#> 6 Raymus A…    188    79 brown      light      brown             NA male  mascu…
#> 7 Poe Dame…     NA    NA brown      light      brown             NA male  mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```

和所有单表动词一样，`filter()` 的第一个参数是一个 `tibble` 或 `data.frame` 对象，后续参数会引用第一个参数中的变量。

{{< tab style="success" summary="`filter()` 中不能使用 `select()` 的帮助函数" details=true >}}
`ends_with()`、`contains()` 等帮助函数只能在 `select()` 中使用，可以用 `stringr` 中的函数替代：


``` r
starwars %>% filter(stringr::str_starts(name, "L"))
starwars %>% filter(stringr::str_detect(name, "an"))
```

```
#> # A tibble: 6 × 14
#>   name      height  mass hair_color skin_color eye_color birth_year sex   gender
#>   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#> 1 Luke Sky…    172  77   blond      fair       blue              19 male  mascu…
#> 2 Leia Org…    150  49   brown      light      brown             19 fema… femin…
#> 3 Lando Ca…    177  79   black      dark       brown             31 male  mascu…
#> 4 Lobot        175  79   none       light      blue              37 male  mascu…
#> 5 Luminara…    170  56.2 black      yellow     blue              58 fema… femin…
#> 6 Lama Su      229  88   none       grey       black             NA male  mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
#> # A tibble: 9 × 14
#>   name      height  mass hair_color skin_color eye_color birth_year sex   gender
#>   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#> 1 Leia Org…    150    49 brown      light      brown             19 fema… femin…
#> 2 Obi-Wan …    182    77 auburn, w… fair       blue-gray         57 male  mascu…
#> 3 Han Solo     180    80 brown      fair       brown             29 male  mascu…
#> 4 Lando Ca…    177    79 black      dark       brown             31 male  mascu…
#> 5 Quarsh P…    183    NA black      dark       brown             62 male  mascu…
#> 6 Gasgano      122    NA none       white, bl… black             NA male  mascu…
#> 7 Bail Pre…    191    NA black      tan        brown             67 male  mascu…
#> 8 Jango Fe…    183    79 black      tan        brown             66 male  mascu…
#> 9 San Hill     191    NA none       grey       gold              NA male  mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```
{{< /tab >}}

#### 使用 `arrange()` 根据列值（变量）排序行 {#arrange}


``` r
starwars %>% arrange(height)
```

```
#> # A tibble: 87 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 Yoda         66    17 white      green      brown            896 male  mascu…
#>  2 Ratts T…     79    15 none       grey, blue unknown           NA male  mascu…
#>  3 Wicket …     88    20 brown      brown      brown              8 male  mascu…
#>  4 Dud Bolt     94    45 none       blue, grey yellow            NA male  mascu…
#>  5 R2-D2        96    32 <NA>       white, bl… red               33 none  mascu…
#>  6 R4-P17       96    NA none       silver, r… red, blue         NA none  femin…
#>  7 R5-D4        97    32 <NA>       white, red red               NA none  mascu…
#>  8 Sebulba     112    40 none       grey, red  orange            NA male  mascu…
#>  9 Gasgano     122    NA none       white, bl… black             NA male  mascu…
#> 10 Watto       137    NA black      blue, grey yellow            NA male  mascu…
#> # ℹ 77 more rows
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```

可以同时使用多个变量排序，第一个用于排序的变量的优先级最高：


``` r
testib <- tibble(
    a = c(1, 1, 1, 2, 2, 2, 3, 3, 3),
    b = c(4, 9, 3, 2, 1, 8, 5, 7, 6)
)
testib %>% arrange(a, b)
```

```
#> # A tibble: 9 × 2
#>       a     b
#>   <dbl> <dbl>
#> 1     1     3
#> 2     1     4
#> 3     1     9
#> 4     2     1
#> 5     2     2
#> 6     2     8
#> 7     3     5
#> 8     3     6
#> 9     3     7
```

`arrange()` 默认是升序，使用 `desc()` 可降序排列：


``` r
testib <- tibble(
    a = c(1, 1, 1, 2, 2, 2, 3, 3, 3),
    b = c(4, 9, 3, 2, 1, 8, 5, 7, 6)
)
testib %>% arrange(desc(a), b)
```

```
#> # A tibble: 9 × 2
#>       a     b
#>   <dbl> <dbl>
#> 1     3     5
#> 2     3     6
#> 3     3     7
#> 4     2     1
#> 5     2     2
#> 6     2     8
#> 7     1     3
#> 8     1     4
#> 9     1     9
```
{{< tab style="info" >}}
无论是升序还是降序，`NA` 值都会被放在末尾：


``` r
starwars %>% arrange(hair_color) %>% slice_tail(n = 8)
starwars %>% arrange(desc(hair_color)) %>% slice_tail(n = 8)
```

```
#> # A tibble: 8 × 14
#>   name      height  mass hair_color skin_color eye_color birth_year sex   gender
#>   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#> 1 Ki-Adi-M…    198    82 white      pale       yellow            92 male  mascu…
#> 2 Dooku        193    80 white      fair       brown            102 male  mascu…
#> 3 Jocasta …    167    NA white      fair       blue              NA fema… femin…
#> 4 C-3PO        167    75 <NA>       gold       yellow           112 none  mascu…
#> 5 R2-D2         96    32 <NA>       white, bl… red               33 none  mascu…
#> 6 R5-D4         97    32 <NA>       white, red red               NA none  mascu…
#> 7 Greedo       173    74 <NA>       green      black             44 male  mascu…
#> 8 Jabba De…    175  1358 <NA>       green-tan… orange           600 herm… mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
#> # A tibble: 8 × 14
#>   name      height  mass hair_color skin_color eye_color birth_year sex   gender
#>   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#> 1 Obi-Wan …    182    77 auburn, w… fair       blue-gray         57 male  mascu…
#> 2 Wilhuff …    180    NA auburn, g… fair       blue              64 male  mascu…
#> 3 Mon Moth…    150    NA auburn     fair       blue              48 fema… femin…
#> 4 C-3PO        167    75 <NA>       gold       yellow           112 none  mascu…
#> 5 R2-D2         96    32 <NA>       white, bl… red               33 none  mascu…
#> 6 R5-D4         97    32 <NA>       white, red red               NA none  mascu…
#> 7 Greedo       173    74 <NA>       green      black             44 male  mascu…
#> 8 Jabba De…    175  1358 <NA>       green-tan… orange           600 herm… mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```

{{< /tab >}}

#### 使用 `slice()` 根据行的位置选择行 {#slice}

使用 `slice()` 可以选择、删除和复制行：


``` r
starwars %>% slice(seq(1, nrow(.), 2)) # 选择奇数行
starwars %>% slice(-seq(1, nrow(.), 2)) # 去除奇数行
starwars %>% slice(rep(1, 10)) # 复制第 1 行 10 次
```

```
#> # A tibble: 44 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 Luke Sk…    172    77 blond      fair       blue            19   male  mascu…
#>  2 R2-D2        96    32 <NA>       white, bl… red             33   none  mascu…
#>  3 Leia Or…    150    49 brown      light      brown           19   fema… femin…
#>  4 Beru Wh…    165    75 brown      light      blue            47   fema… femin…
#>  5 Biggs D…    183    84 black      light      brown           24   male  mascu…
#>  6 Anakin …    188    84 blond      fair       blue            41.9 male  mascu…
#>  7 Chewbac…    228   112 brown      unknown    blue           200   male  mascu…
#>  8 Greedo      173    74 <NA>       green      black           44   male  mascu…
#>  9 Wedge A…    170    77 brown      fair       hazel           21   male  mascu…
#> 10 Yoda         66    17 white      green      brown          896   male  mascu…
#> # ℹ 34 more rows
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
#> # A tibble: 43 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 C-3PO       167    75 <NA>       gold       yellow         112   none  mascu…
#>  2 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
#>  3 Owen La…    178   120 brown, gr… light      blue            52   male  mascu…
#>  4 R5-D4        97    32 <NA>       white, red red             NA   none  mascu…
#>  5 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
#>  6 Wilhuff…    180    NA auburn, g… fair       blue            64   male  mascu…
#>  7 Han Solo    180    80 brown      fair       brown           29   male  mascu…
#>  8 Jabba D…    175  1358 <NA>       green-tan… orange         600   herm… mascu…
#>  9 Jek Ton…    180   110 brown      fair       blue            NA   <NA>  <NA>  
#> 10 Palpati…    170    75 grey       pale       yellow          82   male  mascu…
#> # ℹ 33 more rows
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
#> # A tibble: 10 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  2 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  3 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  4 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  5 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  6 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  7 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  8 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#>  9 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#> 10 Luke Sk…    172    77 blond      fair       blue              19 male  mascu…
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```

可以指定多个位置条件，效果就像是将多个条件合并一样：


``` r
starwars %>% slice(-seq(1, nrow(.), 2), -c(1:10))
```

```
#> # A tibble: 38 × 14
#>    name     height  mass hair_color skin_color eye_color birth_year sex   gender
#>    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
#>  1 Wilhuff…    180    NA auburn, g… fair       blue              64 male  mascu…
#>  2 Han Solo    180    80 brown      fair       brown             29 male  mascu…
#>  3 Jabba D…    175  1358 <NA>       green-tan… orange           600 herm… mascu…
#>  4 Jek Ton…    180   110 brown      fair       blue              NA <NA>  <NA>  
#>  5 Palpati…    170    75 grey       pale       yellow            82 male  mascu…
#>  6 IG-88       200   140 none       metal      red               15 none  mascu…
#>  7 Lando C…    177    79 black      dark       brown             31 male  mascu…
#>  8 Ackbar      180    83 none       brown mot… orange            41 male  mascu…
#>  9 Arvel C…     NA    NA brown      fair       brown             NA male  mascu…
#> 10 Nien Nu…    160    68 none       grey       black             NA male  mascu…
#> # ℹ 28 more rows
#> # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
#> #   vehicles <list>, starships <list>
```

{{< tab style="error" >}}
不能混合使用正、负位置。
{{< /tab >}}

注意相比之前的 `slice(seq(1, nrow(.), 2))`，这里只少了 5 行，而不是 10 行。

其他特化的 helper 函数：

- `slice_head()` 和 `slice_tail()` 分别选择头、尾数行，使用 `n` 参数指定行数。
- `slice_sample()` 随机选择数行，使用 `n` 参数指定行数或使用 `prop` 参数按比例指定行数。
    - 和 `sample()` 一样，可以使用 `replace` 参数指定放回（`TRUE`）或不放回（`FALSE`，默认）。
    - 使用 `weight_by` 参数可以进行加权抽样，改变行被抽中的概率。权重变量会被自动标准化以使得总和为 1（注意要先用 `filter()` 去除 `NA`）。

### 操纵列的单表格动词

#### 使用 `select()` 选择列

可以使用变量名（`height`）或变量名字符串（`"height"`）、作为一个向量（`select(c(height, "mass"))`）或作为多个参数（`starwars %>% select(height, "mass")`）指定要选择的列：


``` r
starwars %>% select(height, "mass")
```

```
#> # A tibble: 87 × 2
#>    height  mass
#>     <int> <dbl>
#>  1    172    77
#>  2    167    75
#>  3     96    32
#>  4    202   136
#>  5    150    49
#>  6    178   120
#>  7    165    75
#>  8     97    32
#>  9    183    84
#> 10    182    77
#> # ℹ 77 more rows
```

