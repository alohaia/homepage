---
title: 2026-03-27
date: 2026-03-27T20:05:56+08:00
lastmod: 2026-03-27T20:44:49+08:00
draft: true
comments: true
---

<!--more-->

```mermaid
flowchart LR
    A[Acetyl-CoA (2C)] -->|+ Oxaloacetate (4C)\nCitrate Synthase| B[Citrate (6C)]
    B -->|Aconitase| C[Isocitrate (6C)]
    C -->|Isocitrate Dehydrogenase\nNAD+ → NADH + CO₂| D[α-Ketoglutarate (5C)]
    D -->|α-Ketoglutarate Dehydrogenase\nNAD+ → NADH + CO₂| E[Succinyl-CoA (4C)]
    E -->|Succinyl-CoA Synthetase\nGDP + Pi → GTP| F[Succinate (4C)]
    F -->|Succinate Dehydrogenase\nFAD → FADH₂| G[Fumarate (4C)]
    G -->|Fumarase\n+ H₂O| H[Malate (4C)]
    H -->|Malate Dehydrogenase\nNAD+ → NADH| I[Oxaloacetate (4C)]
    I -->|Cycle Continues| A

    %% 补充能量产物
    C -.-> NADH1[NADH]
    D -.-> NADH2[NADH]
    H -.-> NADH3[NADH]
    F -.-> FADH2[FADH₂]
    E -.-> GTP[GTP]

    %% 标注CO2释放
    C -.-> CO2_1[CO₂]
    D -.-> CO2_2[CO₂]
```

```graphviz
digraph TCA {
    layout=circo;
    overlap=false;
    splines=true;

    node [shape=ellipse, style=filled, fillcolor="#E8F0FE", fontname="Helvetica"];

    A [label="Acetyl-CoA"];
    B [label="Citrate"];
    C [label="Isocitrate"];
    D [label="α-Ketoglutarate"];
    E [label="Succinyl-CoA"];
    F [label="Succinate"];
    G [label="Fumarate"];
    H [label="Malate"];
    I [label="Oxaloacetate"];

    edge [fontname="Helvetica"];

    A -> B [label="Citrate synthase"];
    B -> C [label="Aconitase"];
    C -> D [label="Isocitrate dehydrogenase\nNAD+ → NADH + CO2"];
    D -> E [label="α-KG dehydrogenase\nNAD+ → NADH + CO2"];
    E -> F [label="Succinyl-CoA synthetase\nGDP → GTP"];
    F -> G [label="Succinate dehydrogenase\nFAD → FADH2"];
    G -> H [label="Fumarase\n+ H2O"];
    H -> I [label="Malate dehydrogenase\nNAD+ → NADH"];
    I -> B [label="Cycle continues"];

    // 辅助节点（能量分子）
    NADH1 [label="NADH", shape=box, fillcolor="#FFF3CD"];
    NADH2 [label="NADH", shape=box, fillcolor="#FFF3CD"];
    NADH3 [label="NADH", shape=box, fillcolor="#FFF3CD"];
    FADH2 [label="FADH2", shape=box, fillcolor="#FFF3CD"];
    GTP [label="GTP", shape=box, fillcolor="#D4EDDA"];
    CO2_1 [label="CO2", shape=box, fillcolor="#F8D7DA"];
    CO2_2 [label="CO2", shape=box, fillcolor="#F8D7DA"];

    // 虚线连接（表示生成）
    C -> NADH1 [style=dashed];
    D -> NADH2 [style=dashed];
    H -> NADH3 [style=dashed];
    F -> FADH2 [style=dashed];
    E -> GTP [style=dashed];

    C -> CO2_1 [style=dashed];
    D -> CO2_2 [style=dashed];
}
```
