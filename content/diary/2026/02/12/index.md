---
title: ggplot2 中的尺寸
date: 2026-02-12T12:05:45+08:00
lastmod: 2026-02-12T19:33:31+08:00
comments: true
math: false
---

<!--more-->

## ggplot2 中的尺寸

`ggplot2` 中 `linewidth` 和 `size` 的单位是 mm，`lwd`（line width）是一个无单位的缩放系数。于是
 `ggplot2` 提供了`.pt` 和 `.stroke` 两个用于单位转换的常量：

- `.pt`：单位为 pt / mm，8 pt 可以表示为 `8 / .pt`。
- `.stroke`：不推荐用户使用。


[测试](https://ggplot2.tidyverse.org/articles/ggplot2-测试specs.html)

https://ggplot2.tidyverse.org/articles/ggplot2-%e6%b5%8b%e8%af%95specs.html

- 线条：

> Due to a historical error, the unit of `linewidth` is **roughly 0.75 mm**. Making it exactly 1 mm 
would change a very large number of existing plots, so we’re stuck with this mistake.

- 点：

> While `colour` applies to all shapes, `fill` only applies to shapes 21-25, as can be seen 
above. The size of the filled part is controlled by `size`, the size of the stroke is controlled by 
`stroke`. Each is measured in **mm**, and the total size of the point is the sum of the two. Note 
that the size is constant along the diagonal in the following figure.

- 文本：

> The size of text is measured in **mm** by default. This is unusual, but makes the size of text 
consistent with the size of lines and points. Typically you specify font size using points (or pt 
for short), where 1 pt = 0.35mm. In `geom_text()` and `geom_label()`, you can set `size.unit = "pt"` 
to use points instead of millimeters. In addition, ggplot2 provides a conversion factor as the 
variable .pt, so if you want to draw 12pt text, you can also set `size = 12 / .pt`.


``` r
library(ggplot2)
# Source - https://stackoverflow.com/q/75894278
# Posted by D Ogle, modified by community. See post 'Timeline' for change history
# Retrieved 2026-02-12, License - CC BY-SA 4.0

ggplot() +
  geom_hline(yintercept=1,linewidth=20) +
  geom_text(data=data.frame(x=0.5,y=1,label="Text"),
            mapping=aes(x=x,y=y,label=label),
            size=20,color="red") +
  geom_point(data=data.frame(x=0.4,y=1),mapping=aes(x=x,y=y),
             pch=21,size=10,stroke=10,fill="red",color="blue") +
  geom_point(data=data.frame(x=0.6,y=1),mapping=aes(x=x,y=y),
             pch=21,size=20,stroke=0,fill="orange") +
  geom_point(data=data.frame(x=0.7,y=1),mapping=aes(x=x,y=y),
             pch=21,size=0,stroke=20,color="green") +
  geom_point(data=data.frame(x=0.8,y=1),mapping=aes(x=x,y=y),
             pch=21,size=10,stroke=10*0.75,fill="orange",color="green") +
  scale_x_continuous(limit=c(0.35,0.85)) +
  theme_void()
```

{{< figure src="/R-figures/diary/2026/02/12/size_test-1.png" group="size_test" alt="size_test" >}}


## 调试 render-link.html

https://discourse.gohugo.io/t/solved-destination-from-rel-or-relref-does-has-unexpect-prefix/42848/2


