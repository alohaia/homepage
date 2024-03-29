---
title: "原核基因表达调控"
date: 2023-09-29T22:40:43+08:00
lastmod: 2023-10-31T17:46:25+08:00
comments: true
math: false
weight: 162
tags:
    - 生物化学与分子生物学
---

## 原核生物基因组结构特点

1. 基因组中*很少有重复序列*
2. 编码蛋白质的结构基因为*连续编码*，且多为*单拷贝基因*，但编码 rRNA 的基因仍然是多拷贝基因
3. *结构基因*在基因组中所占的比例（约占 50%）*远远大于真核基因组*
4. 许多结构基因在基因组中*以操纵子为单位*排列

## 操纵子是原核基因转录调控的基本单位

1. 结构基因
    - 通常包括数个功能上有关联的基因,它们串联排列,共同构成编码区
    - 这些结构基因共用一个启动子和一个转录终止信号序列,因此转录合成时仅产生一条mRNA长链,为几种不同的蛋白质编码
    - mRNA分子携带了几条多肽链的编码信息,被称为多顺反子mRNA
2. 调控序列
    1. *启动子*：
        - 是 RNA 聚合酶结合的部位，是决定基因表达效率的关键元件
        - 共有序列决定启动子的转录活性大小
    2. *操纵元件*：
        - 是一段能被特异的阻遏蛋白识别和结合的 DNA 序列
        - 操纵序列{{< hdt "（大概就是操纵元件）" >}}
            - 是原核阻遏蛋白的结合位点
            - 当操纵序列结合有阻遏蛋白时会阻碍 RNA 聚合酶与启动子的结合，或使 RNA 聚合酶不能沿 DNA 向前移动，阻遏转录，介导负性调节
    3. 原核操纵子调控序列中还有一种特异的 DNA 序列可结合激活蛋白，结合后 RNA 聚合酶活性增强，使转录激活，介导正性调节，如*CAP 结合位点*
3. 调节基因
    - 编码能够与操纵元件结合的阻遏蛋白
    - 阻遏蛋白可以识别、结合特异的操纵元件,抑制基因转录,所以阻遏蛋白介导负性调节
    - 阻遏蛋白介导的负性调节机制在原核生物中普遍存在
4. 还有一些调控蛋白质对原核基因转录调控起着重要的作用
    - 特异因子
        - 决定 RNA 聚合酶对一个或一套启动序列的特异识别和结合能力
    - 激活蛋白
        - 可结合启动子邻近的DNA序列,提高RNA聚合酶与启动序列的结合能力,从而增强RNA聚合酶的转录活性,是一种正性调节
        - **分解（代谢）物基因激活蛋白**（**CAP**）就是一种典型的激活蛋白

## 乳糖操纵子是典型的诱导型调控

### 乳糖操纵子的结构

{{< figure src="乳酸操纵子.png" title="乳酸操纵子" >}}

- 结构基因：在环境中没有乳糖时，这些基因处于关闭状态，只有当环境中有乳糖时，这些基因才被诱导开放，合成代谢乳糖所需要的酶。
    - Z：β-半乳糖苷酶
    - **Y**：**通透酶**
    - A：乙酰基转移酶
- 乳糖操纵子的调控区
    - 操纵序列 O：结合阻遏蛋白，使操纵子受阻遏而处于关闭状态（负性调节启动子）
    - 启动子 P
    - 在启动子上游还有CAP结合位点（正性调节启动子）
- 调节基因 I
    - I 基因具有独立的启动子（PI），编码一种阻遏蛋白
    - 阻遏蛋白与 O 序列结合，使操纵子受阻遏而处于关闭状态

### 乳糖操纵子受到阻遏蛋白和CAP的双重调节

1. 阻遏蛋白的负性调节：
    - **别乳糖**：
        - 没有乳糖存在时：lac 操纵子处于阻遏状态
            - I 序列在 PI 启动序列作用下表达的 Lac 阻遏蛋白与 O 序列结合，阻碍 RNA 聚合酶与 P 序列结合，抑制转录启动
        - **有乳糖存在时**：lac 操纵子可被诱导
            - **真正的诱导剂并非乳糖本身**
            - 乳糖经通透酶催化、转运进入细胞，再经原先存在于细胞中的少数β-半乳糖苷酶催化，转变为别乳糖
            - **别乳糖**作为一种诱导剂分子，结合阻遏蛋白，使蛋白质构象变化，导致阻遏蛋白与 O 序列解离而发生转录
    - **异丙基硫代半乳糖昔**：
        - 别乳糖的类似物，是一种作用极强的诱导剂，不被细菌代谢而十分稳定，因此在基因工程领域和分子生物学实验中被广泛应用。
2. CAP 的正性调节：
    - **葡萄糖缺乏时**：cAMP 浓度增高，cAMP 与 CAP 结合，这时 CAP 结合在 lac 启动序列附近的 CAP 位点，可刺激 RNA 聚合酶转录活性，使之提高 50 倍
    - 有葡萄糖存在时：cAMP 浓度降低，cAMP 与 CAP 结合受阻，因此 lac 操纵子表达下降
3. 协同调节：
    - Lac 阻遏蛋白阻遏转录时，CAP 对该系统不能发挥作用
    - 如果没有 CAP 存在来加强转录活性，即使阻遏蛋白从操纵序列上解离仍几无转录活性

### 色氨酸操纵子通过阻遏作用和衰减作用抑制基因表达

1. **阻遏作用**：粗略调节
    - 细胞内无色氨酸时：阻遏蛋白不能与操纵序列结合,因此色氨酸操纵子处于开放状态,结构基因得以表达
    - 细胞内色氨酸的浓度较高时：色氨酸作为辅阻遏物与阻遏蛋白形成复合物并结合到操纵序列上，关闭色氨酸操纵子，停止表达用于合成色氨酸的各种酶
2. **转录衰减**：*精确调节*
    - 促进已经开始转录的 mRNA 合成终止
    - 色氨酸操纵子还可通过转录衰减的方式抑制基因表达
    - 这段前导序列称为【衰减子】

{{< tab style="warning" >}}
乳酸操纵子中结构基因的产物是*利用乳酸的酶*，而色氨酸操纵子中结构基因的产物则是*色氨酸*（~~利用色氨酸的酶~~）。
{{< /tab >}}

### 原核基因表达在翻译水平受到精细调控

- 蛋白质分子结合于启动子或启动子周围进行自我调节
    - 调节蛋白结合mRNA靶位点,阻止核糖体识别翻译起始区,从而阻断翻译
    - 自我控制：调节蛋白一般作用于自身mRNA,抑制自身的合成
- 翻译阻遏利用蛋白质与自身mRNA的结合实现对翻译起始的调控：调节蛋白结合到起始密码子上,阻断与核糖体的结合
- 反义RNA利用结合mRNA翻译起始部位的互补序列调节翻译起始：反义RNA含有与特定mRNA翻译起始部位互补的序列,通过与mRNA杂交,阻断30S小亚基对起始密码子的识别及与SD序列的结合,抑制翻译起始
- mRNA密码子的编码频率影响翻译速度：当基因中的密码子是常用密码子时,mRNA的翻译速度快,反之,mRNA的翻译速度慢
