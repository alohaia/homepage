---
title: "流体力学"
date: 2026-04-17T14:24:50+08:00
lastmod: 2026-04-22T01:16:30+08:00
comments: true
tags:
    - 流体力学
    - OpenFOAM
---

<!--more-->

[OPENFOAM.com 与 OPENFOAM.org](https://www.cfd-online.com/Forums/openfoam/197150-openfoam-com-versus-openfoam-org-version-use.html)：几乎没有差别，随便选一个即可。

建议安装 [arch4edu](https://github.com/arch4edu/arch4edu/wiki/Add-arch4edu-to-your-Archlinux) 的预编译 `openfoam`：

```bash
paru -S arch4edu/openfoam-org
```

> [!NOTE]
> This install of OpenFOAM does NOT include the
> ThirdParty libraries from openfoam's website.
> It simply creates a stub OpenFOAM/ThirdParty
> directory to keep the OpenFOAM bashrc happy.
> 
> If you need other components of the ThirdParty bundle
> it will have to be installed manually.
> See http://www.openfoam.com/download/source.php for details.
> 
> Don't forget to run the "ofoam" alias in order to
> source the OpenFOAM environment (PATH + LD_LIBRARY_PATH).
> This alias has been introduced in order to avoid
> PATH clashes (e.g. other executables such as R from GNU R)
> 
> If this is the first time installing OpenFOAM, you will need
> to log out and back in
>  *or*: $ source /etc/profile.d/openfoam-13.sh
> 
> Then type $ ofoam
> 
> OpenFOAM installs to /opt/OpenFOAM/OpenFOAM-13


参考：

- [4D Flow MRI-Based CFD for Flow Dynamics Assessment in Coarctation of the Aorta](https://www.youtube.com/watch?v=4PUK-pOH22c)
