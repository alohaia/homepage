---
title: "双拼方案"
date: 2023-08-26T14:56:26+08:00
lastmod: 2026-04-14T16:27:06+08:00
comments: true
---

{{< figure src="双拼方案.jpg" title="双拼方案" >}}

<!--more-->

关键配置（基于[雾凇拼音](https://github.com/iDvel/rime-ice)）：

```yaml
translator:
  dictionary: rime_ice          # 挂载词库 rime_ice.dict.yaml
  enable_word_completion: true  # 大于 4 音节的词条自动补全，librime > 1.11.2
  prism: double_pinyin_fire     # 多方案共用一个词库时，为避免冲突，需要用 prism 指定一个名字。
  spelling_hints: 8             # corrector.lua ：为了让错音错字提示的 Lua 同时适配全拼双拼，将拼音显示在 comment 中
  always_show_comments: true    # corrector.lua ：Rime 默认在 preedit 等于 comment 时取消显示 comment，这里强制一直显示，供 corrector.lua 做判断用。
  initial_quality: 1.2          # 拼音的权重应该比英文大
  comment_format:               # 标记拼音注释，供 corrector.lua 做判断用
    - xform/^/［/
    - xform/$/］/
  preedit_format:               # preedit_format 影响到输入框的显示和“Shift+回车”上屏的字符
    # 可能出现在元音里的辅音
    - xform/([dtnlbpmjqx])n/$1ie/
    - xform/([bpmnljqxy])g/$1in/
    - xform/([dtnlgkhvuirzcs])o/$1uo/
    # 安全
    - xform/(\w)q/$1ang/
    - xform/(\w)x/$1eng/
    - xform/([dtnlgkhjqxyvuirzcs])b/$1uan/
    - xform/(\w)d/$1ing/
    - xform/([jqx])c/$1iong/
    - xform/(\w)c/$1ong/
    - xform/([jqxnl])h/$1iang/
    - xform/(\w)h/$1uang/
    - xform/(\w)l/$1en/
    - xform/(\w)z/$1an/
    - xform/(\w)k/$1ian/
    - xform/(\w)w/$1ou/
    - xform/([bpmdtnljqx])r/$1iao/
    - xform/(\w)t/$1un/
    - xform/([gkhvuirzcs])y/$1uai/
    - xform/(\w)p/$1ai/
    - xform/(\w)s/$1ao/
    - xform/(\w)m/$1iu/
    - xform/([gkhvuirzcs])v/$1ua/
    - xform/([qdjkx])v/$1ia/
    - xform/(l)v/$1ü(ia)/
    - xform/(\w)v/$1ü/
    - xform/([dtgkhvuirzcs])f/$1ui/
    - xform/([jqxy])f/$1ue/
    - xform/(\w)f/$1üe/
    - xform/(\w)j/$1ei/
    # zh ch sh
    - "xform/(^|[ '])u/$1zh/"
    - "xform/(^|[ '])i/$1ch/"
    - "xform/(^|[ '])v/$1sh/"
    # a o e 显示调整
    - xform/([aoe])\1(\w)/$1$2/
    # - xform/ü/v/  # ü 显示为 v
```

```yaml
# 拼写设定
speller:
  # 如果不想让什么标点直接上屏，可以加在 alphabet，或者编辑标点符号为两个及以上的映射
  alphabet: zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA`
  # initials 定义仅作为始码的按键，排除 ` 让单个的 ` 可以直接上屏
  initials: zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA
  delimiter: " '"  # 第一位<空格>是拼音之间的分隔符；第二位<'>表示可以手动输入单引号来分割拼音。
  algebra:
    - erase/^xx$/
    # - derive/^([jqxy])u$/$1v/ 不允许 jqxy + ü
    - derive/^([aoe])([ioun])$/$1$1$2/
    - xform/^([aoe])(ng)?$/$1$1$2/
    - xform/iu$/Ⓜ/
    - xform/[iu]a$/Ⓥ/
    - xform/[uv]an$/Ⓑ/
    - xform/[uv]e$/Ⓕ/
    - xform/uai$/Ⓨ/
    - xform/ing$/Ⓓ/
    - xform/^sh/Ⓥ/
    - xform/^ch/Ⓘ/
    - xform/^zh/Ⓤ/
    - xform/uo$/Ⓞ/
    - xform/[uv]n$/Ⓣ/
    - xform/(.)i?ong$/$1Ⓒ/
    - xform/[iu]ang$/Ⓗ/
    - xform/(.)en$/$1Ⓛ/
    - xform/(.)eng$/$1Ⓧ/
    - xform/(.)ang$/$1Ⓠ/
    - xform/ian$/Ⓚ/
    - xform/(.)an$/$1Ⓩ/
    - xform/iao$/Ⓡ/
    - xform/(.)ao$/$1Ⓢ/
    - xform/(.)ai$/$1Ⓟ/
    - xform/(.)ei$/$1Ⓙ/
    - xform/ie$/Ⓝ/
    - xform/ui$/Ⓕ/
    - xform/(.)ou$/$1Ⓦ/
    - xform/in$/Ⓖ/
    - xlit/ⓆⓌⓇⓉⓎⓊⒾⓄⓅⓈⒹⒻⒼⒽⓂⒿⒸⓀⓁⓏⓍⓋⒷⓃ/qwrtyuiopsdfghmjcklzxvbn/
    # - abbrev/^(.).+$/$1/  # 首字母简拼，开启后会导致 3 个字母时 kj'x 变成 k'jx 的问题
```

