---
title: Realtek 驱动
date: 2026-03-14T10:21:04+08:00
lastmod: 2026-03-31T17:00:45+08:00
comments: true
---

<!--more-->

## MT7921/MT7922 网卡问题

> [!NOTE]
> 注意驱动名称 ≠ 芯片型号。`mt7921e` 是 Linux 内核中的一个驱动模块（module），负责驱动 MediaTek
> MT79xx 系列 WIFI 芯片，工作在 PCI**e** 接口。保留“7921”的名称是处于历史原因。

```bash
sudo echo "options mt7921e disable_aspm=1" >> /etc/modprobe.d/mt7921e.conf
cat /sys/module/mt7921e/parameters/disable_aspm # after reboot
```

## Realtek 驱动

2026-03-10 15:28 UTC [linux-firmware-realtek](https://gitlab.com/kernel-firmware/linux-firmware/-/commits/main?ref_type=heads&search=mt7922) 驱动更新，包含 MT7922 相关内容。

2026-03-21 貌似没有解决，还是会出现开机掉网卡的 BUG。
