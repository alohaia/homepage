---
title: "蛋白质的结构与功能"
date: 2023-08-06T15:11:41+08:00
lastmod: 2023-11-02T15:21:58+08:00
comments: true
math: true
weight: 10
tags:
    - 生物化学与分子生物学
---


<!--more-->

各种蛋白质的含氮量很接近，平均为 16%，因此测定生物样品的含氮量就可推算出蛋白质大致含量。

## 蛋白质的分子组成

参与蛋白质合成的氨基酸一般有 [20 种](#tbl_氨基酸的分类)，通常是 <i>L</i>-α-氨基酸（除甘氨酸外）。

- 其他参与蛋白质合成的氨基酸：
    - <mark>硒代半胱氨酸在某些情况下也可用于合成蛋白质</mark>（丝氨酸-tRNA 被硒化），不过并不是由目前已知的密码子编码，具体机制尚不完全清楚。
    - 在产甲烧菌的甲胺甲基转移酶中发现了*吡咯赖氨酸*。
    - <i>D</i> 型氨基酸至今仅发现于微生物膜内的 <i>D</i>-谷氨酸、个别抗生素中（例如短杆菌肽含有 <i>D</i>-苯丙氨酸）及低等生物体内（例如蚯蚓 <i>D</i>-丝氨酸）。
- 体内存在<mark>不参与蛋白质合成</mark>但具有重要生理作用的氨基酸，如与合成尿素的鸟氨酸、<mark>**瓜氨酸**</mark>、精氨酸代琥珀酸，以及**同型半胱氨酸**（参与甲硫氨酸循环，由甲硫氨酸转变而来）。

### 氨基酸的分类及特点

{{< table title="氨基酸的分类" id="tbl_氨基酸的分类" >}}
|                                           氨基酸 | 缩写（符号） | 备注                             |                                           氨基酸 | 缩写（符号） | 备注                  |
|-------------------------------------------------:|:------------:|----------------------------------|-------------------------------------------------:|:------------:|-----------------------|
| {{< tc left >}}**非极性脂肪族氨基酸**{{< /tc >}} |              | “一两担饼干补血”；疏水           | {{< tc left >}}**含有芳香环的氨基酸**{{< /tc >}} |              | “芳香老本色”；疏水    |
|                                           甘氨酸 |   Gly（G）   | 不是 <i>L</i>-α-氨基酸           |                                         苯丙氨酸 |   Phe（F）   |                       |
|                                           丙氨酸 |   Ala（A）   |                                  |                                           酪氨酸 |   Tyr（Y）   |                       |
|                                           缬氨酸 |   Val（V）   |                                  |                                           色氨酸 |   Trp（W）   |                       |
|                                           亮氨酸 |   Leu（L）   |                                  |         {{< tc left >}}**酸性氨基酸**{{< /tc >}} |              | “酸性天冬谷”          |
|                                         异亮氨酸 |   Ile（I）   |                                  |                                         天冬氨酸 |   Asp（D）   | 两个羧基              |
|                                           脯氨酸 |   Pro（P）   | 亚氨基酸，易形成折角             |                                           谷氨酸 |   Glu（E）   | 两个羧基              |
|                                         甲硫氨酸 |   Met（M）   | 含硫；又名蛋氨酸                 |         {{< tc left >}}**碱性氨基酸**{{< /tc >}} |              | “碱性精赖组”          |
|     {{< tc left >}}**极性中性氨基酸**{{< /tc >}} |              | “*苏*州*姑*娘*天*天吃肉*丝拌*饭” |                                           精氨酸 |   Arg（R）   | 胍基                  |
|                                           丝氨酸 |   Ser（S）   |                                  |                                           赖氨酸 |   Lys（K）   | <mark>两个氨基</mark> |
|                                         半胱氨酸 |   Cys（C）   | 含硫                             |                                           组氨酸 |   His（H）   | 咪唑基                |
|                                         天冬酰胺 |   Asn（N）   |                                  |
|                                         谷氨酰胺 |   Gln（Q）   |                                  |
|                                           苏氨酸 |   Thr（T）   |                                  |
{{< /table >}}

{{< tab style="warning" >}}
天冬氨酸、谷氨酸是酸性氨基酸，但是天冬酰胺、谷氨酰胺是**中性氨基酸**{{< hdt "（加氨基“中和”了）" >}}。
{{< /tab >}}

酸性氨基酸的侧链都含有羧基；而碱性氨基酸的侧链分别含有胍基（精氨酸）、<mark>氨基（赖氨酸）</mark>、咪唑基（组氨酸）。

- 侧链中含有氨基（-NH<sub>2</sub>）的氨基酸：<mark>赖氨酸</mark> {{< hdt "鸟氨酸也含有两个氨基" >}}
- 侧链中含有酰胺基（NH<sub>2</sub>-CO-）的氨基酸：谷氨酰胺、天冬酰胺
    - 根据官能团取大不取小的原则，一般不认为这些氨基酸的侧链含氨基
- 侧链中含有羧基（含有两个羧基）的氨基酸：天冬氨酸、谷氨酸

{{< tab style="success" summary="氨基酸相关的其他口诀" details=true open=true >}}
1. **必需氨基酸**：“笨蛋来宿舍晾一晾足鞋”：{{< hzl >}}苯丙氨酸、|甲硫氨酸（蛋氨酸）、|赖氨酸、|苏氨酸、|色氨酸、|亮氨酸、|异亮氨酸、|组氨酸[^组氨酸]、|缬氨酸{{< /hzl >}}
2. **支链氨基酸**：“晾一晾鞋*子*（支）”：{{< hzl >}}亮氨酸、|异亮氨酸、|缬氨酸{{< /hzl >}}
3. **一碳单位**：“施舍*一*（一）竹竿”：{{< hzl >}}丝氨酸、|色氨酸、|组氨酸、|甘氨酸{{< /hzl >}}
    - 苏氨酸可转变为甘氨酸，即可间接产生一碳单位。
4. **含硫氨基酸**：“*留*（硫）半筐蛋”：{{< hzl >}}半胱氨酸、|甲硫氨酸（蛋氨酸）{{< /hzl >}}
5. **生酮氨基酸**：“*酮*来两”：{{< hzl >}}赖氨酸、|亮氨酸{{< /hzl >}}
6. **生酮兼生糖氨基酸**：“*剑*一亮，老苏本色”/“一本落色书”：{{< hzl >}}异亮氨酸、|酪氨酸、|苏氨酸、|苯丙氨酸、|色氨酸{{< /hzl >}}

> 组氨酸初以为只针对婴幼儿是必需的，较长期的研究表明，它也是成年人必不可少的必需氨基酸。[^组氨酸]

[^组氨酸]: https://zh.wikipedia.org/zh-hans/%E7%B5%84%E6%B0%A8%E9%85%B8
{{< /tab >}}

脯氨酸和半胱氨酸结构较为特殊：

- <mark>脯氨酸</mark>属于亚氨基酸，其亚氨基仍能与另一羧基形成肽键，<mark>在蛋白质合成加工时可被修饰成羟脯氨酸</mark>。
- 半胱氨酸巯基失去质子的倾向较其他氨基酸为大，其极性最强，2 个半胱氨酸通过脱氢后以二硫键相连接，形成胱氨酸。

### 氨基酸的理化性质

1. **氨基酸具有两性解离的性质**：氨基酸是一种两性电解质，具有两性解离的特性。
    - **等电点**：在某一 pH 的溶液中，氨基酸解离成阳离子和阴离子的趋势及程度相等，成为<mark>兼性离子</mark>，呈电中性，此时色氨酸溶液的 pH 称为该氨基酸的<mark>等电点（pI）</mark>。
    - pI 计算公式为 $pI = \frac{1}{2}（pK_1+pK_2）$，$pK_1$、$pK_2$ 分别为 α-羧基和 α-氨基的解离常数的负对数
2. **含共轭双键的氨基酸具有紫外线吸收性质**：
    - 含有共轭双键的**色氨酸**、**酪氨酸**（主要是**色氨酸的吲哚环**）~~、苯丙氨酸~~"的最大吸收峰在 **280 nm** 波长附近。
    - 由于大多数蛋白质含有*酪氨酸和色氨酸残基*，所以测定蛋白质溶液 280 nm 的光吸收值，是分析溶液中蛋白质含量的快速简便的方法。
3. **氨基酸与茚三酮反应生成蓝紫色化合物**：
    - 茚三酮反应指茚三酮水合物在弱酸性溶液中与氨基酸共加热时，与氨基酸加热分解产生的*氨*结合，生成蓝紫色的化合物，此化合物最大吸收峰在 **570 nm** 波长处。
    - 此吸收峰值的大小与氨基酸释放出的*氨量*成正比，因此可作为氨基酸定量分析方法。

### 氨基酸、肽和蛋白质

氨基酸通过肽键相连，形成肽和蛋白质：

- 寡肽：2--20 个氨基酸相连而成
- 多肽：21--50 个氨基酸相连而成，如 39 个氨基酸残基组成的促肾上腺皮质激素
- 蛋白质：50 个以上氨基酸连接而成，如胰岛素有 51 个氨基酸残基

## 蛋白质的分子结构

{{< table title="蛋白质各级结构的化学键" id="tbl_蛋白质各级结构的化学键" >}}
|          | 化学键                           |
|----------|----------------------------------|
| 一级结构 | **肽键**、二硫键                 |
| 二级结构 | 氢键                             |
| 三级结构 | 疏水键、**盐键**、氢键、范德华力 |
| 四级结构 | 氢键、离子键                     |
{{< /table >}}

### 蛋白质的一级结构：氨基酸的排列顺序 {#蛋白质的一级结构}

在蛋白质分子中，从 N-端至 C-端的氨基酸排列顺序（以及二硫键的位置）称为*蛋白质一级结构*。

一级结构中的主要化学键是*肽键*；此外，蛋白质分子中所有*二硫键*的位置也属于一级结构范畴。

一级结构是蛋白质空间构象和特异生物学功能的基础：<mark>一级结构是蛋白质空间构象的决定因素</mark>，但还需要在一类称为*分子伴侣*的蛋白质辅助下，合成中的蛋白质才能折叠成正确的空间构象。

### 蛋白质的二级结构：多肽链的局部有规则重复的主链构象 {#蛋白质的二级结构}

*蛋白质二级结构*是指蛋白质分子中某一段肽链的局部空间结构，也就是该段肽链主链骨架原子的相对空间位置，**并不涉及氨基酸残基侧链的构象**。

{{< tab style="default" summary="肽单元" >}}
参与肽键形成的 6 个原子在同一平面上，这 6 个原子构成了所谓的肽单元。

肽单元中，除肽键（有一定的双键性）外均为普通的单键，可以自由旋转。相邻两个肽单元之间的 C 原子所连的两个单键的自由旋转角度，决定了两个相邻的肽单元平面的相对空间位置。
{{< /tab >}}

#### α-螺旋

{{< figure src="α-螺旋.png" img-width="250px" title="α-螺旋" style="float-right" >}}

- 多肽链的主链围绕中心轴作有规律的螺旋式上升（<mark>螺旋方向与长轴平行</mark>）。
- 螺旋的走向为顺时针方向，即所谓<mark>**右手螺旋**</mark>，每 **3.6 个氨基酸残基**螺旋上升一圈，螺距为 **0.54 nm**。
- **氨基酸侧链伸向螺旋外侧**（与 DNA 双螺旋结构相反，这里不需要保护残基，而是需要残基外漏以发挥功能），氨基酸残基的排列可以使 α-螺旋具有两性特点：由 3--4 个疏水氨基酸残基组成的肽段与由 3--4 个亲水氨基酸残基组成的肽段交替出现，致使 α-螺旋的一侧为疏水性氨基酸，另一侧为亲水性氨基酸，使之能在极性或非极性环境中存在。
- <mark>氢键起维持 α-螺旋稳定性的作用</mark>，α-螺旋的每个肽键的 N-H 和第四个肽键的氨基氢形成氢键，氢键的方向与螺旋长轴基本平行。
- **α-螺旋见于**：肌红蛋白和血红蛋白分子、毛发的**角蛋白**、肌组织的肌球蛋白、血凝块中的纤维蛋白。

#### β-折叠

{{< figure src="β-折叠.png" title="β-折叠" >}}

β-折叠呈折纸状，通过肽链间的肽键羟基氧和亚氨基形成氢键来维持稳定性。

*蚕丝蛋白*几乎都是 β-折叠结构，许多蛋白质既有 α-螺旋又有 β-折叠结构。

#### β-转角

- 第二个残基常为*脯氨酸*
- 通常由 4 个氨基酸残基构成，其中第一个残基的羟基氧与第四个残基的氨基氢可以形成*氢键*

<!-- TODO: link here 肽脯氨酰基顺-反异构酶 -->

#### Ω-环

- 存在于*球状蛋白质*中的一种二级结构
- 总是出现在蛋白质分子的表面，而且以亲水残基为主，在*分子识别*中可能起重要作用

### 蛋白质的超二级结构：结构模体 {#结构模体}

<mark>结构模体</mark>
: 蛋白质分子中具有特定空间构象和特定功能的结构成分，可由 2 个或 2 个以上二级结构肽段组成，为<mark>超二级结构</mark>。
: 常见的结构模体有{{< hzl >}}α-螺旋-β-转角（或环）-α- 螺旋模体（见于多种 DNA 结合蛋白）；|链-β-转角-链（见于反平行 B 折叠的蛋白质）；链-β-转角-α-螺旋-β-转角-链模体（见于多种 α-螺旋/β-折叠蛋白质）{{< /hzl >}}。
: α-螺旋之间、β-折叠之间、α-螺旋与β-折叠之间的相互作用，主要是由*非极性氨基酸残基*参与的

{{< figure src="蛋白质超二级结构与模体.png" caption="（a）βαβ；（b）ββ；（c）亮氨酸拉链；（d）α-螺旋-环-α-螺旋；（e）锌指结构" title="蛋白质超二级结构与模体" >}}

- <mark>亮氨酸拉链</mark>：
    - 出现在 *DNA 结合蛋白*和其他蛋白质中的一种结构模体，往往与癌基因表达调控功能有关。
    - 两个 α-环方向平行，疏水面相互作用；亮氨酸有规律地每隔 6 个氨基酸就出现一次。
- <mark>螺旋-环-螺旋</mark>：
    - 许多*钙结合蛋白*分子中的一个结合钙离子的模体。
    - 在环中有几个恒定的亲水侧链，侧链末端的氧原子通过氢键而结合钙离子。
- <mark>锌指</mark>：
    - 由 1 个 α-螺旋和 2 个反平行的 β-折叠组成。
    - N-端有 1 对半胱氨酸残基，C-端有 1 对组氨酸残基，此 4 个残基在空间上形成一个洞穴，恰好容纳 1 个 Zn<sup>2+</sup>。
    - Zn<sup>2+</sup> 可稳固模体中的 α-螺旋结构，使此 α-螺旋能镶嵌于 DNA 的大沟中，因此*含锌指结构的蛋白质都能与 DNA 或 RNA 结合*。

### 蛋白质的三级结构：整条肽链中全部氨基酸残基的相对空间位置 {#蛋白质的三级结构}

<em>蛋白质<mark>三级结构</mark></em>是指整条肽链中全部氨基酸残基的相对空间位置，也就是<mark>整条肽链所有原子在三维空间的排布位置</mark>。

蛋白质合成后，在一定的条件下，可能只形成一种正确的空间构象。除一级结构为决定因素外，还需要在一类称为**分子伴侣**的蛋白质辅助下，合成中的蛋白质才能折叠成正确的空间构象。

#### 结构域

结构域
: 分子量较大的蛋白质常可折叠成多个结构较为紧密且稳定的区域，并各行其功能，称为结构域。
: 结构域也可看作是球状蛋白质的独立折叠单位，有较为独立的三维空间结构。

3-磷酸甘油醛脱氢酶，第一个结构域能与 NAD<sup>+</sup> 结合，第二个结构域与底物 3-磷酸甘油醛结合。

### 蛋白质的四级结构：亚基之间呈特定的三维空间排布 {#蛋白质的四级结构}

在含有多条肽链的蛋白质中，每一条多肽链都有其完整的三级结构，称为*亚基*，亚基与亚基之间呈特定的三维空间排布，并以非共价键相连接。蛋白质分子中各个亚基的空间排布及亚基接触部位的布局和相互作用，称为*蛋白质四级结构*。

在四级结构中，各亚基间的结合力主要是*氢键*和*离子键*。

对于 2 个以上亚基构成的蛋白质，单一亚基一般没有生物学功能，完整的四级结构是其发挥生物学功能的保证。

## 蛋白质的分类

- 根据组成成分分类
    - 单纯蛋白质：只含氨基酸
    - 缀合蛋白质：除蛋白质部分外，还含有非蛋白质部分，为蛋白质的生物学活性或代谢所依赖。结合蛋白质中的非蛋白质部分被称为辅基，绝大部分辅基是通过共价键方式与蛋白质部分相连。
- 根据形状分类
    - 纤维状蛋白质：多数为*结构蛋白质*，*较难溶于水*，作为细胞坚实的支架或连接各细胞、组织和器官的细胞外成分，如胶原蛋白、弹性蛋白、角蛋白等。
    - 球状蛋白质：形状近似于球形或椭球形，多数*可溶于水*，许多具有*生理学功能*的蛋白质如酶、转运蛋白、蛋白质类激素、代谢调节蛋白、基因表达调节蛋白及免疫球蛋白等都属于球状蛋白质。

## 蛋白质结构与功能的关系

- 蛋白质的主要功能：
    1. 构成细胞和生物体结构：结构蛋白
    1. 物质运输：血红蛋白、运铁蛋白、激素结合蛋白等
    1. 催化功能：酶
    1. 信息交流：膜受体、衔接蛋白
    1. 免疫功能：抗体、淋巴因子
    1. 氧化供能：氧化供能（饥饿）
    1. 维持机体的酸缄平衡：蛋白质缓冲系统
    1. 维持正常的血浆渗透压：清蛋白
- 蛋白质执行功能的主要方式：
    1. 蛋白质与小分子相互作用：酶的催化作用、物质转运、信息传递等
    2. 蛋白质与核酸的相互作用：
        - DNA-蛋白质：蛋白质有几种[模体](#结构模体)，如锌指模体、亮氨酸拉链、螺旋-转角-螺旋等专门结合 DNA 并发挥生物学效应。
        - RNA-蛋白质：
            1. 核糖体：细胞内蛋白质合成的场所，核糖体的两个亚基由精确折叠的蛋白质和 rRNA 组成
            2. 端粒酶：一种由催化蛋白和 RNA 模板组成的酶，可合成染色体末端的 DNA
            3. 剪接体：指进行 RNA 剪接时形成的多组分复合物，主要是由小分子的核 RNA 和蛋白质组成
    3. 蛋白质相互作用：指两个或两个以上的蛋白质分子通过非共价键相互作用并发挥功能的过程，是蛋白质执行功能的主要方式。
        - 物质代谢、信号转导、蛋白质翻译、蛋白质分泌、蛋白质剪切、细胞周期调控等均受蛋白质间相互作用的调控
        - 通过蛋白质间相互作用，可改变细胞内酶的动力学特征，也可产生新的结合位点，改变蛋白质对底物的亲和力
        - 举例：主要组织相容性复合物参与的分子识别、抗原与抗体的特异性结合

### 蛋白质的一级结构与功能的关系

- **一级结构是空间构象的基础**（决定因素，但不是唯一因素）：<mark>尿素对核糖核酸酶 A 的影响</mark>可以证明空间构象遭破坏的核糖核酸酶 A 只要其一级结构（氨基酸序列）未被破坏，就有可能回复到原来的三级结构，功能依然存在：
    1. 变性：用尿素（或盐酸胍）和 β-琉基乙醇处理核糖核酸酶 A，分别破坏次级键和二硫键，使其二、三级结构遭到破坏，但肽键不受影响、一级结构仍存在，此时该酶活性丧失殆尽。
    2. 复性：当用透析方法去除尿素和 β-琉基乙醇后，松散的多肽链循其特定的氨基酸序列，卷曲折叠成天然酶的空间构象，4 对二硫键也正确配对，这时酶活性又逐渐恢复至原来水平。
- 一级结构相似的蛋白质具有相似的高级结构与功能
- 氨基酸序列与生物进化信息：**氨基酸序列包含重要的生物进化信息**，物种间越接近，则一级结构越相似，其空间构象和功能也相似。
- 重要蛋白质的*氨基酸序列改变*（**一级结构改变**）可引起疾病。这种蛋白质分子发生变异所导致的疾病，被称之为**分子病**，其病因为基因突变。
    - **镰状细胞贫血**：基因点突变，导致血红蛋白 β 亚基的第 6 位氨基酸，谷氨酸变成了缬氨酸导致蛋白质聚集成丝，相互黏着，使红细胞变形成为锁刀状而极易破碎，产生贫血。
    - **肌营养不良**：基因大片段碱基缺失导致大片段肽链的缺失。

### 蛋白质的功能依赖特定空间结构

#### 血红蛋白和肌红蛋白结构相似

- 血红蛋白和肌红蛋白一级结构相似，但功能不同：血红蛋白的主要功能是运输氧，而肌红蛋白的主要功能是储存氧。
- 血红蛋白和肌红蛋白的高级结构不同：
    - 肌红蛋白是一个只有三级结构的单链蛋白质。
    - 血红蛋白是由 4 个亚基组成的四级结构：成年人红细胞中的 Hb 主要由 2 条 α 肽链和 2 条 β 肽链（α<sub>2</sub>β<sub>2</sub>）组成（存在较少的 α<sub>2</sub>δ<sub>2</sub>），胎儿期的 Hb 主要为 α<sub>2</sub>γ<sub>2</sub>，胚胎期为 α<sub>2</sub>ε<sub>2</sub>，而**镰状细胞贫血**病人红细胞中的 Hb 为 **α<sub>2</sub>S<sub>2</sub>**。

#### 蛋白质构象变化可引起疾病

若蛋白质的折叠发生错误，使蛋白质的构象发生改变，可导致*蛋白质构象疾病*（**一级结构正常**）。有些蛋白质错误折叠后相互聚集，常形成抗蛋白水解酶的淀粉样纤维沉淀，产生毒性而致病，这类疾病包括人纹状体脊髓变性病、**阿尔茨海默病**（Alzheimer disease）、**亨廷顿病**（Huntington disease）、<mark>**疯牛病**</mark>等。

{{< tab style="default" summary="疯牛病" details=true open=true >}}
疯牛病是由朊病毒蛋白（prion protein，PrP）引起的一组人和动物神经退行性病变。

正常的富含 **α-螺旋**的 PrP<sup>C</sup> 在某种未知蛋白质的作用下可转变成分子中大多数为 **β-折叠**的 PrP<sup>Sc</sup>。外源或新生的 PrP<sup>Sc</sup> 可以作为模板，通过复杂的机制诱导 PrP<sup>C</sup> 重新折叠成为 PrP<sup>Sc</sup> 并可形成聚合体。 PrP<sup>Sc</sup> 对蛋白酶不敏感，水溶性差，而且对热稳定，可以相互聚集，最终形成淀粉样纤维沉淀而致病。
{{< /tab >}}

## 蛋白质的理化性质

1. 蛋白质具有**两性电离性质**：体内各种蛋白质的等电点不同，但大多数接近于 **pH 5.0**。所以在人体体液 pH 7.4 的环境下，大多数蛋白质解离成**阴离子**（所以蛋白质大多带负电）。
    - **碱性蛋白质**：大多数数蛋白质含碱性氨基酸较多，其等电点偏于碱性，如**鱼精蛋白**、**组蛋白**{{< hdt "（“碱性精赖组”）" >}}等。
    - **酸性蛋白质**：少量蛋白质含酸性氨基酸较多，其等电点偏于酸性，如**胃蛋白酶**和**丝蛋白**等。
2. 蛋白质具有**胶体性质**：
    1. **水化膜**：蛋白质颗粒表面大多为亲水基团，可吸引水分子，使颗粒表面形成一层水化膜，从而阻断蛋白质颗粒的相互聚集，防止溶液中蛋白质沉淀析出。
    2. **电荷**：蛋白质胶粒表面可带有电荷，也可起胶粒稳定的作用。
3. 蛋白质的**变性与复性**：
    1. <mark>**变性**</mark>：在某些物理和化学因素作用下，其<mark>特定的空间构象被破坏</mark>，也即有序的空间结构变成无序的空间结构，从而导致其理化性质的改变和生物学活性的丧失。
        - 许多蛋白质变性后，空间构象被严重破坏，不能复原，称为*不可逆性变性*。
        - 蛋白质的变性主要发生二硫键和非共价键的破坏，不涉及一级结构中氨基酸序列的改变。
        - 蛋白质变性后，其理化性质及生物学性质发生改变：{{< hzl >}}<mark>溶解度降低</mark>、|**黏度增加**（核酸变性黏度降低）、|结晶能力消失、|生物学活性丧失、|易被蛋白酶水解{{< /hzl >}}。
    2. **沉淀**：
        - 蛋白质变性后，疏水侧链暴露在外，肽链融汇相互缠绕继而聚集，发生沉淀。
        - 有时蛋白质可仅发生沉淀，并不变性。
    3. **复性**：若蛋白质变性程度较轻，去除变性因素后，有些蛋白质仍可恢复或部分恢复其原有的构象和功能。
    4. **凝固**：凝固是蛋白质变性后进一步发展的不可逆的结果。蛋白质经强酸、强碱作用发生变性后，仍能溶解于强酸或强碱溶液中，若将 pH 调至等电点，则变性蛋白质立即结成絮状的不溶解物，此絮状物仍可溶解于强酸和强碱中。如再加热则絮状物可变成比较坚固的凝块，此凝块不易再溶于强酸和强碱中。
4. 蛋白质**在紫外光谱区有特征性光吸收**：见[氨基酸的理化性质](#氨基酸的理化性质)
5. 应用蛋白质**呈色反应**可测定溶液中**蛋白质含量**：
    1. **茚三酮反应**：见[氨基酸的理化性质](#氨基酸的理化性质)
    2. **双缩脲反应**：蛋白质和多肽分子中的*肽键*（*氨基酸不出现双缩脲反应*）在稀碱溶液中与硫酸铜共热，呈现**紫色**或*红色*。
