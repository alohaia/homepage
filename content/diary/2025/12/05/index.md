---
title: 2025-11-11
date: 2025-12-05T13:54:14+08:00
comments: true
math: false
---

<!--more-->

- [Google Python Guide](https://google.github.io/styleguide/pyguide.html)
- [PEP 8 – Style Guide for Python Code](https://peps.python.org/pep-0008/)
    - [表达式中的空格](https://peps.python.org/pep-0008/#whitespace-in-expressions-and-statements)
- [PEP 257 – Docstring Conventions](https://peps.python.org/pep-0257/)

**复杂变量命名**：

    <prefix>_<desc>_<suffix>

- `<prefix>`：说明变量类型，如 `xy`（坐标），`area`（面积），`i`（索引），`nr`/`n`（长度，数量等）。加上 `x`，如 `xys` 表示数组。
- `<desc>`：变量描述
- `<suffix>`：说明衍生属性，如 `max`，`min`

```python
# https://google.github.io/styleguide/pyguide.html#34-indentation
                        # Yes
                        short_function(argument, argument, argument, argument, argument, argument,
                                       argument, argument, argument, argument, argument, argument,
                                       argument, argument, argument, argument, argument, argument,
                                       argument, argument, argument, argument)

                        # No!
                        long_long_long_long_long_long_long_long_function(long_long_long_long_argument,
                                                                         long_long_long_long_argument)

                        # Yes
                        long_long_long_long_long_long_long_long_function(
                            long_long_long_long_argument, long_long_long_long_argument,
                            long_long_long_long_argument,
                        )
```

```python
# Yes
if (current_density < target_density and
        closest_distance > min_distance):
    # not confused with codes following

# No!
if (current_density < target_density and
    closest_distance > min_distance):
    # not confused with codes following

```
