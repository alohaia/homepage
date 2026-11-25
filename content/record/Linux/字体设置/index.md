---
title: "字体设置"
date: 2026-11-25T18:32:07+08:00
lastmod: 2026-11-25T18:43:32+08:00
comments: true
---

<!--more-->

## 使用 Windows 字体

挂载 Windows C 盘（如 `/windows/`），并添加 `~/.config/fontconfig/conf.d/99-windows-fonts.conf` 文件：

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <!-- 直接引用 Windows 字体目录（只读 NTFS 挂载，不复制）。
       字体文件自带中英文双语 family name（SimSun/宋体 等），
       WPS/LibreOffice 按文档里的字体名即可精确命中。 -->
  <dir>/windows/Windows/Fonts</dir>

  <!-- Windows 上存在、Linux 字体表里没有的写法，做等价映射 -->
  <alias binding="same"><family>Microsoft YaHei UI</family><prefer><family>Microsoft YaHei</family></prefer></alias>
  <alias binding="same"><family>微软雅黑 UI</family><prefer><family>Microsoft YaHei UI</family></prefer></alias>

  <!-- 公文/老模板常用的 GB2312 写法：Windows 里就是 仿宋/楷体 -->
  <alias binding="same"><family>仿宋_GB2312</family><prefer><family>仿宋</family></prefer></alias>
  <alias binding="same"><family>楷体_GB2312</family><prefer><family>楷体</family></prefer></alias>
  <alias binding="same"><family>FangSong_GB2312</family><prefer><family>FangSong</family></prefer></alias>
  <alias binding="same"><family>KaiTi_GB2312</family><prefer><family>KaiTi</family></prefer></alias>
</fontconfig>
```

## 设置 monospace 字体

```xml
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
<fontconfig>

 <!-- ... -->

  <alias>
    <family>monospace</family>
    <prefer>
      <family>Maple Mono NF CN</family>
    </prefer>
  </alias>
</fontconfig>
```
