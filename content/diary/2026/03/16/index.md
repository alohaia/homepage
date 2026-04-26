---
title: 2026-03-16
date: 2026-03-16T14:49:16+08:00
lastmod: 2026-04-17T14:09:13+08:00
comments: true
---

<!--more-->

## Zotero 同步失败

大概率是代理问题，设置直接连接（`network.proxy.type = 0`）即可。

- [kb:connection_error \[Zotero Documentation\]](https://www.zotero.org/support/kb/connection_error)
- [Network.proxy.type - MozillaZine Knowledge Base](https://kb.mozillazine.org/Network.proxy.type)

## Hugo 自定义 blockquote

> Default markdown blockquote.

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.


> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.

扩展语法——[可折叠的 blockquote](https://gohugo.io/render-hooks/blockquotes/#extended-syntax)：

> [!WARNING]+ Radiation hazard
> Do not approach or handle without protective gear.
