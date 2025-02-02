---
title: "Python 与数据科学"
date: 2024-11-14T22:47:17+08:00
lastmod: 2024-11-14T23:17:59+08:00
comments: true
math: false
weight: 0
tags:
    - Python
---

<!--more-->

{{< tab style="warning" summary="" details=false >}}
It is not recommended to install `pipx` via `pipx`. If you'd like to do this anyway, take a look at the [`pipx-in-pipx`](https://github.com/mattsb42-meta/pipx-in-pipx) project and read about the limitations there.
{{< /tab >}}

## Tips

在 Arch Linux 系统中（在其他 Linux 系统中可能也是），如果尝试直接用 pip 安装 Python 包，会提示错误：

    error: externally-managed-environment

    × This environment is externally managed
    ╰─> To install Python packages system-wide, try 'pacman -S
        python-xyz', where xyz is the package you are trying to
        install.

        If you wish to install a non-Arch-packaged Python package,
        create a virtual environment using 'python -m venv path/to/venv'.
        Then use path/to/venv/bin/python and path/to/venv/bin/pip.

        If you wish to install a non-Arch packaged Python application,
        it may be easiest to use 'pipx install xyz', which will manage a
        virtual environment for you. Make sure you have python-pipx
        installed via pacman.


