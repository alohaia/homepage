---
title: "WMware 安装"
date: 2026-01-22T10:13:14+08:00
lastmod: 2026-01-22T10:14:20+08:00
comments: true
math: false
tags:
    - Linux
---

```bash
paru -Sy wmware-workstation vmware-keymaps

sudo modprobe -a vmw_vmci vmmon

# 按需加载服务
sudo systemctl disable vmware-networks.service
sudo systemctl enable --now vmware-networks.path
sudo systemctl disable vmware-usbarbitrator.service
sudo systemctl enable --now vmware-usbarbitrator.path
```


## MT7921/MT7922 网卡问题

```bash
sudo nano /etc/modprobe.d/mt7921e.conf
```

```
options mt7921e disable_aspm=Y
options mt7921e power_save=0
```


```bash
sudo mkinitcpio -P
```
