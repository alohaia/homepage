---
title: 2025-05-25 shell 脚本语法
date: 2025-05-25T10:55:25+08:00
lastmod: 2025-05-25T11:00:15+08:00
comments: true
math: false
---

<!--more-->

## 通过关联数组模拟字典

```bash
declare -A mydict

mydict[apple]="red"
mydict[banana]="yellow"
mydict[grape]="purple"

# ${!mydict[@]} 表示所有键
for key in "${!mydict[@]}"; do
  echo "$key: ${mydict[$key]}" # [] 中间可以引用其他变量
done

# ${mydict[@]} 表示所有值
for val in "${mydict[@]}"; do
  echo "$val"
done

# ${#mydict[@]} 表示键值对数量
echo "length: ${#mydict[@]}"
```

{{< tab style="success" summary="从列表动态构造字典" details=true >}}

```bash
declare -A user_id_map

users=("alice" "bob" "carol")
ids=(1001 1002 1003)

for i in "${!users[@]}"; do
  user_id_map[${users[$i]}]=${ids[$i]}
done
```

{{< /tab >}}

