---
title: ZDock；NTFS 文件系统的权限
date: 2025-01-23T13:58:25+08:00
lastmod: 2025-01-24T21:02:58+08:00
comments: true
math: false
---

<!--more-->

## ZDock

> Command Line: ZDOCK
>
> Step 1: Download and decompress the tar file of ZDOCK 3.0.2 or ZDOCK 2.3.2 that is appropriate for your platform. Tar files can be found [here](https://zdock.wenglab.org/software/).
> Step 2: Copy the create_lig program to the directory with the zdock output file.
> Step 3: Run the script "create.pl" from this directory. "create.pl [zdock_output_filename]" will generate ALL predicted complexes in the zdock output file and name them "complex.X" where "X" is the prediction number. To create the top N prediction files, just truncate the zdock output file. This can be accomplished in unix by "head -N [zdock_output_filename] > [zdock_output_short]" where N is the number of predictions plus number of header lines in the output file (5 by default, 4 if 3.0.2f or 2.3.2f was selected for ZDOCK version). Then run create.pl with the new file as input.
>
> Command Line: M-ZDOCK
>
> Step 1: Download and decompress the tar file of M-ZDOCK that is appropriate for your platform. Tar files can be found [here](https://zdock.wenglab.org/software/).
> Step 2: Run the "create_multimer" program in the directory with your M-ZDOCK output file and input PDB file to generate ALL predictions from M-ZDOCK. To generate a subset of the top N predictions, make a dummy output file with the top N+3 lines, e.g. "head -13 mzdock.out > mzdock.dummy.out", then run create_multimer using mzdock.dummy.out, to get the top 10 predictions from file "mzdock.out". Alternatively the "create_multimer_num" program can be used to generate individual predictions from the command line.


https://zdock.wenglab.org/results/example_zdock_2B42/

https://www.java.com/en/download/help/enable_browser.html

## NTFS 文件系统的权限

https://askubuntu.com/questions/11840/how-do-i-use-chmod-on-an-ntfs-or-fat32-partition

递归地将目录权限修改为 755：

```bash
find . -type d -exec chmod 755 {} \;
```
