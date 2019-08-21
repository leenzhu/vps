# install utils tools
apt-get install lrzsz
apt-get install git
apt-get install curl
apt-get install vim
apt-get install tmux
apt-get install htop
apt-get install zsh
apt-get install tree
apt-get install nginx

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#enable bbr
echo 'net.core.default_qdisc=fq' | tee -a /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' |  tee -a /etc/sysctl.conf
sysctl -p
# lsmod | grep bbr


