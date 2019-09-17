#! /bin/bash

mkdirs() {
    mkdir -p /box
    mkdir -p /box/app
    mkdir -p /box/conf
    mkdir -p /box/data
    mkdir -p /box/www
}

install_packages() {
    packages=(
    lrzsz
    git
    curl
    vim
    tmux
    htop
    tree
    nginx
    sqlite
    )
    apt update
    for pkg in ${packages[@]};do
        apt install -y $pkg
    done
}

install_tmux_rc() {
    # git clone tmuxrc
    git clone https://github.com/leenzhu/tmux.d.git ~/.tmux.d
    ln -s ~/.tmux.d/tmux.conf ~/.tmux.conf

    echo run-shell ~/.tmux.d/better-mouse/scroll_copy_mode.tmux >> ~/.tmux.conf
}

enable_bbr() {
    echo 'net.core.default_qdisc=fq' | tee -a /etc/sysctl.conf
    echo 'net.ipv4.tcp_congestion_control=bbr' |  tee -a /etc/sysctl.conf
    sysctl -p
}

#######MAIN##########

mkdirs
install_packages
enable_bbr

