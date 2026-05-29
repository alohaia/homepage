---
title: "并行计算"
date: 2026-05-06T11:46:32+08:00
lastmod: 2026-05-07T13:08:13+08:00
comments: true
weight: 3
tags:
    - OpenFOAM
    - CFD
---

OpenFOAM 中并行计算的方法称为*域分解*（domain decomposition），指将几何体以及相关的场分割为若干个部分并分配给多个处理器分别求解。域分解的过程包括：{{< hzl "；" >}}[分解网格和场](#分解场和初始场)；并行运行[应用]({{< relref "应用和库" >}})；后处理（post-processing）被分解的算例{{< /hzl >}}。

OpenFOAM 的并行计算默认使用 *MPI*（*message passing interface*）的开源实现 [OpenMPI](https://www.open-mpi.org/)。

<!--more-->

## 分解场和初始场

使用 `decomposePar` 来进行分解，并可以通过修改 `system/decomposeParDict` 来控制行为。使用 `foamGet` 来获得一个示例 `decomposeParDict` 文件：

```bash
foamGet decomposeParDict
```


    Multiple files with "decomposeParDict" prefix found:
    1) /opt/OpenFOAM/OpenFOAM-13/etc/caseDicts/annotated/decomposeParDict
    2) /opt/OpenFOAM/OpenFOAM-13/etc/caseDicts/preProcessing/decomposeParDict
    ** Note: it is easier to use files NOT in the "annotated" directory

    Enter file number (1-2) to obtain description (suggest 2) : 2
    Copying /opt/OpenFOAM/OpenFOAM-13/etc/caseDicts/preProcessing/decomposeParDict to system

```cpp
// system/decomposeParDict
FoamFile
{
    format      ascii;
    class       dictionary;
    object      decomposeParDict;
}

numberOfSubdomains  8;

/*
    Main methods are:
    1) Geometric: "simple"; "hierarchical", with ordered sorting, e.g. xyz, yxz
    2) Scotch: "scotch", when running in serial; "ptscotch", running in parallel
*/

method              hierarchical;

simpleCoeffs
{
    n               (4 2 1); // total must match numberOfSubdomains
}

hierarchicalCoeffs
{
    n               (4 2 1); // total must match numberOfSubdomains
    order           xyz;
}
```

`"simple"` 和 `"hierarchical"` 分割方法在示例文件中介绍了。每个方法可以通过 `<method>Coeffs` 设置*参数*（coefficients）。`"scotch"` 方法会自动尝试最小化*处理器边界*的数量，可以使用 `processorWeights` 指定各个处理器的权重，以及用 `strategy` 来通过一个复杂的字符串指定分割策略。

`decomposeParDict` *字典*（directory）的完整选项如下：

- `numberOfSubdomains`: total number of subdomains.
- `method`: method of decomposition, `simple`, `hierarchical`, `scotch`.
- `n`: for `simple` and `hierarchical`, number of subdomains, `(nx, ny, nz)`.
- `order`: for `hierarchical`, order of hierarchical decomposition, `xyz`/`xzy`/`yxz`…
- `processorWeights` option for `scotch`: list of weighting factors `(<wt1> … <wtN>)` for allocation of cells to processors; `<wt1>` is the weighting factor for processor 1, etc.; weights are normalised so can take any range of values.


