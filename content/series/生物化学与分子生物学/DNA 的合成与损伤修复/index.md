---
title: "DNA 的合成与损伤修复"
date: 2023-09-27T22:37:30+08:00
lastmod: 2023-11-04T14:56:46+08:00
comments: true
math: false
weight: 120
tags:
    - 生物化学与分子生物学
    - DNA
---

## DNA复制的基本规律

1. DNA 以**半保留复制**方式进行复制：子代 DNA 中保留了亲代的全部遗传信息，亲代与子代 DNA 之间碱基序列高度一致
2. DNA 复制从起点**双向进行**：
    - 原核生物一个起点
    - 真核生物多个起点，每个起点起始的 DNA 复制区称为**复制子**
    - 双向复制在每个复制子两端形成 **2 个复制叉**
3. DNA复制以**半不连续方式**进行
    - DNA 聚合酶只能从 5′ → 3′ 聚合，故必然有一条链不能连续复制
    - 前导链连续复制，后随链不连续复制
    - 冈崎片段：后随链复制延长和解链方向不同
4. DNA 复制具有**高保真性**
    1. **半保留复制**
    2. 严格碱基配对
    3. 错配修复：原核生物 DNA 复制**低错误率**主要与 **DNA pol Ⅰ** 的 3’-5’ 外切酶活性（即时校对功能）有关。
    4. 复制叉的复杂结构：避免过早解旋导致碱基/单链DNA被修饰或水解

{{< tab style="success" >}}
DNA 复制、RNA 合成（转录）、逆转录、密码阅读方向均为 **5′ → 3′**。
{{< /tab >}}

## DNA 复制的酶学和拓扑学

{{< table title="原核生物和真核生物 DNA 聚合酶对比" caption="1：原核生物 DNA pol Ⅰ、Ⅱ、Ⅲ 均有校对活性（3′ → 5′ 外切酶活性），但 DNA pol Ⅱ 主要参与 SOS 修复，DNA pol Ⅲ 主要参与复制延长，发挥校对功能的主要是 **DNA pol Ⅰ**。" id="tbl_原核生物和真核生物-DNA-聚合酶对比" >}}
| <i>E. coli</i> | 真核生物 | 功能                                                                              |
|:--------------:|:--------:|-----------------------------------------------------------------------------------|
|        Ⅰ       |          | {{< hzl "@" >}}去处 RNA 引物，@填补复制中的 DNA 空隙，@DNA 修复和重组、<br/>@**对复制过程中的错误进行校对**<sup>1</sup>{{< /hzl >}} |
|        Ⅱ       |          | {{< hzl "@" >}}复制中的校对<sup>1</sup>，@DNA 损伤的应急修复{{< /hzl >}}          |
|                |     β    | DNA 修复                                                                          |
|                |     γ    | 线粒体 DNA 合成                                                                   |
|        Ⅲ       |     ε    | 前导链合成                                                                        |
|                |     α    | 引物酶                                                                            |
|                |     δ    | 后随链合成                                                                        |
{{< /table >}}

{{< hdt "a 引物，e 前导链 → d 后随链 → c 线粒体 → b 修复" >}}

## 原核生物 DNA 复制过程

{{< figure src="起始复合物形成.png" title="起始复合物形成" style="float-right" >}}

1. 解松超螺旋：**拓扑异构酶**
    - **拓扑异构酶 Ⅰ**：可以切断 DNA 双链中的 **1 条单链**，随后又可以封闭（形成 3',5'-磷酸二酯键，~~结合~~连接 DNA 单链），**不消耗 ATP**
    - *拓扑异构酶 Ⅱ*：可以切断 DNA 双链中的 *2 条单链*，随后又可以封闭，*消耗 ATP*
2. **DnaA**：辨认、结合起始点 oriC（<i>E.coli</i> 上固定起点，富含 AT）
3. 开链：
    - **DnaB**（解旋酶）：解开双链足够用于复制的长度，并且逐步置换出 DnaA
    - **DnaC**：协助 DnaB，将其运到起始部位
4. **SSB**（单链结合蛋白）和已经解开的 DNA 单链结合，稳定开链，保持复制叉的长度
5. 引物合成：**DnaG**（引物酶）
    - **引发体**：引物酶进入后，**DnaB**、**DnaC**、**DnaG** 和**复制起始点**共同构成的起始复合体结构
    - 引物长度一般 5--10 个核苷酸
    - 利福平可以特异性的阻断 RNA 聚合酶，但是引物酶对其不敏感
6. **复制的延长**：**DNA pol Ⅲ**
    - 前导链和后随链用的是同一个酶，故和真核生物有区别——没有酶的转换
    - 关键亚基：
        - ε 亚基：保真
        - 一对 β 亚基：夹住模版链，使酶沿模版滑动
    - 酶活性：5'-3' 聚合、3'-5' 外切（校对）
7. 水解引物：**DNA pol Ⅰ** **大片段**（**Klenow 片段**）：5′-3′ 外切
8. 填补空隙：**DNA pol Ⅰ** 小片段：5′-3′ 聚合、3′-5′ 外切（校对）
9. 连接缺口：DNA 连接酶：
    - 消耗 ATP，连接缺口
    - 只能连接双链中的单链缺口，不能连接单独存在的 DNA 单链或 RNA 单链
    - 是基因工程重要的工具酶之一

{{< tab style="default" summary="DNA pol Ⅱ" >}}
- DNA pol Ⅱ 基因发生突变，细菌依然能存活，推想它是在 pol I 和 pol Ill 缺失情况下暂时起作用的酶。
- DNA pol Ⅱ 对模板的**特异性不高**，即使在已发生损伤的 DNA 模板上，它也能催化核苷酸聚合。因此认为，它参与 DNA 损伤的应急状态修复（SOS 修复）。
{{< /tab >}}

## 真核生物 DNA 复制过程

1. 复制起始和原核生物基本类似，*具体过程不详*。
    - **DNA pol α（引物）、δ（后随链）、ε（前导链）** 参与**复制起始**
    - 特点
        - 每个染色体有上千个复制子，复制起点很多，复制起点较复杂
        - **复制有时序性**，复制子以分组方式激活，而不是同步启动
    - 起点：酵母DNA复制起点含11bp富含AT的核心序列——自主复制序列(和原核生物相比有长有短)
    - DNA 聚合酶：
        - **DNA pol α**：**引物酶**
        - DNA pol β：真核生物 *DNA 修复*
        - DNA pol γ：真核生物*线粒体 DNA* 按 D-环方式复制
        - **DNA pol δ**：**后随链**
        - **DNA pol ε**：**前导链**
    - 解旋酶
    - 拓扑酶
    - 复制因子：RFA、RFC
    - **PCNA**（增殖细胞核抗原）：在**复制的起始和延长**（和中止）中起到重要的作用
        1. 起始：类似于 DNA pol Ⅲ 的 β 亚基，在 RFC 的作用下结合于引物-模板（固定）
        2. 延长：使 DNA pol δ 获得持续合成的能力（α-δ 转换）
        3. 中止：促进[*核小体*]({{< relref "/series/生物化学与分子生物学/核酸的结构与功能#dna-的高级结构" >}})生成
2. 延长过程中发生 DNA 聚合酶转换：α 和 δ 互相转换，转换频率高，**催化速度慢**（~~真核生物复制速度慢~~），PCNA 全程多次发挥作用，**引物、冈崎片段均比原核生物要短**
3. 真核生物 DNA 合成后立即组装成**核小体**

{{< section >}}真核生物 DNA 复制特点{{< /section >}}

- 真核生物染色体DNA在每个细胞周期中只能复制一次
- 真核生物线粒体 DNA 按 D 环方式复制：mtDNA 为闭合环状双链结构
- **端粒酶**解决染色体末端复制问题
    - 意义：维持染色体稳定，DNA 复制的完整性
    - 构成和功能：
        1. 端粒酶 <mark>RNA</mark>（hTR）：提供 **RNA 模版**
        2. <mark>端粒酶逆转录酶</mark>（hTRT）：催化逆转录（RNA 指导的 DNA 聚合酶活性）
        3. 端粒酶协同蛋白 1（hTP1）
    - 过程：
        1. **端粒酶逆转录酶**通过端粒自身的 RNA 模板，指导延长 DNA 母链
        2. *引物酶*：RNA 引物酶通过新合成的母链，合成引物）
        3. 招募 *DNA pol*，以 DNA 母链为模板，沿着新合成的引物进行填充
        4. 水解 RNA 引物

## 逆转录

- **引物**：逆转录的引物由病毒颗粒自身的 **tRNA** 提供。
- **逆转录酶活性**：
    - RNA 指导的 DNA 聚合酶活性（RNA → DNA）：RNA 指导的 DNA 聚合
    - RNase H（Hybrid）活性：水解杂化双链中的 RNA 单链
    - DNA 指导的 DNA 聚合酶活性（DNA → DNA）：DNA 指导的 DNA 聚合（**没有**校对活性）{{< hdt "“DNA 模板也可直接用于/参与逆转录”" >}}
- 逆转录的意义：
    - 遗传信息从 RNA 流动到 DNA
    - 发展了中心法则
    - 拓宽了病毒致癌理论，从逆转录病毒中发现了癌基因（HIV 也是 RNA 病毒，有逆转录活性）
    - 是获取目的基因重要的方法之一——cDNA 法

## DNA 损伤

DNA 损伤的原因与DNA 损伤之间为复杂的多对多关系，掌握**嘧啶二聚体**即可：

{{< section >}}嘧啶二聚体{{< /section >}}

- 原因：**紫外照射**（~~电离辐射~~）
- 损伤类型：DNA 链共价交联（~~碱基损伤~~）
- 修复方式：直接修复（DNA 光裂合酶-光修复）

<!--separator-->

{{< figure src="DNA 损伤类型.png" title="DNA 损伤类型" >}}

- 损伤的类型：{{< hzl >}}碱基损伤与糖基破坏，|碱基之间发生错配，|**DNA 链发生断裂**（**电离辐射**造成 DNA 损伤的主要形式），|链内/链间/DNA-蛋白质，|DNA 链的共价交联（嘧啶二聚体）{{< /hzl >}}
- 损伤的结果：可导致 DNA 模板发生碱基置换、插入、缺失、链的断裂等变化，并影响染色体的高级结构
- 碱基置换
    - 转换：嘌呤换嘌呤或者嘧啶换嘧啶
    - 颠换：嘌呤和嘧啶之间互换
    - 可引起碱基错配,导致基因突变
- 可能但是不一定引起氨基酸编码的改变(简并性)
    - 错义突变：改变氨基酸编码
    - 同义突变：不改变氨基酸编码
    - 无义突变：变为终止密码子
- 碱基插入和缺失：移码突变
- DNA 断裂：阻止 RNA 合成过程中链的延伸

## DNA 损伤修复

1. 直接修复
    - 嘧啶二聚体的直接修复：DNA 光裂合酶-光修复
    - 烷基化碱基的直接修复：烷基转移酶
2. **切除修复**：**最普遍**的 DNA 损伤修复方式
    1. **碱基切除修复**：
        1. 识别水解：**DNA 糖苷酶**，识别受损碱基，去除后形成无碱基位点（AP 位点）
        2. 切除：**无碱基位点核酸内切酶**，切掉剩下的磷酸核糖
        3. 合成：**DNA 聚合酶**合成互补序列
        4. 连接：**DNA 连接酶**将切口重新连接
    2. 核苷酸切除修复：
        - 识别损伤对 DNA 双螺旋结构所造成的扭曲
        - 损伤部位两侧切开 DNA 链，去除切口间的寡核苷酸
        - *DNA 聚合酶*作用下，填补缺损
        - *DNA 连接酶*连接缺口
    3. 碱基错配修复：是碱基切除修复的一种特殊形式
3. **重组修复**：**双链断裂**的修复形式
    - 同源重组修复
    - 非同源末端连接的重组修复
4. 跨越损伤 DNA 合成：应用于 DNA 双链发生大范围损伤时，跨越过损伤部位进行复制，随后再修复
    - 重组跨越损伤修复：拆东墙补西墙，损伤没有被真正的修复，转移到了另一个 DNA 分子上
    - 合成跨越损伤修复：
        - SOS 修复
            - DNA pol Ⅳ、Ⅴ
                - 活性低，识别碱基精确度差，*无校对功能*，故出错的概率较大
                - 产生新的聚合酶（DNA pol Ⅳ、Ⅴ）替代原来的 DNA 聚合酶 Ⅲ
                - 随机插入核苷酸进行合成
                - 跨越损伤后，新的 DNA 聚合酶从 DNA 链上脱离，再由原来的 DNA 聚合酶 Ⅲ 继续复制
            - *DNA pol Ⅱ* 也参与 SOS 修复，但需要*校对*

{{< section >}}DNA 损伤修复的意义{{< /section >}}

- DNA 损伤具有双重效应
    - 可造成 DNA 突变，突变是进化的分子基础
    - 可造成细胞功能障碍，甚至死亡
- DNA 损伤修复障碍与多种疾病相关 {{< hdt "简单看看" >}}
    - **着色性干皮病**：核苷酸切除修复
    - **遗传性*非息肉性*结肠癌**：错配修复、转录偶联修复（**DNA 修复调节基因**）
    - 遗传性乳腺癌：同源重组修复
    - Bloom综合征：非同源末端连接重组修复
    - 范可尼贫血：重组跨越损伤修复
    - Cockyne综合征：核苷酸切除修复、转录偶联修复
    - 毛发低硫营养不良：核苷酸切除修复
