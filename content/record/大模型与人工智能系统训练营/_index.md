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
- [声明](https://zh.cppreference.com/w/cpp/language/declarations)：示例中指出了复杂声明的解读法，建议认真阅读。
- [由内而外读法的机翻解释](https://learn.microsoft.com/zh-cn/cpp/c-language/interpreting-more-complex-declarators?view=msvc-170)。
- C++20 实现了[新的格式化方法](https://zh.cppreference.com/w/cpp/utility/format/format)
- 参数传递方式：
    - [形参与实参](https://stackoverflow.com/questions/156767/whats-the-difference-between-an-argument-and-a-parameter)：形参是 parameter，实参是 argument。
    - 按值传递：`int`，`int *`（地址也是值）
    - 按引用传递：
        - `int &`（左值引用，不可以是右值，否则传递之后临时变量就立即销毁了），`int const &`（左值常引用，可以接受右值，会延长临时变量的生命周期）
        - `int &&`：只能绑定到右值（即临时对象或不具名值），不能绑定到左值。没有普通引用和常引用之分。常用于移动语义和完美转发，提高程序性能。
- `static` 关键字：
    - 修饰函数：表示函数仅在当前编译单元（源文件）中可见。
    - 修饰变量：表示变量具有静态的存储周期，`static` 变量只初始化一次。且程序离开其作用域时，`static` 变量不会被销毁。全局变量一般都具有静态存储期。
- 编译期计算：
    - 常见情况：
        - 常量传播：当决定一个运行期变量值的其他变量（或函数）都是 `constexpr`，那么在编译期就会计算该变量的值。
        - `constexpr` 关键字：表示函数计算**可能**在编译期进行（使函数可用于初始化 `constexpr` 变量）或变量计算**必须**在编译期进行。
    - 注意：
        - 编译期计算通过编译期创建的“虚拟栈”完成，而栈有大小和（递归）深度的限制。
        - 函数各个参数，以及表达式的各个子表达式的求值顺序在编译期是不确定的、由编译期决定的（C++ 允许编译器以任何顺序求值子表达式，短路求值的操作符—— `&&` 和 `||` 例外），所以依赖这种顺序的表达式（如 `i++ + ++i`）和函数不应该放在编译期计算。
- [纯函数](https://zh.wikipedia.org/wiki/%E7%BA%AF%E5%87%BD%E6%95%B0)
    - 相同的输入总是返回相同的输出；
    - 没有副作用：纯函数不修改外部状态，也不依赖于外部状态。它不会修改全局变量、静态变量，或执行任何 I/O 操作（例如文件读写、打印输出等）。它的行为仅仅取决于输入参数。
        - 如果函数使用（可能修改了）的 `static` 变量是在函数内初始化，且不会使得函数在输出相同时的返回值。这时虽然在外部来看函数的行为与纯函数基本一致，但严格来说这个函数还是产生了副作用，可能在多线程环境中导致竞态条件（race condition）。
- [数组到指针的退化](https://zh.cppreference.com/w/cpp/language/array#%E6%95%B0%E7%BB%84%E5%88%B0%E6%8C%87%E9%92%88%E7%9A%84%E9%80%80%E5%8C%96)

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




