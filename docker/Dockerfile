# 使用官方的Arch Linux基础镜像
FROM archlinux/archlinux:base

# 安装一些必要的软件包
RUN pacman -Syu --noconfirm  && \
    pacman --needed --noconfirm -S git-core base base-devel man vim colordiff tree wget unzip unrar lsof bc dosfstools rsync xz && \
    pacman --needed --noconfirm -S pacman && \
    pacman-db-upgrade && \
    pacman-key --init && \
    pacman -Syu --noconfirm
    
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
    chown $USERNAME:$USERNAME /home/$USERNAME

# 启动shell
CMD ["/bin/bash"]
