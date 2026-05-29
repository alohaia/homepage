---
title: "应用和库"
date: 2026-05-01T10:32:55+08:00
lastmod: 2026-05-06T11:50:21+08:00
comments: true
weight: 2
tags:
    - OpenFOAM
    - CFD
---

OpenFOAM 提供了许多可以在命令行中运行的软件工具，这些工具包括 `foamRun` 和 `blockMesh` 等用 C++ 编写的*应用*（*applications*），可以利用 OpenFOAM 的大量的*库*（*libraries*）来实现实现特定功能。这些应用一般分为两类：

- *solvers*（求解器），如 `foamRun`，可以进行 CFD 计算；
- *utilities*，如 `blockMesh` 和 `foamPostProcess`，负责其他 CFD 相关的任务。

除了应用，这些软件工具还包括 *shell 脚本*，如 `paraFoam` 和 `foamInfo`。

> [!IMPORTANT]
> 在 11 版之前，不同类型的液流有不同的求解器，如 `simpleFoam` 和 `pimpleFoam`，都是独立的应用。但是，现在大部分流求解器都被设计成了*模块*（*modules*），被编写为独立的库，如 `incompressibleFluid` 和 `incompressibleVoF`，都可以通过通用的求解器 `foamRun` 来加载。

<!--more-->

## 编译应用

### 标准结构

- `<AppName>/`
    - `<AppName>.C`
    - `Make/`
        - `files`
        - `options`
    - `otherHeader.H`, ...
    - `lnInclude`，见[包含头文件](#包含头文件)

推荐在 `$WM_PROJECT_USER_DIR` 目录下创建一个独立目录，如 `applications`，来放置 `<AppName>` 目录。

### 依赖

在 OpenFOAM 中，*依赖*（*dependencies*）指通过递归搜索顶级 `.C` 文件 `#include` 指令获得的所有 `.H` 文件。

#### 包含头文件

`wmake` 通过 `-I` 选项默认为编译器指定了一些包含目录（按以下顺序）：

1. `$WM_PROJECT_DIR/src/OpenFOAM/lnInclude` 目录；
2. 本地 `lnInclude` 目录，即 `<AppName>/lnInclude`；
3. 本地目录，即 `<AppName>/`；
4. `$WM_PROJECT_DIR/wmake/rules` 指定的平台相关的目录，如 `/usr/include/X11/`；
5. 在 `Make/files` 中用 `-I` 选项显式指定的其他目录。

```txt
EXE_INC = \
    -I<directoryPath1> \
    -I<directoryPath2> \
    …                \
    -I<directoryPathN>
```

#### 链接到库

类似地，`wmake` 使用 `-L` 选项指定了默认的*共享目标库文件*（*shared object library files*）目录：

1. `$FOAM_LIBBIN` 目录；
2. `$WM_DIR/rules` 设定的平台相关目录，如 `$MPI_ARCH_PATH/lib`；
3. `Make/files` 中用 `-L` 选项指定的目录。

实际需要链接的库需要用 `-l` 选项指定。选项值要去除库文件的 `lib` 前缀和 `.so` 后缀，如 `libnew.so` 对应 `lnew` 选项。`wmake` 默认加载这些库：

1. `$FOAM_LIBBIN/libOpenFOAM.so`；
2. `$WM_DIR/rules` 指定的平台相关的库，如 `libm.so`；
3. `Make/files` 中用 `-l` 选项指定的库。

```txt
EXE_LIBS = \
    -L<libraryPath> \
    -l<library1>     \
    -l<library2>     \
    …               \
    -l<libraryN>
```


### 文件列表

OpenFOAM 标准 release 的 applications 位于 `$FOAM_APPBIN`（如 `/opt/OpenFOAM/OpenFOAM-13/platforms/linux64GccDPInt32Opt/bin`），而用户创建的应用则应该放在 `$FOAM_USER_APPBIN`（如 `$HOME/OpenFOAM/$USER-13/platforms/linux64GccDPInt32Opt/bin`），所以我们的 `Make/files` 大致应该是这样：

```txt
<AppName>.C

EXE = $(FOAM_USER_APPBIN)/<AppName>
```

### 运行 `wmake`

```bash
wmake [OPTION] [dir]
wmake [OPTION] target [dir [MakeDir]]
```

当切换到实际的应用目录（`<AppName>/`）中运行 `wmake` 时，`dir` 可以省略。

> [!TIP] `wmake` 环境变量
> OpenFOAM 环境包含一些与 `wmake` 相关的环境变量，可以使用 `env | grep '^WM_' | sort` 命令查看。

`wmake` 会在 `Make/$WM_OPTIONS` 目录下生成依赖列表文件，这个文件以 `.dep` 结尾，如 `Make/linux64GccDPInt32Opt/<AppName>.C.dep`；此外 `wmake` 还会创建 `lnInclude` 目录，其中包含指向所有依赖库文件的软链接。可以使用 `wclean` 命令删除这些文件：

```bash
wclean [OPTION] [dir]
wclean [OPTION] target [dir [MakeDir]]
```

## 编译库

编译一个库时，有两点关键区别：

1. `Make/files` 文件：`EXE = $(FOAM_USER_APPBIN)/<AppName>` -> `LIB = $FOAM_USER_LIBBIN/<LibName>`
2. `Make/options` 文件：`EXE_LIBS = ...` -> `LIB_LIBS = ...`


## 示例：编译 `foamRun` 应用

```bash
cd $WM_PROJECT_USER_DIR
mkdir -p applications/foamRun/Make
cp $FOAM_SOLVERS/foamRun/foamRun.C applications/foamRun
cp $FOAM_SOLVERS/foamRun/setDeltaT.{C,H} applications/foamRun # dependencies
touch applications/foamRun/Make/{files,options}
```

`Make/files`：

```txt
setDeltaT.C
foamRun.C

EXE = $(FOAM_USER_APPBIN)/foamRun
```

`Make/options`：

```txt
EXE_INC = \
    -I$(LIB_SRC)/finiteVolume/lnInclude

EXE_LIBS = \
    -lfiniteVolume
```

## 调试信息和优化开关

OpenFOAM 的默认调试信息和优化配置在 `$WM_PROJECT_DIR/etc/controlDict` 文件中定义，如果需要修改，可以复制到用户目录：

```bash
mkdir -p $HOME/.OpenFOAM/$WM_PROJECT_VERSION/
cp $WM_PROJECT_DIR/etc/controlDict $HOME/.OpenFOAM/$WM_PROJECT_VERSION/
```

## 运行时动态链接

如果需要在运行算例时，加载自定义库（如自定义的边界条件），可以通过 `controlDict` 来方便地实现：

```cpp
libs
(
    "libnew1.so"
    "libnew2.so"
);
```

