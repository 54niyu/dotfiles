#!/bin/bash

# ubuntu environment init bash

if [ ! -f "/etc/apt/sources.list.bak" ]; then 
echo 'back up sources.list'
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo 'replace sources'
sudo cat <<"EOF" > /etc/apt/sources.list 

deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

EOF

# apt update
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update -y
fi

# install bash
sudo apt install git -y
sudo apt install curl -y

# zsh
sudo apt install zsh -y
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi 

# tmux neovim  
sudo apt install tmux -y
sudo apt install neovim -y

# vim 
if [ ! -d "${HOME}/.vim" ]; then
    echo "init vim"
    git clone https://github.com/54niyu/dotfiles.git ~/.vim 
    ln -s ~/.vim/vimrc ~/.vimrc 
    ln -s ~/.vim/.tmux.conf ~/.tmux.conf 
fi

if [ ! -d "${HOME}/.config/nvim" ]; then
    echo "init nvim"
    mkdir ~/.config/nvim -p
    touch ~/.config/nvim/init.vim

cat <<"EOF" > .config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
EOF

fi

# Using Ubuntu
sudo apt install nodejs -y
sudo apt install yarn -y

# go
if [ ! -d "/usr/local/go" ]; then
  curl https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz -o /tmp/golang.tar.gz
  sudo tar -C /usr/local -xzf /tmp/golang.tar.gz
fi

if [ ! -d "${HOME}/workspace/Golang" ]; then
    echo 'init golang'
    mkdir -p  "${HOME}/workspace/Golang"
    echo 'export PATH=$PATH:/usr/local/go/bin'
    echo 'export GOPATH=~/workspace/Golang' >> ~/.zshrc
    echo 'export PATH=$PATH:~/workspace/Golang/bin' >> ~/.zshrc

    echo 'init gopls'
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=~/workspace/Golang
    export PATH=$PATH:~/workspace/Golang/bin
    export GO111MODULE=on
    export GOPROXY=https://goproxy.io

    go get -u golang.org/x/tools/cmd/gopls

cat <<"EOF" > "${HOME}/.config/nvim/coc-settings.json"
{
  "languageserver": {
    "golang": {
      "command": "gopls",
      "rootPatterns": ["go.mod", ".vim/", ".git/", ".hg/"],
      "filetypes": ["go"]
      }
  }
}
EOF
fi


source ~/.zshrc
