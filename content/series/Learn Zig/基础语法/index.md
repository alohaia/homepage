---
title: "基础语法"
date: 2026-11-25T18:55:33+08:00
lastmod: 2026-11-25T23:18:59+08:00
comments: true
weight: 1
tags:
    - Zig
---


```zig
const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");
    // std.debug.print("Hello, {s}!\n", .{"World"});  // simple print, use this normally
}
```

```bash
zig build-exe hello.zig && ./hello
```

    Hello, World!

<!--more-->


## 注释 {alias="Comments"}
