---
title: "Godot 入门"
date: 2026-11-16T16:43:32+08:00
lastmod: 2026-11-19T20:11:14+08:00
comments: true
tags:
    - Godot
---

<!--more-->

Godot 官方推荐使用 GDScript 编写游戏程序，推荐使用 [Learn GDScript From Zero](https://gdquest.github.io/learn-gdscript/) 学习。

## 未整理

`_process(delta)` 函数会在每一帧都运行，`delta` 表示前一帧花费的时间，单位是秒。

使用 `[...]` 创建数组。Godot 中的数组可以包含不同类型的值：


```godot
[1, 2, 3, 4]
[Vector2(1, 2), 1.5 -1]
```

GDScript 的索引从零开始，支持负索引。


## 类型

类型转换：`str()`，`int()`，`float()`。注意 GDScript 的类型较为严格，类似 C 语言，`3 / 2` 会得到 `1`。

GDScript 是一种动态类型语言，可以使用 `var` 关键词创建可以储存任意类型数据的变量。实践中，代码量过大时最好显式指定类型，这样定义变量之后不能赋值其他类型的值。

```godot
var cell_size: Vector2 = Vector2(20.0, 20.0)
# 或者自动推断类型
var cell_size:= Vector2(20.0, 20.0)

cell_size = 20.0 # !!! ERROR
```


## 信号（Signals）

Godot 通过信号实现了[观察者模式](https://gameprogrammingpatterns.com/observer.html)。

> That’s what the ***observer pattern*** is for. It lets one piece of code announce that something interesting happened without actually caring who receives the notification.
