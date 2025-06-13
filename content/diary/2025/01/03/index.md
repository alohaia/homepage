---
title: 2025-01-03
date: 2025-01-03T00:14:19+08:00
lastmod: 2025-03-28T10:38:19+08:00
comments: true
math: false
---

<!--more-->

```bash
/opt/anaconda/bin/conda init zsh
```

`~/.condarc`:

```
channels:
  - https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
custom_channels:
  auto: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
show_channel_urls: true
# solver: libmamba
```
