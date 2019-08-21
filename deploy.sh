#! /bin/bash

change_source() {
    if [ ! -f /etc/apt/sources.list.ori ]; then
        mv /etc/apt/sources.list /etc/apt/sources.list.ori
        cat <<EOF > /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main non-free contrib
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main non-free contrib
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main non-free contrib
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main non-free contrib
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-updates main non-free contrib
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch-backports main non-free contrib
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security/ stretch/updates main non-free contrib
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security/ stretch/updates main non-free contrib
EOF
    fi
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
    zsh
    sqlite
    )
    apt update
    for pkg in ${packages[@]};do
        apt install -y $pkg
    done
}

install_oh_my_zsh() {
    bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s /bin/zsh
}

install_vim_rc() {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone https://github.com/leenzhu/vim.d.git ~/.vim.d
    ln -s ~/.vim.d/vimrc ~/.vimrc
    vim +PlugInstall +qall
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

#change_source
install_packages
install_oh_my_zsh
install_vim_rc
install_tmux_rc
enable_bbr
