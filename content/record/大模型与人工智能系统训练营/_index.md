---
title: "大模型与人工智能系统训练营"
date: 2025-01-23T15:05:54+08:00
lastmod: 2025-01-24T10:04:06+08:00
comments: true
math: false
---

<!--more-->

[大模型与人工智能系统训练营（2024冬季）](https://opencamp.cn/InfiniTensor/camp/2024winter)

- [digit-layout](https://crates.io/crates/digit-layout)：在 Rust 中定义代数类型

## 基本概念

- 张量（tensor）：在程序上就是一个高维数组，看起来是高度同质、非结构化的，但其实有隐藏的、人类无法直观理解的结构在其中。
- 形状（shape）：每一个维度的大小，一般表示为 y \* x 或 z \* y \* x 这样的形式。
- 步长（strides）：在每一个维度前进一个数字，实际经过的数字数量，还会在前面加上总的数字个数，表示为如 n sz sy sx 的格式。如一个形状为 2 \* 3 \* 4 的三维数组的步长为 (24) 12 4 1。

## 语言基础

### C++ 基础

> C++ 格式化输出推荐使用 [fmtlib](https://github.com/fmtlib/fmt) 库，不要用标准库的流式格式化。

通过借鉴 `fmtlib`，C++20 实现了[新的格式化方法](https://zh.cppreference.com/w/cpp/utility/format/format) `std::format` 等，语法和性能与前者基本一致。文档中说明了几点注意事项，如可以提供多于格式字符串所要求的实参，以及格式字符串需要是常量表达式，否则应该使用 `std::vformat` 格式化或使用 `std::runtime_format` 提供格式化字符串。

> C++ exception 机制，不推荐使用。

- [学习视频](https://opencamp.cn/InfiniTensor/camp/2024summer/stage/1?tab=video)
- [自动评分系统使用说明](https://github.com/LearningInfiniTensor/.github/blob/main/exam-grading-user-guide/doc.md)
- C++：
    - [C++ 习题项目](https://github.com/LearningInfiniTensor/learning-cxx)
    - [C++ 课程讲义](https://github.com/YdrMaster/notebook/blob/main/%E5%A4%A7%E6%A8%A1%E5%9E%8B/20240720-cxx.md)
    - [C++ 习题讲解](https://github.com/YdrMaster/notebook/blob/main/%E5%A4%A7%E6%A8%A1%E5%9E%8B/20240723-cxx-exercise.md)

{{< tab style="warning" summary="Conda 与 xmake" details=true >}}
Conda 会修改 \$CC、\$LD 等环境变量，导致 xmake 使用 conda 指定的程序。要使用系统默认程序可以使用 `xmake f --toolchain=gcc` 修改 xmake 设置或在 xmake.lua 中添加 `set_toolchains("gcc")`。
{{< /tab >}}


- C++20 实现了[新的格式化方法](https://zh.cppreference.com/w/cpp/utility/format/format)
- C++ 的输入/输出操纵符（流修饰符）可改变流的一些行为，如 `std::boolalpha` 可将布尔值输出为字符串（默认输出为 0 或 1）。注意修饰符的作用是会在多个语句中持续的：
  ```cpp
  {
      std::cout << std::boolalpha;
  }
  {
      std::cout << true << std::endl;
  }
  {
      std::cout << false << std::endl;
  }
  ```
- 终端流重定向的注意事项：
    - `1`、`2`、`>`、`&` 之间不能有空格
    - `>` 与 `1>` 等价。
    - `>` 后面的文件描述符需要前接一个 `&` 符号，避免被错误地识别为文件名。
    - `>` 前面的 `&` 有特殊作用：`command &> output.txt` 是 `command > output.txt 2>&1` 的简写形式，会将标准输出和标准错误都写入 output.txt。
    - **顺序很重要：**`command 2>&1 > output.txt` 会先将文件描述符 2 绑定到文件描述符 1 的当前目标（终端）（实际没有改变什么），再将默认的文件描述符 1 绑定到 output.txt。
- 形参是 parameter，实参是 argument。

### Rust 基础

- Rust：
    - [Rust 习题项目（Rustlings）](https://rustlings.cool/)

      ```bash
      cargo install rustlings
      rustlings init
      ```

        - 推荐同步阅读 [the official Rust book](https://doc.rust-lang.org/book/)。
        - [Rust By Example](https://doc.rust-lang.org/rust-by-example/)
    - [Rust 基本概念](https://github.com/YdrMaster/notebook/blob/main/%E5%A4%A7%E6%A8%A1%E5%9E%8B/20240720-rust.md)
    - [Rust 重点语法讲义](https://github.com/YdrMaster/notebook/blob/main/%E5%A4%A7%E6%A8%A1%E5%9E%8B/20240724-rust-grammar.md)




