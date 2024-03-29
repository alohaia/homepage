---
title: "常用快捷键和基本操作"
date: 2023-01-11T17:27:26+08:00
lastmod: 2023-05-21T18:02:21+08:00
comments: true
math: false
tags:
    - Blender
---

## 常用快捷键及相关操作

### 小键盘

- <kbd>0</kbd>：摄像机视角
- <kbd>5</kbd>：正交视图
- 切换三视图，注意 7、1、3 在小键盘的布局与四视图中对应视图的布局相同
    - <kbd>7</kbd>：顶视图（Z）
    - <kbd>1</kbd>：前视图（-Y）
    - <kbd>3</kbd>：右视图（X）
- 切换与对应视图相反的视图，加上 <kbd>Ctrl</kbd> 即可，如仰视图（-Z）快捷键为 <kbd>Ctrl</kbd>+<kbd>7</kbd>
- <kbd>9</kbd>：视角翻转，即前两项之间相互切换；或在透视/正交视角中翻转 X 和 Y 轴
- <kbd>.</kbd>：聚焦
- <kbd>Ctrl</kbd>+<kbd>.</kbd>：四视图同步聚焦
- <kbd>HOME</kbd>：显示整个场景
- <kbd>+</kbd>/<kbd>-</kbd>：放大/缩小场景或面板，展开/折叠

### 旋转缩放移动

- <kbd>R</kbd><kbd>S</kbd><kbd>G</kbd>：旋转/缩放/移动
    - 开启旋转后，<kbd>R</kbd> 切换自由旋转和在当前视平面旋转
- 通用二级按键
    - <kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：锁定在轴上旋转/缩放/移动
        - 锁定后可直接输入数字选择移动距离/缩放倍数/旋转角度
        - 再按下 <kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：切换全局坐标系和局部坐标系
    - <kbd>Shift</kbd>+<kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：锁定在与轴垂直的平面上旋转/缩放/移动（对旋转无区别）
    - <kbd>MiddleClick</kbd>：选择并锁定在轴上旋转/缩放/移动
    - <kbd>Shift</kbd>：精确模式
    - <kbd>RightClick</kbd>：取消
- <kbd>Alt</kbd>+<kbd>R</kbd><kbd>S</kbd><kbd>G</kbd>：归零旋转/缩放/移动

### 编辑模式

- <kbd>Tab</kbd>：进入编辑模式
- <kbd>1</kbd>/<kbd>2</kbd>/<kbd>3</kbd>：点/线/面模式
- <kbd>Shift</kbd>+<kbd>1</kbd>/<kbd>2</kbd>/<kbd>3</kbd>：多选

### 其他按键

- <kbd>/</kbd>：聚焦且进入局部视图（隐藏其他物体）
- <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>0</kbd>：移动摄像机到当前视角
- <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Q</kbd>：进入四视图
- <kbd>N</kbd>：开关右侧的工具面板
- <kbd>T</kbd>：开关左侧的工具面板
- <kbd>W</kbd>：切换选择工具
- <kbd>A</kbd>，<kbd>A</kbd><kbd>A</kbd>：全选，取消全选
- <kbd>Ctrl</kbd>+<kbd>I</kbd>：反选
- <kbd>Shift</kbd>+<kbd>A</kbd>：添加物体
- <kbd>X</kbd>：删除物体
- <kbd>Shift</kbd>+<kbd>D</kbd>：非关联复制
- <kbd>O</kbd>：软选择
- <kbd>M</kbd>：合并顶点
- <kbd>Ctrl</kbd>+<kbd>J</kbd>：合并对象；【编辑模式】两点之间连线
- <kbd>L</kbd>：选择相邻元素
- <kbd>P</kbd>：分离对象
- <kbd>Shift</kbd>+<kbd>R</kbd>：重复操作
- <kbd>Shift</kbd>+<kbd>\~</kbd>：切换第一人称观察模式
    - <kbd>Space</kbd>：快速前进到准星指向的位置

## 基本操作

### 一般操作

- 调整摄像机/保持摄像机视角：视图 → 视图锁定 → 勾选“锁定摄像机到视图方位”
- 摄像机视框大小/输出分辨率：左下角工具栏 → 输出属性（照片打印机图标） → 格式 → 分辨率 X/Y
- 选中物体时自动显示移动/旋转/缩放工具：视图 Gizmo（主视图框右上角第二个图标）→ 下拉 → 移动/旋转/缩放
- 显示统计信息
    - 在状态栏中显示场景统计数据（如选中了多少个点）：编辑 → 偏好设置 → 编辑器 → 状态栏 → 场景统计数据
    - 在视图叠加层中显示统计信息：主视图右上角 → 叠加（一个空心圆与一个实心圆部分重叠的图标） → 辅助（引导） → 统计信息
- 显示法向/面朝向：主视图右上角 → 叠加 → 法向/（集合数据 → 面朝向）

### 坐标系与轴心点

- 显示物体自身轴向（局部坐标系）：左下角工具栏 → 物体属性 → 视图显示 → 轴向
- 变换坐标系：主视图框正中间上上第一个图标
    - 固定某一物体局部坐标系为全局坐标系：选中某一物体 → 点击“全局”后面的“+”，创建新坐标系
- 万向轴：物体属性 → 变换 → 模式：“ABC 欧拉”表示绕 B 轴旋转，C 轴为转向轴
- 移动游标：
    - 选择左侧工具栏中的“游标”工具 → <kbd>LiftClick</kbd> 拖拽
    - <kbd>Shift</kbd>+<kbd>RightClick</kbd> 拖拽
    - <kbd>Shift</kbd>+<kbd>S</kbd>：快速移动游标
- 原点：
    - 移动原点：
        - 主视图右上角“选项” → 变换 → 仅影响原点，勾选后即可移动原点
        - <kbd>Ctrl</kbd>+<kbd>O</kbd>：开关“仅影响原点”
    - 恢复原点位置：选择物体/原点 → 右键 → 设置原点 → “原点 -\> 几何中心”或“几何中心 -\> 原点”
- <kbd>,</kbd>：“变换坐标系”轮盘
- <kbd>.</kbd>：“变换轴心点”轮盘

### 吸附

- 切换吸附模式：主视图框正中间上上第一个图标
    - 选择吸附对象：“吸附至”
    - 选择被吸附对象：“吸附基准点”（“吸附至”为“增量”时不可用）
        - “中心”即“变换中心点”中所选
- “背面剔除”：不对被物体自身遮挡的对象生效
- “投影到自身”（编辑模式）：可吸附到物体自身的其他点/线/面
- “项目独立元素”：对选中各元素独立生效
- <kbd>Shift</kbd>+<kbd>Tab</kbd>：开关吸附
- <kbd>Ctrl</kbd>+...：临时启用吸附。如在移动（<kbd>G</kbd>）时，移动鼠标的同时按住 <kbd>Ctrl</kbd>

### 隐藏和禁用

- 显示选项：右上角场景物体列表 → 右上角漏斗图标 → “限制开关”
- 隐藏物体：
    - <kbd>H</kbd>
    - 右上角场景物体列表中，点击对应对象的眼睛图标
- <kbd>Alt</kbd>+<kbd>H</kbd>：显示所有隐藏物体
- 禁用物体：
    - 在视图中禁用：显示器图标
    - 在渲染中禁用：照像机图标

### 父子级

- <kbd>Ctrl</kbd>+<kbd>P</kbd>：合并父子级
- <kbd>Alt</kbd>+<kbd>P</kbd>：清空父子级
- 也可以在右上角场景物体列表中直接拖拽进行操作

### 镜像

根据原点将当前对象转换为其关于 X/Y/Z 轴的镜像。

- <kbd>Ctrl</kbd>+<kbd>M</kbd>：进入镜像交互模式
    - <kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：选择镜像轴
    - <kbd>MiddleClick</kbd>：使用鼠标选择镜像轴

### 动画

- <kbd>I</kbd>：【动画】打帧
- <kbd>Alt</kbd>+<kbd>O</kbd>：平滑关键帧

### 建模工具

#### 挤出

- 选择挤出工具后可在左上角设置沿法线/XZY 轴挤出
- <kbd>E</kbd>：挤出选取并移动
    - <kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：沿对应轴挤出
    - <kbd>Shift</kbd>+<kbd>X</kbd>/<kbd>Y</kbd>/<kbd>Ζ</kbd>：锁定对应轴
- <kbd>Alt</kbd>+<kbd>E</kbd>：选择并使用挤出方式
    - 重复挤出
    - 环绕
- <kbd>Ctrl</kbd>+<kbd>RightClick</kbd>：挤出到光标

{{% tab type="warning" summary="" details=true open=true %}}
按下 <kbd>E</kbd> 之后，按 <kbd>RightClick</kbd> 只会取消移动操作，而没有取消挤出选取操作。所以不应该用 <kbd>RightClick</kbd> 取消，而应在完成操作后再用 <kbd>Ctrl</kbd>+<kbd>Z</kbd> 取消操作。
{{% /tab %}}

#### 内插面

- <kbd>I</kbd>：内插面，横向改变新面的大小。内插面模式下左上角会消失提示，左下角有选项菜单。
    - <kbd>Ctrl</kbd>：纵向改变内插面位置
    - <kbd>O</kbd>：开关外插
    - <kbd>I</kbd>：开关分离（及“各面”选项）
    - <kbd>B</kbd>：开关边界边（需关闭分离）
    - “并排边”：

#### 倒角

- <kbd>Ctrl</kbd>+<kbd>B</kbd>：**边线倒角**
    - 移动鼠标：改变倒角宽度
    - 滚动滚轮/<kbd>S</kbd>：改变倒角分段数
    - <kbd>P</kbd>：控制形状/轮廓
    - 输入数值：控制宽度

{{% tab type="default" summary="倒角的宽度类型" details=false %}}

{{< figure src="宽度类型.png" width="250px" title="宽度类型" alt="宽度类型" class="float-right" id="fig_宽度类型" >}}

[官方文档](https://docs.blender.org/manual/zh-hans/3.4/modeling/modifiers/generate/bevel.html)这样解释倒角宽度类型：

宽度类型：声明如何使用*宽度*以决定倒角总量。

偏移量
: 原始边到倒角面的垂直距离。

宽度
: 坡口形成的两条新边的距离（如果有多个段，则坡口两侧的边）。

深度
: 该值是从原始边到倒角面的垂直距离。

百分比
: 新边线滑移距离相对邻边长度的百分比。

绝对
: 沿着与斜面边缘相邻的边缘的确切距离。当连接到斜面边缘的非斜面边缘与直角以外的角度相遇时，可以看到与*偏移*的差异。
{.grid}

{{< figure src="偏移量与绝对值.png" title="偏移量与绝对值" alt="偏移量与绝对值" id="fig_偏移量与绝对值"
    caption="*偏移量*与*绝对*之间的区别如图所示。图中为一个梯形体的顶视图，梯形体顶面为一个边长为 2 m 的正方形。右上角使用*偏移量*，左下角使用*绝对*，两者*宽度*均为 1 m。"
    class="left" img-width="200px"
>}}

{{% /tab %}}
