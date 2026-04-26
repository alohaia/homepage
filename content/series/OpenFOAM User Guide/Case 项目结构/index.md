---
title: "Case 项目结构：Backward-Facing Step"
date: 2026-04-24T14:07:28+08:00
lastmod: 2026-04-26T18:46:22+08:00
comments: true
weight: 1
tags:
    - OpenFOAM
---

一个 *case*（*算例*）目录包含一个完整项目的所有设置。推荐将 case 放在一个特定目录的 `run` 子目录下。使用 `run` alias 可以快速切换到 `$FOAM_RUN` 目录。

```bash
echo $FOAM_RUN
```

    /home/<username>/OpenFOAM/<username>-<version>/run

<!--more-->

```bash
cd $FOAM_RUN
cp -r $FOAM_TUTORIALS/incompressibleFluid/pitzDailySteady .
cd pitzDailySteady
```

> [!NOTE]
> OpenFOAM 总是在三维笛卡尔坐标系中运行。要运行二维案例，可以通过将垂直于第三维方向的边界设置为特殊边界条件 `empty`。

## 几何边界 {alias="blockMesh"}

```cpp
/*--------------------------------*- C++ -*----------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Version:  13
     \\/     M anipulation  |
\*---------------------------------------------------------------------------*/
FoamFile
{
    format      ascii;
    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

// Note: this file is a Copy of $FOAM_TUTORIALS/resources/blockMesh/pitzDaily

convertToMeters 0.001;

vertices
(
    (-20.6 0 -0.5)
    (-20.6 25.4 -0.5)
    (0 -25.4 -0.5)
    (0 0 -0.5)
    (0 25.4 -0.5)
    (206 -25.4 -0.5)
    (206 0 -0.5)
    (206 25.4 -0.5)
    (290 -16.6 -0.5)
    (290 0 -0.5)
    (290 16.6 -0.5)

    (-20.6 0 0.5)
    (-20.6 25.4 0.5)
    (0 -25.4 0.5)
    (0 0 0.5)
    (0 25.4 0.5)
    (206 -25.4 0.5)
    (206 0 0.5)
    (206 25.4 0.5)
    (290 -16.6 0.5)
    (290 0 0.5)
    (290 16.6 0.5)
);

negY
(
    (2 4 1)
    (1 3 0.3)
);

posY
(
    (1 4 2)
    (2 3 4)
    (2 4 0.25)
);

posYR
(
    (2 1 1)
    (1 1 0.25)
);


blocks
(
    hex (0 3 4 1 11 14 15 12)
    (18 30 1)
    simpleGrading (0.5 $posY 1)

    hex (2 5 6 3 13 16 17 14)
    (180 27 1)
    edgeGrading (4 4 4 4 $negY 1 1 $negY 1 1 1 1)

    hex (3 6 7 4 14 17 18 15)
    (180 30 1)
    edgeGrading (4 4 4 4 $posY $posYR $posYR $posY 1 1 1 1)

    hex (5 8 9 6 16 19 20 17)
    (25 27 1)
    simpleGrading (2.5 1 1)

    hex (6 9 10 7 17 20 21 18)
    (25 30 1)
    simpleGrading (2.5 $posYR 1)
);

boundary
(
    inlet
    {
        type patch;
        faces
        (
            (0 1 12 11)
        );
    }
    outlet
    {
        type patch;
        faces
        (
            (8 9 20 19)
            (9 10 21 20)
        );
    }
    upperWall
    {
        type wall;
        faces
        (
            (1 4 15 12)
            (4 7 18 15)
            (7 10 21 18)
        );
    }
    lowerWall
    {
        type wall;
        faces
        (
            (0 3 14 11)
            (3 2 13 14)
            (2 5 16 13)
            (5 8 19 16)
        );
    }
    frontAndBack
    {
        type empty;
        faces
        (
            (0 3 4 1)
            (2 5 6 3)
            (3 6 7 4)
            (5 8 9 6)
            (6 9 10 7)
            (11 14 15 12)
            (13 16 17 14)
            (14 17 18 15)
            (16 19 20 17)
            (17 20 21 18)
        );
    }
);

// ************************************************************************* //
```


`convertToMeters`
: 定义 `vertices` 坐标转换为“米”的换算关系。

`vertices`
: 通过坐标定义点。

`blocks`
: 通过点的索引（从 0 开始）定义六面体（`hex`）。

`boundary`（几何边界）
: 为各个面分组（如 `inlet`），并指定类型（如 `wall` 以及特殊边界类型 `empty`）。

> [!IMPORTANT] `hex`
>
>     hex (<i_vertices>) (<n_cells>) <grade>

> [!IMPORTANT] `simpleGrading`
>
>     simpleGrading
>     (
>         (<len_perc> <n_cells_perc> <len_ratio_last2first>)
>         // ...
>     )

运行并查看：

```bash
blockMesh
paraFoam -builtin &
```

> [!TIP]
> 启用 ParaView 中的“Camera Parallel Projection”选项可以查看正交视角，方便观察“2D”模型。

## 边界和初始条件 {alias="0/*"}

初始场的数据储存在 `0` 目录（代表 $t=0$）下，包括 `0/p` 和 `0/U` 等文件，分别表示初始的压力场和速度场。

```cpp
// 0/p
FoamFile
{
    format      ascii;
    class       volScalarField;
    object      p;
}

dimensions      [0 2 -2 0 0 0 0];

internalField   uniform 0;

boundaryField
{
    inlet
    {
        type            zeroGradient;
    }

    outlet
    {
        type            fixedValue;
        value           uniform 0;
    }

    upperWall
    {
        type            zeroGradient;
    }

    lowerWall
    {
        type            zeroGradient;
    }

    frontAndBack
    {
        type            empty;
    }
}
```

```cpp
// 0/U
FoamFile
{
    format      ascii;
    class       volVectorField;
    object      U;
}

dimensions      [0 1 -1 0 0 0 0];

internalField   uniform (0 0 0);

boundaryField
{
    inlet
    {
        type            fixedValue;
        value           uniform (10 0 0);
    }

    outlet
    {
        type            zeroGradient;
    }

    upperWall
    {
        type            noSlip;
    }

    lowerWall
    {
        type            noSlip;
    }

    frontAndBack
    {
        type            empty;
    }
}
```

`dimensions`
: 指定量纲，依次为质量（kg），长度（m），时间（s），温度（K，开尔文），物质的量（mol），电流（A），照度（cd）。
: `[0 1 -1 0 0 0 0]` 即表示 `m^1 * s^-1`，即为 `m/s`，而压力（$Pa = kg^1\cdot m^{-1}\cdot s^-2$）则表示为 `[1 -1 -2 0 0 0 0]`。

`internalField`
: 可以是 `uniform` 设置为均匀的内场；也可以是 `nonuniform`，为每个网格设置单独值。
: 这里为了便利，都设置为了 0。

`boundaryField`
: 为所有边界 patches 设置边界条件。
: 在 `0/p` 中，`inlet` 设置为 `zeroGradient`，意思是在法线（normal）方向上压力梯度为 0。`outlet` 被设置为固定值 `0`。因为 `upperWall` 和 `lowerWall` 法向方向的压力不为 0， 所以也设置为 `zeroGradient`，让求解器自行解出实际值。由于这个算例实际是一个 2D 模型，因此 `frontAndBack` 被设置为了特殊值 `empty`。
: 在 `0/U` 中，`inlet` 设置为固定值 `(10 0 0)` 而 `outlet` 被设置为 `zeroGradient`。另一处不同的地方在于 `upperWall` 设置为 `noSlip`，表示液体在接近墙壁的位置由于黏性而速度为 0，这也使得墙面不可穿透（法向速度也为 0）。

## 物理属性 {alias="physicalProperties"}

```cpp
// constant/physicalProperties
FoamFile
{
    format      ascii;
    class       dictionary;
    location    "constant";
    object      physicalProperties;
}

viscosityModel  constant;

nu              1e-05;
```


> [!NOTE] 运动黏度和动力黏度
> *运动黏度*（*kinematic viscosity*, $\nu$）用于描述[动量](#动量传递)在流体中传递的快慢，单位是 $m^2/s$；而*动力黏度*（*dynamic viscosity*，$\mu$）则描述内摩擦或剪切阻力的大小，单位是 $Pa\cdot s=kg / (m \cdot s)$。两者可通过密度换算：
> $$
\begin{equation}
\nu = \frac{\mu}{\rho}
\end{equation}
$$

`viscosityModel`
: 设置黏度如何随条件变化的模型，需要设置 `nu`。

`nu`
: 设置运动黏度 $\nu$ 的值，单位为 $m^2/s$。

## 动量传递 {alias="momentumTransport"}

> [!NOTE] 雷诺数（Reynolds number）
> 需要一个估计的*雷诺数*（*Reynolds number*）来确定液流是否会是湍流。雷诺数是*惯性力*与*黏性力*的比值，是一个无量纲量：
> $$
\begin{equation}
Re\sim \frac{\rho U^2/L}{\mu |U|/L^2}=\frac{|U|L}{\nu}
\end{equation}
$$
> 其中，$|U|$ 和 $L$ 分别是特征速度和特征长度，可以“任意”取，不过一般分别取平均或峰值速度和管道直径。在不同的流体和扰动情况下，会有不同的相对临界雷诺数。

```cpp
// constant/momentumTransport
FoamFile
{
    format      ascii;
    class       dictionary;
    location    "constant";
    object      momentumTransport;
}

simulationType RAS;

RAS
{
    // Tested with kEpsilon, realizableKE, kOmega, kOmega2006, kOmegaSST, v2f,
    // ShihQuadraticKE, LienCubicKE.
    model           kEpsilon;

    turbulence      on;


    viscosityModel  Newtonian;
}
```

`simulationType`
: 指定模拟的类型。`RAS` 表示*雷诺平均模拟*（*Reynolds-averaged simulation*），是湍流建模的标准方法。

`RAS`
: 指定雷诺平均模拟模型的输入参数。这里使用 $k-\epsilon$ 模型（使用默认参数）（见 `foamInfo kEpsilon`）（也可以用注释中的其他模型，需要的参数都在 `0` 目录中定义好了），并启用模拟湍流（`off` 的话就会变成纯层流，黏度模型设置为牛顿流体（默认模型，可省略）。

> [!NOTE] 为什么要有两个 `viscosityModel`？
> 因为 `physicalProperties` 中会根据 `viscosityModel` 计算单纯的分子黏度，而湍流会使得表观黏度高于分子黏度，因此需要在设定湍流模型的时候再次指定 `viscosityModel` 计算额外的湍流黏度 $\nu_t\eqref{eq:nut}$，从而获得表观有效黏度 $\nu_{eff}\eqref{eq:nueff}$。
> 
> > 湍流粘度是流体在湍流状态下由涡团扩散效应表现出的表观粘性，其量纲与分子粘度相同但数值通常更高。

在湍流模型中，有效黏度（表观黏度）

$$\begin{equation}
\nu_{eff}=\nu+\nu_t
\label{eq:nueff}
\end{equation}$$

由分子黏度（层流黏度）$\nu_{laminar}$ 和湍流黏度 $\nu_t$ 组成。对于 $k-\epsilon$ 模型，

$$\begin{equation}
\nu_t = C_\mu \frac{k^2}{\epsilon}
\label{eq:nut}
\end{equation}$$

通过求解两个传递方程来间接获得湍流黏度：湍流动能（turbulent kinetic energy）$k\eqref{eq:tke}$ 和湍流耗散率（turbulent dissipation rate）$\epsilon\eqref{eq:tdr}$。

$$
\begin{equation}
\label{eq:tke}
k=\frac{3}{2}(|U|I)^2
\end{equation}
$$

$I=U_{RMS}^{\prime}/|U|$ 是湍流强度，即湍流波动均方根 $U_{RMS}^{\prime}$（Root Mean Square，RMS，用于量化交流量或波动信号的大小，比如我国交流电压的均方根就是 220 V）与平均流速 $|U|$ 的比值。这个例子中取一个估计值 5%，则 $k=1.5\times (10\times 0.05)^2 = 0.375\,m^{2}s^{-2}$。内场和 inlet 均使用这个值：

```cpp
// 0/k
FoamFile
{
    format      ascii;
    class       volScalarField;
    location    "0";
    object      k;
}

dimensions      [0 2 -2 0 0 0 0];

internalField   uniform 0.375;

boundaryField
{
    inlet
    {
        type            fixedValue;
        value           uniform 0.375;
    }
    outlet
    {
        type            zeroGradient;
    }
    upperWall
    {
        type            kqRWallFunction;
        value           uniform 0.375;
    }
    lowerWall
    {
        type            kqRWallFunction;
        value           uniform 0.375;
    }
    frontAndBack
    {
        type            empty;
    }
}
```

$$
\begin{equation}
\epsilon=C^{0.75}_\mu\frac{k^{1.5}}{l_m}
\label{eq:tdr}
\end{equation}
$$

在 $k-\epsilon$ 模型中，使用经验值 $C_\mu=0.09$。$l_m$ 即 *Prandtl mixing length*，是流体湍流与周围流体完全混合前所移动的距离，用来描述湍流剪切应力，估计值为 $l_m=10\%\times step\ height=2.54\,mm$。所以 $\epsilon=0.09^{0.75}\times 0.375^{1.5} / 0.00254=14.855\,m^2s^{-3}$，用于设置初始的内场和 inlet：

```cpp
// 0/epsilon
FoamFile
{
    format      ascii;
    class       volScalarField;
    location    "0";
    object      epsilon;
}

dimensions      [0 2 -3 0 0 0 0];

internalField   uniform 14.855;

boundaryField
{
    inlet
    {
        type            fixedValue;
        value           uniform 14.855;
    }
    outlet
    {
        type            zeroGradient;
    }
    upperWall
    {
        type            epsilonWallFunction;
        value           uniform 14.855;
    }
    lowerWall
    {
        type            epsilonWallFunction;
        value           uniform 14.855;
    }
    frontAndBack
    {
        type            empty;
    }
}
```

最后，可以根据 `0/k` 和 `0/epsilon` 计算湍流黏度 $\nu_t\eqref{eq:nut}$：

```cpp
// 0/nut
FoamFile
{
    format      ascii;
    class       volScalarField;
    location    "0";
    object      nut;
}

dimensions      [0 2 -1 0 0 0 0];

internalField   uniform 0;

boundaryField
{
    inlet
    {
        type            calculated;
        value           uniform 0;
    }
    outlet
    {
        type            calculated;
        value           uniform 0;
    }
    upperWall
    {
        type            nutkWallFunction;
        value           uniform 0;
    }
    lowerWall
    {
        type            nutkWallFunction;
        value           uniform 0;
    }
    frontAndBack
    {
        type            empty;
    }
}
```

`inlet` 和 `outlet` 均指定为 `calculated`，表示根据前面的设置由 OpenFOAM 自行计算，由于初始未形成湍流，所以指定为 0。`upperWall` 和 `lowerWall` 指定*壁面函数*（wall function）为 `nutkWallFunction`，表示这是*光滑壁面*，不考虑表面粗糙度引起的压力阻力，仅基于*壁面定律*（*Law of the Wall*），根据湍能 $k$ 计算 $\nu_t$。如果需要可以用 `nutRoughWallFunction` 表示粗糙壁面，并额外提供*等效沙粒粗糙度高度* $Ks$ 和*粗糙度常数* $Cs$。

注意到不仅 `0/nut` 中设置了壁面函数，`0/k` 和 `0/epsilon` 中也要给边界设置对应的对应的边界条件——分别是 `kqRWallFunction` 和 `epsilonWallFunction`。后者的前缀 `kqR` 表示这是一个通用的边界条件，可以用于不同的湍流动能类型，如 $k$、$q$ 以及雷诺压力 $R$。

## 控制运行 {alias="controlDict"}

`system/controlDict` 文件中包含时间和读写相关的控制选项：

```cpp
// system/controlDict
FoamFile
{
    format      ascii;
    class       dictionary;
    location    "system";
    object      controlDict;
}

solver          incompressibleFluid;

startFrom       startTime;

startTime       0;

stopAt          endTime;

endTime         2000;

deltaT          1;

writeControl    timeStep;

writeInterval   100;

purgeWrite      0;

writeFormat     ascii;

writePrecision  6;

writeCompression off;

timeFormat      general;

timePrecision   6;

runTimeModifiable true;
```


`solver`
: 指定用于模拟的求解器模块，见 [Solver modules](https://doc.cfd.direct/openfoam/user-guide-v13/solvers-modules)。

> `incompressibleFluid`
> 
> Solver module for steady or transient turbulent flow of incompressible isothermal fluids with optional mesh motion and change.

`startFrom`，`startTime`
: 指定开始时间。这里设置开始时间为 0，指示求解器从 `0` 目录读取场数据。

`deltaT`
: 指定时间步长，其值不会影响解，因此可以设置为 1，即将时间简单地等价于求解步数。

`stopAt`，`endTime`
: 指定结束时间，`deltaT` 时，结束时间就等于求解最大步数。

`writeControl`，`writeInterval`
: 指定如何保存中间步骤。这里根据时间步数保存，每 100 步（1\*100 = 100 s）保存一次

## 离散化和线性求解器设置

`system/fvSchemes` 文件用来指定*有限体积离散化方案*（finite volume discretisation schemes），线性方程求解器、容差（tolerances）和其他算法控制则在 `system/fvSolution` 中指定。

`ddtSchemes`（`fvSchemes`）
: 默认为 `steadyState`，以调用稳态循环。

`SIMPLE`（`fvSolution`）
: 稳态求解使用一个基于 *SIMPLE* 的算法，这个算法的控制选项在 `fvSolution` 的 `SIMPLE` 项中定义。
: `consistent` 指定使用 SIMPLE 算法的 consistent 模式（*SIMPLEC*，SIMPLE 的改进版，一致性更强，松弛因子可以设置得更大）。
: `residualControl` 控制 `p`、`U` 以及湍流域的容差（tolerances）。求解器会在各个变量的残差低于指定容差时终止，即认为已收敛。
: SIMPLEC 的收敛性对 `fvSolution` 中的 `relaxationFactors`（相当于算法运行时每一步的跨度）非常敏感，这里调整为了 0.9。

## 执行模拟

```bash
foamRun
```

`foamRun` 命令根据 `controlDict` 中的 `solver` 调用求解器模块。中间步骤会直接生成在算例根目录，与 `0` 同级。

## ParaView 操作技巧

使用 `paraFoam` 命令调用 ParaView 查看结果。

```bash
paraFoam -builtin
```

### 常用过滤器

ParaView 内置了许多过滤器（filter），但只有少数（大概 10--15 个）与 CFD 相关：

1. **Extract Block**：选择计算域（domain）的组件，如边界面域（boundary patches）或者内部的网格。
2. **Slice**：插入一个剖面（plane）到几何体中。
3. **Cell Centers** 和 **Glyph**：用于绘制速度矢量。
4. **Stream Tracer** 和 **Tube**：用于绘制流线。
5. [**Contour**](#Contour)：绘制等值线或等值面。
6. **Feature Edges**：to capture features on a surface for better image definition.

#### Contour

首先使用 `foamPostProcess` 命令计算速度的模（magnitude）：

```bash
foamPostProcess -func "mag(U)"
```

这个后处理命令会遍历各个时间目录，读取 `U`，并计算速度的模，写入为 `mag(U)` 文件。再次用 `paraFoam` 命令查看，并用 Slice 和 Contour 过滤器展示内部等值线：

{{< figure src="contour.png" title="mag(U) 等值线" >}}

## 优化入口速度

前面在 `0/U` 中设置入口速度为 `fixedValue` `uniform (10 0 0)`，使得整个入口面所有位置的初始流体速度都为 X 轴方向的 10 m/s。但是在贴近上下壁面的位置，由于液体黏性导致的剪切力，使得液体流速快速下降而压力迅速异常升高。

为了避免这一情况，可以将入口的液流速度不均匀。通用边界条件 `flowRateInletVelocity` 可以指定入口的流速，使用 `foamInfo` 查看文档：

```bash
foamInfo flowRateInletVelocity
```

修改速度边界条件：

```cpp
// 0/U
inlet
{
    type          flowRateInletVelocity;
    meanVelocity  10;
    profile       turbulentBL;

    value         uniform (10 0 0);      // leave for ParaView
}
```

`flowRateInletVelocity` 根据平均流速 `meanVelocity` 计算入口边界的流速。`profile` 指定速度与到壁面距离的分布函数，可以用分别为层流和湍流边界层设计的 `laminarBL` 或 `turbulentBL`。`value` 只是为了给 ParaView 保留的。

> The `profile` entry is a `Function1` of the normalised distance to the
> wall.  Any suitable `Foam::Function1s` can be used including
> `Foam::Function1s::codedFunction1` but `Foam::Function1s::laminarBL` and
> `Foam::Function1s::turbulentBL` have been created specifically for this
> purpose and are likely to be appropriate for most cases.


再重新运行：

```bash
foamListTimes -rm; foamRun; foamPostProcess -func "mag(U)"; paraFoam -builtin
```

> [!TIP] 移除上次运行结果。
> 求解命令不会自动删除上次运行结果，因此可能有部分上次运行的结果意外地和本次运行结果混在一起。
> `foamListTimes` 命令可以列出当前算例的所有时间目录（不包括 `0`），`foamListTimes -rm` 则可以删除所有运行结果。

