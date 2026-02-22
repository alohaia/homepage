---
title: "熟悉 LaTeX"
date: 2026-02-22T11:53:19+08:00
lastmod: 2026-02-22T20:26:25+08:00
comments: true
math: true
weight: 1
tags:
    - LaTeX
---

> $\LaTeX$ 是一种基于 $\TeX$ 的文档排版系统。

<!--more-->

## LaTeX 环境（Arch Linux）

- `texlive` 包组
- `texlive-lang` 包组：包含对中文、CJK 等语言的支持，如 xeCJK 宏包。

{{% tab type="info" %}}
xeCJK 基于强大的 fontspec 宏包，允许你直接调用操作系统中安装的任何 TrueType 或 OpenType 字体。它不再需要环境包裹，你可以在文档中直接输入中文，引擎会自动识别并处理。

`latex` 和 `pdflatex` 命令都默认使用 CJK 宏包，而 `xelatex` 则默认使用新的 xeCJK 宏包。

与 CJK 宏包对比的优势：

1. 直接输入中英文：你可以像平常打字一样，中英文混输，xeCJK 会在后台自动识别和处理，不再需要 `\begin{CJK}`。
2. 直接调用系统字体：只需通过 `\setCJKmainfont{宋体}` 这样简单的命令，就能直接使用你电脑里的字体。
3. 排版更精致：它能自动处理中英文之间的间距、中文标点禁则（如句号、逗号不能出现在行首）等复杂排版规则。
{{% /tab %}}

### 中文支持

推荐使用 Vimtex + `latexmk` + XeTeX 引擎（LuaTex 引擎不支持 xeCJK），支持中文的方法有两种：

```latex
%-*- coding: UTF-8 -*-
%! TeX program = xelatex

% 使用 ctexart documentclass 支持中文，内部调用了 xeCJK
\documentclass[UTF8]{ctexart}

% 或者使用 xeCJK 宏包支持中文
\documentclass{article}
\usepackage{fontspec}
\usepackage{xeCJK}
% \setmainfont{Noto Serif}
\setCJKmainfont{Noto Serif CJK SC}
```

## LaTeX 基础

### LaTeX 书写注意事项

1. LaTeX 自动进行文字缩进，因此**段前不用打空格**，即使有空格有会被忽略。
2. 通常**汉字后面的空格会被忽略，而其他符号后面的空格会被保留**。使用 `xelatex` 编译时，`ctexart` 会自动处理汉字与其他字符之间的距离，无论有没有手动打空格。
3. **单个换行符与一个空格等价**，一般起优化代码视觉效果的作用，因此需要**使用空行分段**。
4. 其他：
    1. 两个减号 `--` 会输出一个 “**en dash**” --（宽度相当于字母 n 的短线），通常用于表示数字范围。
    2. ISO 标准对科技文档要求表示圆周率常数的 $\pi$ 使用直立体。

### LaTeX 声明和分组

`\zihao`，`\kaishu` 等命令会影响后面所有文字，直到整个*分组*结束，这种命令称为**声明**。

**分组**限定了*声明*的范围，可以通过*环境*（`\begin{xxx} ... \end{xxx}`）或*花括号*（`{...}`）生成一个分组。

## LaTeX 相关工具

常用命令行工具：

- GhostScript：一种 PostScript 解释器。在 $\TeX$ Live 中，包含一个简化版本，程序名为 `rungs`。最好安装完整的 GhostScript（主程序为 `gs`/`ghostscript`）（Arch Linux 通过 ... <- texlive-latex <- dvisvgm <- ghostscript 依赖会自动安装）。
- ImageMagick: 一个基于命令行的位图处理软件。其中 `convert`（`/usr/bin/convert`）命令最常用，用来转换图片格式，如：

  ```bash
  convert foo.bmp bar.png
  ```

  可以用来转换 PostScript 和 PDF 格式的图片，不过内部实际还是通过调用 GhostScript 来完成的。

## VimTex

简短教程：[Getting started with VimTeX](https://ejmastnak.com/tutorials/vim-latex/vimtex/)

{{% tab title="Tips" %}}
- VimTex 的命令都以 “Vimtex” 开头。
- 使用 `:VimtexImapsList` 命令查看插入模式快捷键（``g:vimtex_imaps_leader = "`"``）。
- 如果安装了 `which-key.nvim`，可以通过 `\l` 快速查看可用快捷键。
{{% /tab %}}

Text objects：

1. `e`：environment
2. `c`：command
3. `d`：surrounding delimiters，如 `()`，`[]`，`{}`，以及它们的 `\left \right` `\big \big` 变种。
4. `$`：surrounding math，如 `$ 1 + 1 = 2 $`，或者 `\begin{equation*} ... \end{equation*}` 等。
5. `P`：section
6. `m`：Items in `itemize` and `enumerate` environments.

“切换”命令：

- `tsc`、`tss`：分别切换 commands 或 environments 的星号。
- `tse`（`g:vimtex_env_toggle_map`）：切换相关环境，如 `itemize` 和 `enumerate`。
- `ts$`：切换 inline math 和 display math：
  ```latex
                ts$  \[              ts$   \begin{equation}
   $1 + 1 = 2$  -->      1 + 1 = 2   -->       x + y = z
                     \]                    \end{equation}
- `tsd`（`g:vimtex_delim_toggle_mod_list`）：切换 surrounding delimiters
- `tsf`：切换 surrounding fractions，`\frac{a}{b}` 和 `a/b`
  ```

“移动”命令：

- `%`：移动到匹配分界符，如 `\begin` 和 `\end`
- `]]`，`[[`，`][`，`[]`：在 `\section`，`\subsection` 或 `\subsubsection` 间移动。
  - 第一个符号，`]` 和 `[` 分别表示“后一个”或“前一个”
  - 第二个符号，`]` 和 `[` 分别表示“开始”或“结尾”
- `]m`，`[m`：environments
- `]n`，`[n`：math zones
- `]r`，`[r`：beamer frames

### SyncTex

Vimtex 通过使用 SyncTex 与 Zathura 同步。设置位置在 `g:vimtex_compiler_latexmk` 参数，`-synctex=1` 选项。

- 正向同步：默认使用 `VimtexView` 命令或 `\lv` 快捷键。也可以通过 Vimtex 定义的事件 `VimtexEventCompileSuccess` 来定义自动命令:
    ```lua
    -- 禁用 `g:vimtex_view_automatic` 以避免首次开始编译时出现两个 Zathura 窗口。
    vim.g.vimtex_view_automatic = 0
    -- VimtexEventCompileSuccess 自动命令
    local vimtex_group = vim.api.nvim_create_augroup("VimtexSync", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventCompileSuccess",
      group = vimtex_group,
      command = "VimtexView", -- 注意其实是跳转到当前光标对应位置，而不是修改的位置。
    })
    ```
- 逆向同步：Zathura 支持 SyncTex，默认快捷键为 <kbd>Ctrl</kbd>+鼠标左键（见 `man 5 zathurarc`, synctex-edit-modifier 选项）。


