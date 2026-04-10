---
title: 2026-04-09
date: 2026-04-09T19:40:27+08:00
lastmod: 2026-04-10T12:09:24+08:00
comments: true
---

<!--more-->

## 为混合显卡安装驱动

1. 推荐使用 LTS 版本：`linux-lts` + `nvidia-open-lts`，避免过新导致的各种固件问题。
2. `nvidia-utils` 包含一个文件可以禁用 `nouveau` 模块。
3. Wayland 需要 KMS 来正确运行。560 以后的 NVIDIA 驱动默认启用 DRM（旧驱动需要 `nvidia-drm.modeset=1`），可以让 NVIDIA 支持[自动 KMS 晚加载](https://wiki.archlinux.org/title/Kernel_mode_setting#Late_KMS_start)。
    ```bash
    # 检查是否启用 DRM
    cat /sys/module/nvidia_drm/parameters/modeset
    ```
4. 早期加载：如果发现启动问题，如 `nvidia` 模块晚于显示管理器加载，可以将 `nvidia`，`nvidia_modeset`，`nvidia_uvm` 和 `nvidia_drm` 添加到 initramfs（见[早期内核模块加载](https://wiki.archlinux.org/title/Kernel_module#Early_module_loading)和 [`mkinitcpio` 的 MODULES 小节](https://wiki.archlinux.org/title/Mkinitcpio#MODULES)）。
5. 可以简单看看 Archwiki NVIDIA 页面的 [Wayland](https://wiki.archlinux.org/title/NVIDIA#Wayland_configuration) 和 [Xorg](https://wiki.archlinux.org/title/NVIDIA#Xorg_configuration) 的配置。
6. [PRIME render offload](https://wiki.archlinux.org/title/NVIDIA_Optimus#Using_PRIME_render_offload) 是 NVIDIA 官方支持的混合显卡配置方式。
    ```bash
    paru -S nvidia-prime xf86-video-amdgpu # 或 xf86-video-intel
    prime-run glxinfo | grep "OpenGL renderer"
    prime-run vulkaninfo
    ```
7. 如果需要使用休眠，参阅 [Preserve video memory after suspend](https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend)。对于 595+ 驱动，需要添加 `NVreg_UseKernelSuspendNotifiers=1` 内核参数。
    ```bash
    sort /proc/driver/nvidia/params
    # UseKernelSuspendNotifiers: 1
    ```

## 使用鼠标侧键

在 Plasma + Xorg 环境下，可以使用 `xbindkeys`：

```bash
sudo pacman -S xbindkeys xdotool
```

创建 `~/.xbindkeysrc` 文件：

```txt
"xdotool key Super_L+l"
b:8

"xdotool key Super_L+h"
b:9
```

为使 `xbindkeys` 自动启动，创建 `~/.local/bin/start-xbindkeys.sh` 和 `~/.config/systemd/user/xbindkeys.service` 文件：

```bash
#!/usr/bin/env bash
#
# Start xbindkeys daemon

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    exec /usr/bin/xbindkeys
fi

# test log
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE" >> /tmp/xbindkeys.log
```

```desktop
[Unit]
Description=xbindkeys (only for X11)
# stop with graphical-session.target
PartOf=graphical-session.target

[Service]
ExecStart=%h/.local/bin/start-xbindkeys.sh
Restart=on-failure

[Install]
# start with graphical-session.target
# equals to `add-wants` permanently
WantedBy=graphical-session.target
```

```bash
systemctl --user daemon-reload # 可能需要重新检测用户 services
systemctl --user enable --now xbindkeys # 会发现其实是链接到了 .../graphical-session.target.wants/ 目录下
```

> [!NOTE]
> `graphical-session.target` 见 `man 7 systemd.special`。

## 交换 ESC 和 CapsLock

> [!NOTE] XKB、X11 和 `xbindkeys` 的关系（ChatGPT）
> 硬件 → 内核(input) → XKB（键盘映射） → X11 → `xbindkeys` → 应用程序
> 
> 所以修改键盘映射应该用 `setxkbmap`，而绑定快捷键应该用 `xbindkeys`。

使用 X11 session 时，通过 KDE 的系统设置交换 ESC 和 CapsLock 不生效，推荐使用 `setxkbmap`：

```bash
# 交换 ESC 和 CapsLock
setxkbmap -option caps:swapescape
# 或者将 CapsLock 作为额外的 ESC
setxkbmap -option caps:escape
```

自动启用的方法同[使用鼠标侧键](#使用鼠标侧键)。

## 转移到 Wayland

> [!WARNING]
> Wayland 生态目前还不成熟（如输入法支持），暂不考虑使用。

[Plasma + Wayland + NVIDIA](https://community.kde.org/Plasma/Wayland/Nvidia)
