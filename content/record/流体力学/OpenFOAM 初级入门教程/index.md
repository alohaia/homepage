---
title: "OpenFOAM 初级入门教程"
date: 2026-04-21T21:59:39+08:00
lastmod: 2026-04-23T20:44:47+08:00
comments: true
tags:
    - 流体力学
    - OpenFOAM
---

OpenFOAM 自带了一系列教程：

```bash
# 复制一份教程文件出来
cd ~/Documents/ && cp -r $FOAM_TUTORIALS ./ofoam_tutorials
```

<!--more-->

## Kickstart {alias="快速开始"}

{{< bilibili id="BV1m3411f7eK" >}}

复制 `cavity` 案例：

```bash
cd ~/Documents/ofoam_tutorials
mkdir practices
cp -r legacy/incompressible/icoFoam/cavity/cavity practices

cd practices/cavity
```

1. 画网格：`blockMesh` 命令，生成网格 `constant/polyMesh`
2. 求解：`icoFoam` 命令，生成求解中间步骤 `0.1` 到 `0.5`
3. 后处理：`paraFoam -builtin`，使用 ParaView 查看

## 项目结构

- `0`
    - `p`：压力/速度
    - `U`：边界条件
- `constant`
    - `polyMesh/*`：生成的网格（`blockMesh` 生成）
    - `physicalProperties`：物性参数
- `system`
    - `blockMeshDict`：控制网格生成
    - `controlDict`：控制运行步长、运行时间等
    - `fvSchemes`：离散格式设定
    - `fvSolution`：求解器设定

### `blockMeshDict`

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

convertToMeters 0.1;

vertices
(
    (0 0 0)
    (1 0 0)
    (1 1 0)
    (0 1 0)
    (0 0 0.1)
    (1 0 0.1)
    (1 1 0.1)
    (0 1 0.1)
);

blocks
(
    hex (0 1 2 3 4 5 6 7) (20 20 1) simpleGrading (1 1 1)
);

boundary
(
    movingWall
    {
        type wall;
        faces
        (
            (3 7 6 2)
        );
    }
    fixedWalls
    {
        type wall;
        faces
        (
            (0 4 7 3)
            (2 6 5 1)
            (1 5 4 0)
        );
    }
    frontAndBack
    {
        type empty;
        faces
        (
            (0 3 2 1)
            (4 5 6 7)
        );
    }
);


// ************************************************************************* //
```

- `cppFile.object`：指定文件类型
- `convertToMeters`：`vertices` 坐标乘以 `convertToMeters`，即为实际坐标（单位为 m）。
- `vertices`：指定方块的 8 个顶点，`(x, y, z)`
- `blocks`：`(0 1 2 3 4 5 6 7)` 按顶点编号（0-indexed）指定一个或多个方块；`(20, 20, 1)` 表示 x、y、z 方向分别有多少网格；`simpleGrading (1, 1, 1)` 表示膨胀率/变化率（指定网格大小变化率）。
- `boundary`：指定几何边界
    - `movingWall`：类型为 `wall`，指定面 `(3 7 6 2)` 为“运动的面”（主动运动的表面）
    - `fixedWalls`：类型为 `wall`，指定了 3 个面为“固定的面”
    - `frontAndBack`：类型为 `empty`（与 z 方向正交的两个面，指定为空的话就相当于整个模型等同于一个二维模型），指定 2 个面为“前面和后面”

> [!TIP] 右手螺旋定则
> OpenFOAM 使用*外法线*，即法线方向由面的内面指向外面。法线的方向可以通过“右手螺旋定则”确定——右手四指方向与顶点的顺序相同，拇指指向方向即为法线方向。

### `controlDict`

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
    location    "system";
    object      controlDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

startFrom       startTime;

startTime       0;

stopAt          endTime;

endTime         0.5;

deltaT          0.005;

writeControl    timeStep;

writeInterval   20;

purgeWrite      0;

writeFormat     ascii;

writePrecision  6;

writeCompression off;

timeFormat      general;

timePrecision   6;

runTimeModifiable true;

// ************************************************************************* //
```

- `cppFile.object`：指定文件类型
- ~`application`~：求解器为 `icoFoam`
- `startFrom`，`startTime`：指定开始时间
- `stopAt`，`endTime`：指定结束时间
- `deltaT`：指定时间步长
- `writeControl`，`writeInterval`：根据时间步数保存，每 20 步（0.005\*20 = 0.1 s）保存一次

## 边界条件

{{< bilibili id="BV1RD4y1s7Bg" >}}

*边界条件*分为*几何边界条件*和*物理边界条件*，分别由 `blockMeshDict` 和 `0/*` 来定义。

几何边界条件包括 `wall`、`empty`、`patch` 等；物理边界条件包括速度（`0/U`）压力（`0/p`）。

速度：

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
    class       volVectorField;
    object      U;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

dimensions      [0 1 -1 0 0 0 0];

internalField   uniform (0 0 0);

boundaryField
{
    movingWall
    {
        type            fixedValue;
        value           uniform (1 0 0);
    }

    fixedWalls
    {
        type            noSlip;
    }

    frontAndBack
    {
        type            empty;
    }
}

// ************************************************************************* //
```

- `cppFile.object`：指定文件类型
- `dimensions`：指定量纲，依次为质量（kg），长度（m），时间（s），温度（K，开尔文），物质的量（mol），电流（A），照度（cd）。`[0 1 -1 0 0 0 0]` 即表示 `m^1 * s^-1`，即为 `m/s`，而压力（$Pa = kg^1\cdot m^{-1}\cdot s^-2$）则表示为 `[1 -1 -2 0 0 0 0]`。
- `internalField`：内场，`uniform (0 0 0)` 表示初始（`0/*` 表示初始）的各方向的速度都为 0（$\vec{V} = \vec{u}_x + \vec{u}_y + \vec{u}_z$）。
- `boundaryField`：指定与几何边界条件对应的物理边界条件。
    - `movingWall`：类型为 `fixedValue`，值为 $\vec{u}_x = 1 (m/s)$。
    - `fixedWalls`：类型为 `noSlip`，表示无滑移边界条件。
    - `frontAndBack`：类型为 `empty`（这里与几何边界条件重合）。

压力：

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
    class       volScalarField;
    object      p;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

dimensions      [0 2 -2 0 0 0 0];

internalField   uniform 0;

boundaryField
{
    movingWall
    {
        type            zeroGradient;
    }

    fixedWalls
    {
        type            zeroGradient;
    }

    frontAndBack
    {
        type            empty;
    }
}

// ************************************************************************* //
```

- `cppFile.object`：指定文件类型。
- `dimensions`：量纲为 $Pa/\rho$。
- `internalField`：内场，表示相对压力，指相对于所处的外界环境或背景（如大气压）的压力。
- `boundaryField`：指定物理边界。
    - `movingWall` 和 `fixedWalls` 均为 `zeroGradient`（零梯度）表示没有压力梯度。
    - `frontAndBack` 仍为 `empty`。

> [!TIP] “运动压力”
> $Pa/\rho$ 表示“运动压力”，没有给密度文件，只有 `0/p` 和 `0/U` 时就用这个。

## `blockMesh` 和渐变层

```goat
               +----------------------------+
              /| 3(0 10 0)                 /| 2(15 10 0)
             / |                          / |
            /  |         wall            /  |
           /   |                        /   |
          +----------------------------+    |
7(0 10 5) |    |            6(15 10 5) |    |
          |    |                       |    |
          |    |                       |    |
inlet ----+ ---+->          outlet ----+ ---+->
          |    |                       |    |
          |    |                       |    |
          |    +-----------------------|----+
          |   / 0(0 0 0)               |   / 1(15 0 0)
          |  /                         |  /
          | /          wall            | /
          |/                           |/
          +----------------------------+
           4(0 0 5)                     5(15 0 5)
```


修改顶点坐标与网格数量：

```cpp
vertices
(
    (0 0 0)
    (15 0 0)
    (15 10 0)
    (0 10 0)
    (0 0 5)
    (15 0 5)
    (15 10 5)
    (0 10 5)
);


blocks
(
    hex (0 1 2 3 4 5 6 7) (30 20 10) simpleGrading (1 1 1)
);
```

直接查看初始网格：

```bash
blockMesh && paraFoam -builtin
```


接下来修改渐变：

```cpp
blocks
(
    hex (0 1 2 3 4 5 6 7) (30 20 10) simpleGrading (
            ((0.5 0.5 10) (0.5 0.5 0.1))
            ((0.4 0.5 5) (0.6 0.5 0.2))
            ((0.2 0.4 5) (0.6 0.2 1) (0.2 0.4 0.2))
        )
);
```

`simpleGrading` 可以指定三个维度的渐变梯度，每个维度的参数格式为：

```cpp
(
    (precentage_of_length precentage_of_cells cell_len_ratio_last2first)
    // ...
)
```

最终效果如图：

{{< figure src="custom_block.png" title="自定义方块网格" >}}

## 导入 ICEM mesh 和并行计算

> [!NOTE]
> 示例文件 `fluent.msh` 来自 B 站 up 主 [@田东Joshua](https://space.bilibili.com/521006443)。

### 转换 fluent mesh

将 `fluent.msh` 下载到项目根目录（与 `0`/`constant`/`system` 同级），执行以下命令转换：

```bash
fluentMeshToFoam -scale 0.001 fluent.msh # fluent.msh 按 mm 为长度单位创建，需要缩放
```

`fluentMeshToFoam` 命令将 `fluent.msh` 转换为了 `constant/polyMesh/*`。

`constant/polyMesh/boundary` 中声明了 5 组几何边界：

```cpp {hl_lines=["17-18","30-31"]}
5
(
    INLET
    {
        type            patch;
        nFaces          146;
        startFace       49496;
    }
    OUTLET
    {
        type            patch;
        nFaces          146;
        startFace       49642;
    }
    WALL
    {
        // type            wall;
        type            symmetry;
        inGroups        List<word> 1(wall);
        nFaces          324;
        startFace       49788;
    }
    CYLINDER
    {
        type            wall;
        inGroups        List<word> 1(wall);
        nFaces          200;
        startFace       50112;
    }
    // frontAndBackPlanes
    frontAndBack
    {
        type            empty;
        inGroups        List<word> 1(empty);
        nFaces          49904;
        startFace       50312;
    }
)
```

将其中 `WALL` 的类型改为 `symmetry`。修改 `0/p` 和 `0/U` 中的物理边界，使其与物理边界对应：

```cpp {hl_lines=[]}
// 0/p
boundaryField
{
    INLET
    {
        type            zeroGradient;
    }

    OUTLET
    {
        type            fixedValue;
        value           uniform 0; // a scalar value of 0
    }

    WALL
    {
        type            symmetry;
    }

    CYLINDER
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
boundaryField
{
    INLET
    {
        type            fixedValue;
        value           uniform (0.0037 0 0);
    }

    OUTLET
    {
        type            zeroGradient;
    }

    WALL
    {
        type            symmetry;
    }

    CYLINDER
    {
        type            noSlip;
    }

    frontAndBack
    {
        type            empty;
    }
}
```

```cpp
// constant/physicalProperties
nu              [0 2 -1 0 0 0 0] 1e-6;
```

设置以上参数使得雷诺数为 100：

$$
U=0.0037\,m/s\,,\ D(iameter)=0.027\ m\,,\ v(iscosity)=10^{-6}\ m^2/s\\
Re = \frac{U\cdot D}{v} = 100
$$

$U$ 为流体速度，$D$ 为圆柱直径，$v$ 为运动黏度系数。

### 使用 `decomposePar` 实现并行计算

由于模型较复杂，需要并行计算。首先需要分解网格，复制所需文件 `decomposeParDict`：

```bash
cp ofoam_tutorials/incompressibleVoF/damBreakFine/system/decomposeParDict ./ofoam_practices/karman/system
```

```cpp {hl_lines=[24]}
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
    location    "system";
    object      decomposeParDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

numberOfSubdomains 4;

method          simple;

simpleCoeffs
{
    n               (2 2 1);
    delta           0.001;
}


// ************************************************************************* //
```

然后运行分解命令：

```bash
decomposePar
```

生成了 `processor0` 到 `processor3` 4 个目录。可以查看分解之后的子网格：

```cpp
cd processor0 && paraFoam -builtin
```

修改 `controlDict` 运行参数

```cpp
endTime         600;
deltaT          0.1; // large deltaT leads to crash
writeInterval   50;
```

使用 `mpiexec` 并行计算：

```cpp
mpiexec -n 4 icoFoam -parallel > log 2>&1
```

之前用 `decomposePar` 分成了 4 块，所以这里 `-n 4` 并行求解。

> [!NOTE] 库朗数（Courant number）
> $$
  C_o = \frac{U\Delta t}{\Delta x}
  $$
> $U$ 为流体速度，$\Delta t$ 为时间步长，$\Delta x$ 为网格步长。为了结果不发散，我们要求最大库朗数小于 1。

并行计算的结果分布在各个 `processor*` 目录中，需要重组：

```bash
reconstructPar
```

{{< figure src="karman.png" title="最终结果" group="final_results" >}}
{{< figure src="karman_anime.png" alt="动画演示" group="final_results" >}}

## 使用 `snappyHexMesh` 生成三维网格

首先同样复制一份 `cavity`，并将 `blockMeshDict` 中的 `convertToMeters` 修改为 `1` 以便于计算。

这次的目标是在 `cavity` 的默认网格模型的中间挖掉一个半径为 0.2 m 的圆柱体。我们需要 `meshQualityDict` 和 `snappyHexMeshDict` 两个文件。示例 `windAroundBuildings` 包含这两个文件，可以直接复制：

```cpp
cp ofoam_tutorials/incompressibleFluid/windAroundBuildings/system/{meshQualityDict,snappyHexMeshDict} ofoam_practices/cavity_3/system
```

### 文件解读

#### `snappyHexMeshDict`

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
    object      snappyHexMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#includeEtc "caseDicts/mesh/generation/snappyHexMeshDict.cfg"

castellatedMesh on;
snap            on;
addLayers       off;

geometry
{
    buildings
    {
        type triSurface;
        file "buildings.obj";
    }

    refinementBox
    {
        type box;
        min  (  0   0   0);
        max  (250 180  90);
    }
};

castellatedMeshControls
{
    features
    (
      { file  "buildings.eMesh"; level 1; }
    );

    refinementSurfaces
    {
        buildings
        {
            level (3 3);
            patchInfo { type wall; }
        }
    }

    refinementRegions
    {
        refinementBox
        {
            mode    inside;
            level   2;
        }
    }

    insidePoint (1 1 1);
}

snapControls
{
    explicitFeatureSnap    true;
    implicitFeatureSnap    false;
}

addLayersControls
{
    layers
    {
        "CAD.*"
        {
            nSurfaceLayers 2;
        }
    }

    relativeSizes       true;
    expansionRatio      1.2;
    finalLayerThickness 0.5;
    minThickness        1e-3;
}

meshQualityControls
{}

writeFlags
(
    // scalarLevels
    // layerSets
    // layerFields
);

mergeTolerance 1e-6;

// ************************************************************************* //
```

- `castellatedMesh`：网格细分，“城垛”
- `castellatedMeshControls`：网格细分控制
    - `refinementSurfaces`：细化表面
    - `refinementRegions`：细化区域
    - ~`locationInMesh`~ `insidePoint`：指定流体区域，点落在哪里哪里就是流体区域
- `snap`：网格贴合
- `snapControls`：网格贴合控制
- `addLayers`：生成边界层
- `addLayersControls`：内置的边界层控制命令行
- `geometry`：几何
    - `refinementBox`：内置的 Box（六面体）
- `meshQualityControls`：网格质量控制，一般使用默认 `{}`
- `mergeTolerance`：融合限度，要大于 `controlDict` 中的 `timePrecision`（如 `timePrecision` 为 6，`mergeTolerance` 就应该大于 `1e-6`）

### 生成圆柱体

修改 `snappyHexMeshDict` 的 `geometry` 来生成圆柱体：

```cpp
addLayers       on;              // turn this on

// ...

geometry
{
    cylinder
    {
        type searchableCylinder; // a builtin type
        point1 (0.5 0.5 0);      // lower circle center point
        point2 (0.5 0.5 0.1);    // upper circle center point
        radius 0.2;              // radius
    }

    // - refinementBox
    // - {
    // -     type box;
    // -     min  (  0   0   0);
    // -     max  (250 180  90);
    // - }
};

// ...

castellatedMeshControls
{
    features
    (
    // -   { file  "buildings.eMesh"; level 1; }
    );

    refinementSurfaces
    {
        // - buildings
        cylinder                 // refine cylinder instead
        {
            level (3 3);         // (min max) refinement level
            patchInfo { type wall; }
        }
    }

    refinementRegions
    {
        // - refinementBox
        // - {
        // -     mode    inside;
        // -     level   2;
        // - }
    }

    insidePoint (0.8 0.5 0.01);       // arbitrary point outside of cylinder
}

snapControls
{
    explicitFeatureSnap    false;     // change from explicitFeatureSnap
    implicitFeatureSnap    true;      //        to   implicitFeatureSnap
                                      // (normally use this method for builtin geometries)
}

addLayersControls
{
    layers
    {
        // - "CAD.*"
        cylinder
        {
            nSurfaceLayers 5;         // add 5 layers
        }
    }

    relativeSizes       true;
    expansionRatio      1.2;
    finalLayerThickness 0.5;
    minThickness        1e-3;
}

// ...

// - mergeTolerance 1e-6;
mergeTolerance 1e-5;                  // larger
```

修改完就可以生成网格了，这次用新命令：

```bash
snappyHexMesh
```

Oops！报错了：

```log
--> FOAM FATAL ERROR: 
Mesh provided is not fully 3D as required for mesh relaxation after snapping
Convert all empty patches to appropriate types for a 3D mesh, current patch types are

3
(
wall
wall
empty
)


    From function snappyHexMesh
    in file snappyHexMesh.C at line 679.

FOAM exiting
```

原因是现在 `blockMesh` 网格（`constant/polyMesh`）的前后面（`frontAndBack`）为空，导致整体网格不是完全的 3D 模型。需要将 `blockMeshDict` 的中 `frontAndBack` 的类型修改为 `symmetry`，重新生成 `blockMesh` 网格后，再用 `snappyHexMesh` 在其基础上生成新网格。

另外，可以修改 `controlDict` 控制运行，在生成网格阶段，只会影响中间步骤的目录名称：

```cpp
endTime         5;
deltaT          1;
writeInterval   1;
```

现在，生成网格：

```bash
snappyHexMesh -noOverwrite
```

> [!NOTE]
> 现在 `-overwrite` 这个选项被移除了，默认行为就是覆写。要像以前一样生成中间步骤文件，可以使用 `-noOverwrite` 选项。
> 
> `snappyHexMesh -help`：
> 
>     -noOverwrite      Do not overwrite existing mesh/results files
>     -overwrite        Deprecated option, this is now default behaviour

{{< figure src="snappyHexMesh.png" title="snappyHexMesh 中间步骤" >}}

## 导入外部 STL 网格

还是复制一份 `cavity`（同样将 `convertToMeters` 修改为 1），然后将 @田东Joshua 提供的 `car.stl`（用 ICEM 创建的）放在 `constant/triSurface` 目录中：

```bash
cp ofoam_tutorials/legacy/incompressible/icoFoam/cavity/cavity -r ofoam_practices/car
cd ofoam_practices/car
mkdir constant/triSurface
mv ~/Downloads/car.stl constant/triSurface
```

### 创建包裹网格

修改 `blockMeshDict` 以创建包裹 STL 模型的长方形网格：

```cpp
convertToMeters 1;

xmin -10;
xmax 20;
ymin -10;
ymax 10;
zmin -0.25;
zmax 9.75;
xcells 45;
ycells 30;
zcells 15;

vertices
(
    ($xmin $ymin $zmin)
    ($xmax $ymin $zmin)
    ($xmax $ymax $zmin)
    ($xmin $ymax $zmin)

    ($xmin $ymin $zmax)
    ($xmax $ymin $zmax)
    ($xmax $ymax $zmax)
    ($xmin $ymax $zmax)
);


blocks
(
    hex (0 1 2 3 4 5 6 7) ($xcells $ycells $zcells) simpleGrading (1 1 1)
);

boundary
(
    inlet
    {
        type patch;
        faces
        (
            (0 4 7 3)
        );
    }
    outlet
    {
        type patch;
        faces
        (
            (1 2 6 5)
        );
    }

    ground
    {
        type wall;
        faces
        (
            (0 3 2 1)
        );
    }

    top
    {
        type symmetry;
        faces
        (
            (4 5 6 7)
        );
    }

    side1
    {
        type symmetry;
        faces
        (
            (0 1 5 4)
        );
    }

    side2
    {
        type symmetry;
        faces
        (
            (3 7 6 2)
        );
    }
);
```

现在生成 `blockMesh` 并查看，应该能看到一个长方体。然后在“Mesh Regions”面板只勾选“inlet”、“outlet”和“ground”，并手动导入（File > Open）`car.stl`：

{{< figure src="car.png" title="blockMesh 和自定义 STL 模型" >}}

### xxx

#### 准备文件

这次需要 `meshQualityDict`、`snappyHexMeshDict` 和 `surfaceFeaturesDict` 三个文件：

```bash
cp ofoam_tutorials/incompressibleFluid/windAroundBuildings/system/{meshQualityDict,snappyHexMeshDict,surfaceFeaturesDict} ofoam_practices/car/system
```

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
    object      snappyHexMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#includeEtc "caseDicts/mesh/generation/snappyHexMeshDict.cfg"

castellatedMesh on;
snap            on;
// - addLayers       off;
addLayers       on;

geometry
{
    // - buildings
    car
    {
        // - type triSurface;
        // - file "buildings.obj";
        type triSurfaceMesh;
        file "car.stl";
    }

    refinementBox
    {
        // - type box;
        // - min  (  0   0   0);
        // - max  (250 180  90);
        type searchableBox;
        min  (-1 -1 -0.25);
        max  (4.5 3 2.5);
    }
};

castellatedMeshControls
{
    features
    (
      // - { file  "buildings.eMesh"; level 1; }
      { file  "car.eMesh"; level 1; }
    );

    refinementSurfaces
    {
        // - buildings
        car
        {
            level (3 3);
            patchInfo { type wall; }
        }
    }

    refinementRegions
    {
        refinementBox
        {
            mode    inside;
            // - level   2;
            levels ((2 4));
        }
    }

    // - insidePoint (1 1 1);
    insidePoint (4 0.5 1);
}

snapControls
{
    explicitFeatureSnap    true;
    implicitFeatureSnap    false;
}

addLayersControls
{
    layers
    {
        // "CAD.*"
        car_FACE
        {
            // - nSurfaceLayers 2;
            nSurfaceLayers 8;
        }
    }

    relativeSizes       true;
    expansionRatio      1.2;
    finalLayerThickness 0.5;
    minThickness        1e-3;
}

meshQualityControls
{}

writeFlags
(
    // scalarLevels
    // layerSets
    // layerFields
);

// - mergeTolerance 1e-6;
mergeTolerance 1e-5;

// ************************************************************************* //
```

- `geometry`
    - `refinementBox`：细化指定区域网格。增密模型周围的网格（可以用 ParaView 查看模型的坐标范围）有利于后续的网格贴合等步骤。
- `castellatedMeshControls`
    - `refinementRegions`：细化区域。这里是细化 `refinementBox` 的内部（`inside`）（也有外部或指定一定距离）。
- `addLayersControls`
    - `car_FACE`：指定只在局部（汽车引擎盖）添加边界层。注意名称是 `<file_name>_<surface_name>`

再修改 `surfaceFeaturesDict`，来提取 `car.stl` 的表面特征信息：

```cpp
// surfaces ("buildings.obj");
surfaces ("car.stl");
```

#### 运行

首先提取表面特征：

```bash
surfaceFeatures
```

    ...
    Writing extendedFeatureEdgeMesh to "constant/extendedFeatureEdgeMesh/car.extendedFeatureEdgeMesh"
    Writing extendedEdgeMesh components to "/home/qihuan/Documents/MRA_analysis/ofoam_practices/car/constant/extendedFeatureEdgeMesh/car"
    Writing featureEdgeMesh to "constant/triSurface/car.eMesh"
    ...

发现生成了 `constant/triSurface/car.eMesh` 等文件。

再生成

## snappyHexMesh-GUI 插件

Blender 快捷方式：

- Home：自动调整视图适应当前选中对象。
- F3：按名称搜索操作，如“Tris to Quads”。
    - “Tris to Quads”：将三角面转换为四边形面。
    - “Grid Fill”：在点模式下可以用选择的点填充成面。
- Alt+Z：切换“X-ray”模式，可以选择到背后的点/线/面。
- L：在点编辑模式下，选择与当鼠标下点（通过边）相连的所有点。
- M（Merge by Distance）：按指定长度阈值合并临近的点。
- Shift+D：Duplicate 选择的部分。
- P：分离选择的部分。


插件操作：

1. “Tris to Quads”，可以减少面数，节省算力。
2. “Apply LocRotScale for All”：“This 'normalizes' Object Transforms (location, rotation, scale) to ensure measurements are always unambiguous.”
3. 将 Blender 文件保存到一个专门用于生成的目录，不要在这个目录中求解。
4. “Add Location In Mesh Object”：在选中网格对象中添加一个定位点。这个点可以随意缩小。
5. 在出入口创建面并分离（参考上面的“Shift+D”、“Grid Fill”和“P”）。
6. 依次检查各个对象，设置导出类型。
7. 设置“Cell Length”（越小最后的模型越细），设置“Export Path”，点击“Clean Case Dir”，最后“Export”。
8. 在终端激活 OpenFOAM 环境之后，执行 `blockMesh; surfaceFeatures; snappyHexMesh` 命令，并用 `paraFoam -builtin` 查看结果。


其他：

1. 设置 refinement volume：添加任意网格，取消勾选“Enable Snapping”，“Feature Edge Level”为 0，“Volume Refinement”为“inside”，Level 1。
2. 剪切对象：在右边“Modifiers”（蓝色扳手）选项卡中，添加“Boolean” Modifier。选择“Difference”模式，“Object”选择作为“尘遁·原界剥离之术”的对象。
3. 在名称文本框右侧下拉菜单中，选择“Apply”。



