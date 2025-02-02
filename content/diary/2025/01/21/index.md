---
title: Cloudflare Tunnel
date: 2025-01-21T11:57:19+08:00
lastmod: 2025-01-24T14:13:57+08:00
comments: true
math: false
---

<!--more-->

## 内网穿透

### 使用 Cloudflare 的名称服务器

{{< tab style="info" summary="" details=false >}}
开始之前需要一个域名。
{{< /tab >}}

将域名添加到 Cloudflare，按流程调调选项，最后 Cloudflare 会提供两个名称服务器地址。打开域名提供商的管理页面，设置 DNS 服务器（如阿里云：域名控制台 → 域名列表 → xxx.xxx → 修改 DNS）。

### 安装和准备软件

需要 WARP client 和 cloudflared 两个软件包，可以直接在 Cloudflare 官网下载：进入 Zero Trust → Settings → Resources。Arch Linux 可以安装现成的软件包：

```bash
paru -S aur/cloudflare-warp-bin extra/cloudflared
```

启动 WARP 服务：

```bash
sudo systemctl enable --now warp-svc.service
```

### 创建一个 Tunnel

创建一个 Tunnel，使用 Cloudflare 提供的命令连接服务器到 Tunnel：

```bash
sudo cloudflared service install <your-token>
```

再进入设置页面：

{{< figure src="tunnel_configure.png" title="tunnel_configure" style="normal" >}}

切换到 Public Hostname 标签页 → add a public hostname →

- Public hostname：
    - Subdomain：任意
    - Domain：选择之前准备好的域名
    - Path：可选
- Service：根据用户自己的的服务选择即可

## SSH 连接

在 Cloudflare 为服务器上运行的 Tunnel 创建一个新的 Public hostname：Subdomain 任意，Type 选 SSH，URL 一般为 `localhost:22` 或 `127.0.0.1:22`。

在服务器安装并开启 SSH 服务。

```bash
paru -Sy openssh
sudo systemctl enable --now ssh.service
```

使用 `cloudflared login` 命令在服务器生成密钥（`~/.cloudflared/private.pem`），再复制到本地 `~/.ssh/xxx.pem`。配置本地 `~/.ssh/config`：

```txt
Host AnyNameYouLike
    User your_user_name
    HostName your_subdomain.domain.address
    IdentityFile ~/.ssh/xxx.pem
    ProxyCommand cloudflared access ssh --hostname %h
```

然后就可以通过 `ssh AnyNameYouLike` 来连接服务器，或者通过 `scp /path/to/source AnyNameYouLike:/path/to/target` 来将文件传输到服务器。
