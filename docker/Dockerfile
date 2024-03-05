# 使用官方的Arch Linux基础镜像
FROM archlinux/archlinux:base

# 安装一些必要的软件包
RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
RUN echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm  && \
    pacman --needed --noconfirm -S git base base-devel wget unzip unrar xz

# 清理缓存以减小镜像体积
RUN pacman -Scc --noconfirm

RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN git config --global http.sslverify false

ARG USERNAME

RUN \
    groupadd $USERNAME && \
    useradd \
    --create-home --home-dir /home/$USERNAME \
    --comment "Pikvm buildbot" \
    --gid $USERNAME --shell /bin/bash $USERNAME && \
    chown $USERNAME:$USERNAME /home/$USERNAME && \
    echo "$USERNAME:$USERNAME" | chpasswd

# 安装sudo包
RUN pacman -Syu --noconfirm sudo
# 添加用户到wheel组，这个组在Arch Linux中通常有sudo权限
RUN usermod -aG wheel $USERNAME
# 为了避免编辑/etc/sudoers文件，我们可以创建一个新的文件来设置权限
RUN echo "$USERNAME ALL=(ALL) ALL" | EDITOR="tee -a" visudo