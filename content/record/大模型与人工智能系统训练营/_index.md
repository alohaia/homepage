---
title: "大模型与人工智能系统训练营"
date: 2025-01-23T15:05:54+08:00
lastmod: 2025-01-24T10:04:06+08:00
comments: true
math: false
---

上次看到 21:36。

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

- [学习视频](https://opencamp.cn/InfiniTensor/camp/2024summer/stage/1)
- [自动评分系统使用说明](https://github.com/LearningInfiniTensor/.github/blob/main/exam-grading-user-guide/doc.md)
- C++：
    - [C++ 习题项目](https://github.com/LearningInfiniTensor/learning-cxx)
    - [C++ 课程讲义](https://github.com/YdrMaster/notebook/blob/main/%E8%AE%AD%E7%BB%83%E8%90%A5/20240720-cxx.md)
    - [C++ 习题讲解](https://github.com/YdrMaster/notebook/blob/main/%E8%AE%AD%E7%BB%83%E8%90%A5/20240723-cxx-exercise.md)

{{< tab style="warning" summary="Conda 与 xmake" details=true >}}
Conda 会修改 \$CC、\$LD 等环境变量，导致 xmake 使用 conda 指定的程序。要使用系统默认程序可以使用 `xmake f --toolchain=gcc` 修改 xmake 设置或在 xmake.lua 中添加 `set_toolchains("gcc")`。
{{< /tab >}}


- [表达式](https://zh.cppreference.com/w/cpp/language/expressions)，[运算符和优先级](https://zh.cppreference.com/w/cpp/language/operator_precedence)，[运算符重载](https://zh.cppreference.com/w/cpp/language/operators)
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
- [由内而外读法的机翻解释](https://learn.microsoft.com/en-us/cpp/c-language/interpreting-more-complex-declarators?view=msvc-170)。
- C++20 实现了[新的格式化方法](https://zh.cppreference.com/w/cpp/utility/format/format)，需要 C++23 以上。
- `const int* p1` 和 `int* p2 const`：`p1` 指向的值不可变，`p2` 本身不可变。关键在 `const` 与 `*` 的位置关系。
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
        - [`constexpr` 说明符](https://zh.cppreference.com/w/cpp/language/constexpr)：表示函数计算**可能**在编译期进行（使函数可用于初始化 `constexpr` 变量）或变量计算**必须**在编译期进行。
    - 注意：
        - 编译期计算通过编译期创建的“虚拟栈”完成，而栈有大小和（递归）深度的限制。
        - 函数各个参数，以及表达式的各个子表达式的求值顺序在编译期是不确定的、由编译期决定的（C++ 允许编译器以任何顺序求值子表达式，短路求值的操作符—— `&&` 和 `||` 例外），所以依赖这种顺序的表达式（如 `i++ + ++i`）和函数不应该放在编译期计算。
- [纯函数](https://zh.wikipedia.org/wiki/%E7%BA%AF%E5%87%BD%E6%95%B0)
    - 相同的输入总是返回相同的输出；
    - 没有副作用：纯函数不修改外部状态，也不依赖于外部状态。它不会修改全局变量、静态变量，或执行任何 I/O 操作（例如文件读写、打印输出等）。它的行为仅仅取决于输入参数。
        - 如果函数使用（可能修改了）的 `static` 变量是在函数内初始化，且不会使得函数在输出相同时的返回值。这时虽然在外部来看函数的行为与纯函数基本一致，但严格来说这个函数还是产生了副作用，可能在多线程环境中导致竞态条件（race condition）。
- [数组到指针的退化](https://zh.cppreference.com/w/cpp/language/array#%E6%95%B0%E7%BB%84%E5%88%B0%E6%8C%87%E9%92%88%E7%9A%84%E9%80%80%E5%8C%96)
- [类型双关](https://tttapa.github.io/Pages/Programming/Cpp/Practices/type-punning.html)：
    - 强转指针：可以通过改变指针类型来实现类型双关，不过这是未定义行为。
    - 可以使用 `union`（表示在同一内存位置存储的不同类型的值）实现类型双关，但这种写法实际上仅在 C 语言良定义，在 C++ 中是未定义行为（因为如果联合体的一个成员如果有构造器或析构器的话，直接双关转换可能会绕过构造器或析构器）。
    - 另外，访问联合体的非活动成员会使得访问的函数无法成为 `constexpr` 函数（因为 `constexpr` 中不能出现未定义行为）。
    - 从 C++20 开始，可以使用 [`std::bit_cast`](https://zh.cppreference.com/w/cpp/numeric/bit_cast)（注意它自带 `constexpr` 说明符），在不改变比特位的情况下，将一个类型的对象转换为另一个类型。它类似于 `reinterpret_cast`，但更安全，因为它要求源类型和目标类型的大小相同，并且都是可平凡复制的（trivially copyable）C++ 中的一个类型特性，表示该类型的对象可以通过简单的内存拷贝（如 `memcpy`）来复制）。而且 `std::bit_cast` 由于对自身添加了限制而能在 `constexpr` 中使用。
- [枚举](https://zh.cppreference.com/w/cpp/language/enum)：`enum class Color : int { /* ... */ };`
- [普通、标准布局、POD 和文本类型](https://learn.microsoft.com/en-us/cpp/cpp/trivial-standard-layout-and-pod-types)
- [各种初始化](https://zh.cppreference.com/w/cpp/language/initialization)
- [成员函数（cv 限定符）](https://zh.cppreference.com/w/cpp/language/member_functions)：`constexpr` 或 `const` 结构体只能调用 `const` 成员函数，如 `int get(int i) const { /* ... */ }`
  > 本质上，方法是隐藏了 this 参数的函数。`const` 修饰作用在 this 上。
- C++ 中，`class` 和 `struct` 之间的**唯一区别**是：`class` 默认访问控制符是 `private`，`struct` 默认访问控制符是 `public`。
- 成员初始化的方式：
    - 在构造函数内部初始化。常量成员**不能**再构造函数内部初始化。
    - 在成员声明时直接初始化。
    - 成员初始化器：在声明成员时使用初始化器进行初始化，如 `std::string s{'a', 'b', 'c'};`
    - 成员初始化器列表（优先级高于默认成员初始化器）：在构造函数上使用——`Mystruct() : n(10), s {'a', 'b', 'c'} {};`
        - 可以使用构造函数指定的大小初始化成员：`DynFibonacci(int capacity): cache(new size_t[capacity]{0, 1}), cached(2) {}`。
            - 记得在析构函数释放 `new` 分配的内存：`delete[] cache`。
            - 需要时可以使用 `std::memcpy` 复制变量内存：`std::memcpy(cache, df.cache, cached * sizeof(size_t));`
- 移动语义：
    - 左值右值：[概念（微软）](https://learn.microsoft.com/en-us/cpp/c-language/l-value-and-r-value-expressions)，[细节（cpp reference）](https://zh.cppreference.com/w/cpp/language/value_category)
    - [关于移动语义](https://learn.microsoft.com/zh-cn/cpp/cpp/rvalue-reference-declarator-amp-amp#move-semantics)，[如何实现移动构造](https://learn.microsoft.com/zh-cn/cpp/cpp/move-constructors-and-move-assignment-operators-cpp)
    - [移动构造函数](https://zh.cppreference.com/w/cpp/language/move_constructor)，[移动赋值](https://zh.cppreference.com/w/cpp/language/move_assignment)
    - 右值就是一个“不是变量，但可变，准备移动并在移动后销毁”
    - C++ 移动语义需要显式声明：接受方用 `<type> &&`（表示是右值引用），被接收方用 `std::move`（转换为右值，通过 `static_cast` 强制转换实现）
    - 注意，如果将右值放在等号左边会被编译器静默地转换为左值
    - 除少数类型（如 `std::unique_ptr`）以外，原变量（如实参）通过移动语义被“窃取”曾保有的资源后，其状态是不确定的。
    - 移动来的对象在使用完之后，需要将其中的指针置空，以避免重复调用析构函数。可以使用 `std::exchange` 完成，该函数将第一个参数的值返回，再将第一个参数的实参值改为第二个参数。
    - C++ 标准中约定，移动构造和移动复制不应该抛出异常，所以可以指定为 `noexcept`
    - 移动构造和移动赋值应该首先检查是否是移动自己；移动赋值应该先释放原对象动态分配的内存。此外，赋值操作最后都应该返回自己的左值引用 `return *this;`（连续的赋值表达式，规定要从右到左进行）。
- `= delete`：显示弃置。`int f() = delete;` 表示显示弃置函数 `f`。常用于模板函数的示例，显示地禁止使用模板函数的某一实例。



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




