#Debian 9

function change_source() {
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

function install_packages() {
    packages = (
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
    for pkg in pakcages do
        echo pkg
    done
}

function others() {
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # git clone vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone https://github.com/leenzhu/vim.d.git ~/.vim.d
    ln -s ~/.vim.d/vimrc ~/.vimrc

    # git clone tmuxrc
    git clone https://github.com/leenzhu/tmux.d.git ~/.tmux.d
    ln -s ~/.tmux.d/tmux.conf ~/.tmux.conf

    git clone https://github.com/nhdaly/tmux-better-mouse-mode ~/.tmux.d/better-mouse
    echo run-shell ~/.tmux.d/better-mouse/scroll_copy_mode.tmux >> ~/.tmux.conf

    #enable bbr
    echo 'net.core.default_qdisc=fq' | tee -a /etc/sysctl.conf
    echo 'net.ipv4.tcp_congestion_control=bbr' |  tee -a /etc/sysctl.conf
    sysctl -p
    # lsmod | grep bbr
}
