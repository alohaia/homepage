---
title: "Tmux 工作流"
date: 2026-10-28T10:16:30+08:00
lastmod: 2026-10-28T18:08:05+08:00
comments: true
tags:
    - Linux
---

<!--more-->

打开一个 Tmux session 之后，Tmux 的所有窗口都会继承当前的环境，包括工作目录、Conda 环境以及OpenFOAM
环境。因此推荐为每个项目打开一个终端（或者终端的 Tab），然后用 Tmux 来处理这个终端可能需要的各种
操作，比如一个窗口用来编辑，另一个窗口用来运行或调试，另一个用来管理版本控制……

```tmux
# git clone --recursive https://github.com/alexwforsythe/tmux-which-key $HOME/.tmux/plugins/
run-shell ~/.tmux/plugins/plugin.sh.tmux

unbind C-b
set -g prefix M-a

# unbind :
bind-key ';' command-prompt

# go to pane
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key -r '[' select-pane -t :.-
bind-key -r ']' select-pane -t :.+

# resize pane
bind -r Left  resize-pane -L 5
bind -r Down  resize-pane -D 5
bind -r Up    resize-pane -U 5
bind -r Right resize-pane -R 5

# move pane
bind-key '{' swap-pane -U
bind-key '}' swap-pane -D

# copy-mode, vim key bindings, <Enter> to copy
set -g set-clipboard on
bind-key v copy-mode
```

> [!TIP]
> Ctrl + 鼠标左键拖动可以创建一个浮窗。
