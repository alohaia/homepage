---
title: 2024-12-07
date: 2024-12-07T16:59:31+08:00
lastmod: 2024-12-08T21:34:55+08:00
comments: true
math: false
---

<!--more-->

## ArchLinux wiki（失败）

### NVIDIA 独立显卡驱动

1. 安装 nvida（linux 内核）/nvida-lts（linux-lts 内核）或 nvida-dkms（linux-zen 等内核）
2. 安装内核对应的 headers 包（如 linux-zen-headers）


- https://wiki.archlinuxcn.org/wiki/NVIDIA
    - nvidia-utils 包 560.35.03-5 版本后默认启用 DRM (Direct Rendering Manager) 内核级显示模式设置。对于更旧的版本，请为nvidia_drm模块设置内核模块参数 modeset=1。
      ```
      GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 nvidia-drm.modeset=1"
      ```

### AMD 集成显卡驱动

- https://wiki.archlinux.org/title/Xorg#AMD
- https://wiki.archlinux.org/title/AMDGPU

### PRIME render offload

安装 `nvidia-prime` 包，默认使用 modesetting、`xf86-video-amdgpu` 或 `xf86-video-intel` 驱动，在需要时手动使用 `prime-run` 脚本切换到 NVIDIA 显卡：

```zsh
prime-run glxinfo | grep "OpenGL renderer"
prime-run vulkaninfo
```

### 参考资料

https://wiki.archlinuxcn.org/wiki/NVIDIA

混合图形：

- https://wiki.archlinux.org/title/Hybrid_graphics#Dynamic_switching
- https://wiki.archlinux.org/title/Bumblebee
- https://wiki.archlinux.org/title/PRIME
- ~~https://wiki.archlinux.org/title/NVIDIA_Optimus~~
    - [optimus-manager](https://github.com/Askannz/optimus-manager)：
    > On Wayland the Nvidia GPU is used for high performance apps which use GLX or Vulkan. While the integrated GPU for no so demanding apps which use EGL, like the desktop itself and the web browser. This behavior is not configurable.
    - [Installation](https://github.com/Askannz/optimus-manager?tab=readme-ov-file#-installation)

> - NV 的闭源驱动请参考 NVIDIA Optimus 和 Bumblebee
> - 其它驱动，包括 NV Nouveau 开源驱动和 AMD Radeon 请参考 PRIME



## ArchLinux Tutorial（失败）

[Arch Linux 安装教程 - 显卡驱动](https://archlinuxstudio.github.io/ArchLinuxTutorial/#/rookie/graphic_driver)

### AMD 核芯显卡

> 所有 AMD 显卡建议使用开源驱动。英伟达显卡建议使用闭源驱动，因为逆向工程的开源驱动性能过于低下，本文也只描述英伟达闭源驱动安装。如果你支持自由软件运动，请尽可能使用具有官方支持开源驱动的英特尔和 AMD 显卡。

{{< tab style="success" summary="AMD 闭源驱动" details=true >}}
> 所有 AMD 显卡建议使用开源驱动。

但是 archwiki 中早就提供了 AMDGPU PRO 闭源驱动（[amdgpu-pro-installer](https://aur.archlinux.org/pkgbase/amdgpu-pro-installer) AUR 包）的选项。
{{< /tab >}}

1. 确定核显：在 [techpowerup](https://www.techpowerup.com/) 搜索 AMD Ryzen 7 8845H 或 AMD Ryzen 7 8845HS（[两者区别](https://zhidao.baidu.com/question/147651752962546325.html)），发现它使用 Radeon 780M 集成显卡：
    > This processor features the Radeon 780M integrated graphics solution.
2. 在 [techpowerup](https://www.techpowerup.com/) 搜索 `Radeon 780M`，发现其使用 `RDNA 3.0` 架构：
    > Architecture: RDNA 3.0
3. 对照 [arch 官方文档](https://wiki.archlinux.org/title/Xorg#AMD)，你可选择安装 [AMDGPU](https://wiki.archlinux.org/title/AMDGPU) 开源驱动（或 [AMDGPU PRO](https://wiki.archlinux.org/title/AMDGPU_PRO) 闭源驱动？）

根据 ArchLinux Tutorial 的说明，安装如下包即可：

```zsh
sudo pacman -S mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau
```

### 英伟达独立显卡

```zsh
sudo pacman -S nvidia-dkms nvidia-settings nvidia-utils lib32-nvidia-utils
```

## 其他

```txt
No fsck helpers found. fsck will not be run on boot.
```

> https://bbs.archlinux.org/viewtopic.php?id=139370
> The fsck hook is meant to fsck the root partition before being mounted, so that you don't have to mount ro and then potentially wait for another boot if errors are found.  It just makes more sense to fsck at that point.  But if you use btrfs for your root filesystem, then you should probably just remove the fsck hook altogether.  There is no reason to try to fsck the unfsckable, and the systemd-fsck@.service will take care of any other fsckable filesystems you may have.
> fsck 钩子用于在挂载根分区之前 fsck 根分区，这样你就不必挂载 ro，然后在发现错误时可能等待另一次启动。在那个时候 fsck 更有意义。但是如果你对根文件系统使用 btrfs，那么你可能应该完全删除 fsck 钩子。没有理由尝试 fsck unfsckable，systemd-fsck@.service 将处理您可能拥有的任何其他 fsckable 文件系统。


