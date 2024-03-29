---
title: "嘧啶核苷酸代谢"
date: 2023-08-09T12:10:17+08:00
lastmod: 2023-11-03T15:26:27+08:00
comments: true
math: false
weight: 93
tags:
    - 生物化学与分子生物学
    - 核苷酸
---

- 原料：{{< hzl >}}*磷酸核糖焦磷酸*（*PRPP*）（直接参与合成）、|谷氨酰胺、|天冬氨酸（*构成骨架*）、|CO<sub>2</sub>{{< /hzl >}}、~~甘氨酸~~
    - dUMP → dTMP：N<sup>5</sup>,N<sup>10</sup>-亚甲 FH<sub>4</sub>
- 合成部位：线粒体 + 细胞质
- 合成器官：主要是肝

<!--more-->

## 合成代谢

### 从头合成

{{< figure src="嘧啶核苷酸从头合成.png" title="嘧啶核苷酸从头合成" >}}

1. 第一阶段：合成乳清酸（嘧啶碱）
2. 第二阶段：接上 PRPP 变成乳清酸核苷酸，并进一步转变为 UMP（核苷酸）
3. 第三阶段：从 UMP 开始向后分类

{{< figure src="嘧啶核苷酸转化.svg" embed=true caption="注意：TMP 即 dTMP，人体中仅存在胸腺嘧啶*脱氧*核糖核苷酸。" title="嘧啶核苷酸转化" >}}

{{< section >}}嘧啶核苷酸从头合成的调节{{< /section >}}

- 关键酶：**氨基甲酰磷酸合成酶 Ⅱ（CPS-Ⅱ）**
- 负反馈抑制：
    - 氨基甲酰磷酸合成酶 Ⅱ（哺乳动物）：**UMP**（第二阶段的产物）
    - 天冬氨酸氨基甲酰基转移酶（细菌）：**CTP**（第三阶段的产物）
    - PRPP 合成酶：嘌呤核苷酸、嘧啶核苷酸

{{< tab style="warning" >}}
不同于尿素合成的 CPS-Ⅰ（在线粒体中），氨基甲酰磷酸合成酶 Ⅱ 存在于**细胞质**中。
{{< /tab >}}

### 补救合成

1. 嘧啶磷酸核糖转移酶（即从头合成过程中的乳清酸磷酸核糖转移酶）：
    - 嘧啶 + PRPP → 磷酸嘧啶核糖 + PPi
    - 嘧啶：尿嘧啶、胸腺嘧啶、乳清酸
2. 尿苷激酶：U → UMP
3. 胸苷激酶：胸腺嘧啶核苷 → dTMP（只有腺嘌呤核苷、胸腺嘧啶核苷有对应激酶）

### 抗代谢物

1. 嘧啶类似物
    1. **5-氟尿嘧啶**（**5-FU**）：类似胸腺嘧啶（T{{< hdt "：5-甲基尿嘧啶" >}}），但*无活性*
    2. FdUMP（dUMP 类似物）：是**胸苷酸合酶**的抑制剂
    3. FUTP：以 FUMP 的形式掺入 RNA 分子，破坏 RNA 的结构和功能
2. 氨基酸类似物：氮杂丝氨酸：UTP → CTP
3. 叶酸类似物：影响一碳单位供给
    - 甲氨喋呤（MTX）：使 N<sup>5</sup>，N<sup>10</sup>-亚甲 FH<sub>4</sub> 产生不足
        - dUMP → dTMP
4. 核苷类似物：阿糖胞苷：CDP → dCDP（抑制**核糖核苷酸还原酶**）

## 分解代谢

{{< figure src="嘧啶碱的分解代谢.png" title="嘧啶碱的分解代谢" >}}

- **胞嘧啶**（**C**）→ **尿嘧啶**（**U**）→ 二氢尿嘧啶 →
    - **β-丙氨酸** → 丙二酸单酰 CoA → 丙二酸单酰 CoA → 乙酰 CoA → 三羧酸循环
    - CO<sub>2</sub> + NH<sub>3</sub> → 去肝脏合成尿素
- **胸腺嘧啶**（**T**）→ β-脲基异丁酸 →
    - **β-氨基异丁酸**{{< hdt "（“T”和“丁”和“糖——Tang”）" >}}→ 琥珀酰CoA → 三羧酸循环/糖异生
    - CO<sub>2</sub> + NH<sub>3</sub> → 去肝脏合成尿素


