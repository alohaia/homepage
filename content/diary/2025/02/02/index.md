---
title: 2025-02-02 RNA-seq 概览
date: 2025-02-02T20:05:19+08:00
lastmod: 2025-02-02T23:43:10+08:00
comments: true
math: true
---

<!--more-->

主要参考：[知乎回答](https://www.zhihu.com/question/350581932/answer/3167834869)。

{{< tab style="warning" summary="" details=true >}}
[知乎回答](https://www.zhihu.com/question/350581932/answer/3167834869)中有误，缩放因子应该放在分子。
{{< /tab >}}

## 测序原理

- 测序深度和测序覆盖率：
    - 测序深度（Sequencing depth）：也叫乘数，指每个碱基被测序的平均次数，是衡量测序量的首要参数。
    - 测序覆盖度（Coverage）：也叫覆盖率，指被测序到的碱基占全基因组大小的比率。
    - 测序深度与测序覆盖度的举例：使用 illumina 2000 测序仪完成一次人类基因组（3G 大小）单端测序，即可得到 300G 数据（假设全部是有效数据），理论的测序深度即为 100 倍（300G/3G），常见表示为 100X。将所有读段（reads）比对到人类基因组，如果发现只有 2.7G 的碱基至少有 1 个读段覆盖到，其实际测序深度即为（300G/2.7G）。测序覆盖度（Coverage）为 90%（2.7G/3G）。
- 建库（library preparation）：当开始一个 RNA-seq 实验（其他实验如 qRT-PCR 也是一样）时，每一个样本的 RNA 都需要被提取并转化为可用于测序的 cDNA 文库。（建库的原因：双链的 cDNA 比单链的 RNA 更加稳定）
- 测序仪的核心元件为流动池（Flow cell），流动池内部又细分为多个结构如下：以 illumina 2000 测序仪为例，一次运行（Run）可以使用 2 个流动池（Flow cell），每个流动池上有 8 个泳道（Lane），每个泳道包含 2 个面（Surface），每个面有 3 个条（Swath）或称为列（Column），每一列由 16 个小区（Tile）组成，每个小区中包含大量的 DNA 簇（Cluster），小区（Tile）是每一次测序荧光扫描的最小单位。由流动池结构的介绍我们可知高通量名称的由来，即复杂的层级式的流动池结构可以保证容纳更多的 DNA/cDNA 样本，获得海量的测序数据。
- RNA 片段化：即提取总的 RNA 并将其片段化，生成较短的 RNA 片段。最终文库中目的片段的大小是文库构建的关键参数。DNA 片段化通常采用物理方法（声学剪切和超声处理）或酶学方法（RNase I 或碱性水解）进行。一般测定人类基因组时，打断为 300-500bp 长的片段。
- 桥式 PCR（Bridge PCR）：
    - Tile 上排列着许多一端共价结合在 tile 表面的互补短核苷酸引物（complementary oligos），这些引物与接头序列互补。
    - cDNA变性，单链一端（这端为接头序列，另一端也是接头序列，不过是互补序列）与tile表面的一个短序列互补配对。然后合成双链，新合成的单链一端即为共价结合在tile表面的互补短核苷酸引物，另一端则为接头序列可以与短核苷酸互补序列结合，形成桥状结构。这样反复几轮，就形成了簇（cluster）。
- 所谓“边合成边测序”：一轮添加一种核苷酸（碱基被荧光基团标记），观察每轮中每个簇的荧光强度变化，即可得知此次是否新连接了核苷酸，从而获得每个簇的序列信息。

## 测序结果后处理

### 评估测序结果的质量分数（质控指标）

FastQC 结果解读见[这个回答](https://www.zhihu.com/question/350581932/answer/3167834869)的“FASTQ格式文件解读与质控”部分。常用质量控制指标：

- Q20 过滤：即需要保证全部 reads 的所有位置的 Q<sub>Phred</sub>10% 分位数 \>20，对于 Q\<20 位置处的碱基，则需要切除这些位置的碱基再进行后续分析。
- 清除全部的接头序列（adapter）
- 去除 N 碱基\>5% 的 reads
- 去除 A 与 T 或 C 与 G 含量相差 10%reads
- 去除按上述标准切除碱基后长度过短的 reads

%GC 也是需要重点关注的一个指标，这个值表示整体序列中的 GC 含量，具有物种特异性，可用于区分不同物种，人类细胞一般在 42% 左右。

### 测序结果的比对和拼接 {alias="转录组上游分析"}

转录组上游分析的主要任务是将测序获得的海量reads组装成目标基因组或转录组，一般有比对和拼接两种策略。

- 比对（又称为回帖）是将 reads 定位到参考基因组或转录组上，然后再拼接成连续序列；
- 拼接（又称为从头组装（Denovo assembly）），是在没有参考基因组或者转录组的前提下，根据 reads 之间的重叠区，把所有 reads 拼接起来，直接获得基因组或转录组。

构建转录本：由于基因中存在内含子序列，而只有外显子序列才会被表达出来，因此导致回帖的结果并不能反应基因的表达情况，所以需要通过进一步构建拼接出转录本。借助 cufflinks 或者 stringtie 软件并结合基因注释文件 GTT/GTF（记录着染色体上基因编码区和外显子区域的位置信息），可以从回帖到参考基因组上的 reads 中筛选出与外显子区域匹配的 reads，进一步将其拼接成转录本，统计该转录本出现的次数，即获得该基因的初始 reads count 值。

{{< figure src="比对和转录本拼接.jpg" title="比对和转录本拼接" style="normal" >}}

## 转录组下游分析

通过转录组上游分析（针对 mRNA 建库测序—将测序的 FASTQ 文件 mapping 到参考基因组上—结合参考基因组的 GTF/GFF 文件构建转录本—获得全基因组的每一个 gene 上 mapping 到了多少 reads count）可以获得每个基因初始的 reads count 值，这是基因表达量的最原始数据，但直接使用 reads count 值比较不同样本处理组之间基因表达量的变化会导致一系列问题，因此需要对 reads count 值进行校正处理。最常用的三个校正后的指标为 **RPKM**、**FPKM** 和 **TPM**。

要解释 RPKM（Reads Per Kilobase per Million mapped reads），先要解释 RPK（Reads Per Kilobase）和 RPM（Reads per million mapped reads）。RPK 等于映射到一个基因的 reads 数除以该基因的全部外显子的碱基数（可以大致理解为该基因转录本的长度），再乘以一个缩放因子 1000：

$$RPK(gene_A) = \frac{nMappedReads(gene_A)}{lenTotalExons(gene_A) \times 1000}
\,.$$

RPM 则等于映射到一个基因的 reads 数除以映射到所有基因的 reads 之和，再乘以一个缩放因子 10^6^：

$$RPM(gene_A) = \frac{nMappedReads(gene_A)}{\sum{nMappedReads(gene_i)} \times 10^6}
\,.$$

RPK 消除了不同基因转录本长度不同的影响，使得同一样本的不同基因之间可比；而 RPM 消除了不同样本间测序深度不同的影响，使得不同样本的同一基因之间可比。RPKM 则相当于两者的结合，可以使得不同样本的不同基因之间可比：

$$RPKM(gene_A) = \frac{nMappedReads(gene_A)}{lenTotalExons(gene_A) \cdot \sum{nMappedReads(gene_i)} \times 10^9}
\,.$$

FPKM（Fragments Per Kilobase per Million mapped reads）与 RPKM 的唯一区别是将 $nMappedReads$ 换成了 $nMappedFragments$（也就是将每个基因的 read1 和 read2 两个 reads 的数量合并为一个 fragment 的数量）：

$$FPKM(gene_A) = \frac{nMappedFragments(gene_A)}{lenTotalExons(gene_A) \cdot \sum nMappedFragments(gene_i) \times 10^9}
\,.$$

> RNA-seq 可分为单端测序（Single-end sequencing）和双端测序（Paired-end sequencing）。对于 geneA 而言，单端测序表示仅沿着 Read1 方向（正向）开始测序，最后回帖到参考基因组上的只有 1 条 reads，由此统计的值称为 reads count。双端测序表示先沿着 Read1 方向测序，再从 Read2 方向开始测，最后回帖到参考基因组上有 2 个 reads，这 2 条 reads 在参考基因组上可以确定 1 个 fragments。即双端测序获得的 1 条 fragments 对应单端测序获得的 2 条 reads。

> FPKM (Fragments per kilo base per million mapped reads) is analogous to RPKM and used especially in paired-end RNA-seq experiments. In paired-end RNA-seq experiments, two (left and right) reads are sequenced from same DNA fragment. When we map paired-end data, both reads or only one read with high quality from a fragment can map to reference sequence. To avoid confusion or multiple counting, the fragments to which both or single read mapped is counted and represented for FPKM calculation.[^1]

> FPKM stands for fragments per kilobase of exon per million mapped fragments. It is analogous to RPKM and is used specifically in paired-end RNA-seq experiments.[^2]

由于 RPKM 测量的不准确性，TPM（Transcripts Per Million）被提出来了（Wagner 等，2012）[^1]：

$$TMP = \frac{RPK(gene_A)}{\sum RPK(gene_i)} \times 10^6
\,.$$

> TPM was introduced in an attempt to facilitate comparisons across samples. TPM stands for transcript per million, and the sum of all TPM values is the same in all samples, such that a TPM value represents a relative expression level that, in principle, should be comparable between samples.[^2]

可以理解为 TPM 以另一种不同与 RPKM 的方式对 RPK 进行了不同样本之间的归一化，使得原来只能在一个样本内比较的 RPK 消除了测序深度的影响而能在组间比较。

[^1]: Blog:Gene expression units explained: RPM, RPKM, FPKM and TPM. https://www.biostars.org/p/273537/
[^2]: Zhao, Y., Li, MC., Konaté, M.M. et al. TPM, FPKM, or Normalized Counts? A Comparative Study of Quantification Measures for the Analysis of RNA-seq Data from the NCI Patient-Derived Models Repository. J Transl Med 19, 269 (2021). https://doi.org/10.1186/s12967-021-02936-w
