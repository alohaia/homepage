---
title: 2024-10-18
date: 2024-10-18T00:23:00+08:00
lastmod: 2024-10-18T13:16:55+08:00
comments: true
math: false
---

<!--more-->

## `linux-zen` 内核和 NVIDIA 显卡驱动

使用 `linux-zen` 内核的话，需要安装 `nvidia-dkms` 包（替代 `nvidia` 包）。记得运行：

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## 启用系统休眠

- 在 `/etc/mkinitcpio.conf` 添加 `resume` 钩子。
  ```xxx
  HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)
  ```
- 在 `/etc/default/grub` 中设置 resume 参数：
  ```
  GRUB_CMDLINE_LINUX_DEFAULT="... resume=UUID=547...0282"
  ```

{{< tab style="success" >}}
在 `mkinitcpio` 时出现的提示固件缺失的警告信息，一般可以忽视。但如果不想收到这些警告信息，可以安装 AUR 的 [mkinitcpio-firmware](https://aur.archlinux.org/packages/mkinitcpio-firmware) 包。这个包安装需要一些时间，但很少更新。
{{< /tab >}}

## 其他内核钩子设置

- 使用 `btrfs` 作为根目录文件系统时，不需要 `fsck` 钩子，在 `/etc/mkinitcpio.conf` 中删掉它。
- 不需要更改终端字体时，可以删掉 `/etc/mkinitcpio.conf` 中的 `consolefont` 钩子。

[^1]: https://bbs.archlinux.org/viewtopic.php?pid=1293329#p1293329

将 `kms` 从 `/etc/mkinitcpio.conf` 里的 `HOOKS` 数组中移除，并重新生成 initramfs。 这能防止 initramfs 包含 `nouveau` 模块，以确保内核在早启动阶段不会加载它。nvidia-utils 包 软件包包含一个文件，其将会在重启后屏蔽 nouveau 内核模块。
