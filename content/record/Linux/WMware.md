---
title: "WMware 安装"
date: 2026-01-22T10:13:14+08:00
lastmod: 2026-03-31T14:43:37+08:00
comments: true
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


