---
title: 2025-04-04
date: 2025-04-04T12:36:42+08:00
lastmod: 2025-04-04T14:05:53+08:00
draft: true
comments: true
math: false
---

<!--more-->

```r
install.packages(c("cols4all", "kableExtra", "colorblindcheck"))
c4a_gui()
```

```r
DotPlot(tls, cluster.idents = TRUE, features = marker_list) +
    scale_y_discrete(limits = y_limits) +
    scale_color_continuous_c4a_seq('carto.fall', reverse = F) +
    theme(axis.text.x = element_text(angle = 60, hjust = 1))
```
