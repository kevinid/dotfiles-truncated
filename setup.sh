#!/bin/bash
# Configuring the environment

# Stop the script whenever there is an error
set -e

# Record working directory
W_DIR=$(pwd)

# Install required packages using apt-get
# 1. Configure apt repository
apt-get update \
    && apt-get install -y --no-install-recommends \
        software-properties-common \
    && add-apt-repository ppa:neovim-ppa/stable \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update
# 2. Install required packages
apt-get install -y --no-install-recommends \
    `# Required for python2-based plugins in neovim` \
    python-dev \
    python-pip \
    `# Required for python3-based plugins in neovim` \
    python3.7 \
    python3.7-dev \
    `# Neovim` \
    neovim \
    `# For python linting` \
    pylint \
    `# Installing zsh` \
    zsh \
    `# For installing pure theme for zsh` \
    npm \
    `# Cloning repositories` \
    git \
    `# Used for downloading contents` \
    curl
# Clean cache
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Installing pip for python3.7
curl https://bootstrap.pypa.io/get-pip.py | python3.7
# Install neovim module for python3
python3.7 -m pip --no-cache-dir install \
    -i https://pypi.tuna.tsinghua.edu.cn/simple neovim

# Configure zsh
# 1. Change the default shell to zsh
chsh -s /bin/zsh

# 2. Install the plugin manager 'oh-my-zsh'
ZSH=~/.oh-my-zsh \
    && git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ${ZSH}
# 3. Installing required plugins
ZSH_CUSTOM=~/.oh-my-zsh/custom
# mkdir ${ZSH_CUSTOM}/plugins
cd ${ZSH_CUSTOM}/plugins
# 3.1 Install highlighter
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# 3.2 Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    && cd zsh-autosuggestions \
    && git checkout develop

# Go back to working directory
cd $W_DIR

# Install NeoBundle
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh\
    > installer.sh
sh ./installer.sh ~/.cache/dein

# Create soft links
mkdir -p ~/.config/nvim
backup () {
    if [ -e $1 ]
        then
            mv $1 $1.bk
    fi
}
backup ~/.config/nvim/init.vim
ln -s $PWD/init.vim ~/.config/nvim/init.vim
if ! [ -d ~/.ssh ]
    then
        mkdir ~/.ssh
fi
backup ~/.ssh/config
ln -s $PWD/ssh-config ~/.ssh/config
backup ~/.gitconfig
ln -s $PWD/.gitconfig ~/.gitconfig
backup ~/.zshrc
ln -s $PWD/.zshrc ~/.zshrc
backup ~/.tmux.conf
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.tmux-theme.conf ~/.tmux-theme.conf
chmod +x $PWD/tmux-env.sh
ln -s $PWD/tmux-env.sh ~/tmux-env.sh

# Install zsh theme 'pure'
npm install --global pure-prompt --allow-root --unsafe-perm=true
