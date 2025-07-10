#!/bin/bash

# Warna (pakai yang sering dipakai aja)
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
tyblue='\e[1;36m'
NC='\e[0m'
b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";c="\033[35;1m";u="\033[36;1m"
k="\033[33;1m";n="\033[00m"


function instalupx() {

PROJECT_UPX_DIR="$HOME/upx"
REPO_UPX="https://github.com/upx/upx.git"
#if [ ! -d "$PROJECT_UPX_DIR" ]; then

making(){
    cd
    cd $HOME/upx
    nohup make -j1 > make.log 2>&1 &
    echo "print cat make.log"
    for i in $(seq 1 60); do
        sleep 0.5
        cat cat make.log
    done
    echo "selesai ✓✓"

    cd
    cd $HOME/upx/build/release
    nohup make -j1 > make2.log 2>&1 &
    echo "print cat make2.log"
    for i in $(seq 1 60); do
        sleep 0.5
        cat make2.log
    done
    echo "selesai ✓✓"
}

berikan_izin(){
        cd $HOME/upx/build/release
        chmod 777 upx
        cp -f upx /usr/bin
        chmod +x $HOME/upx/build/release/upx
        cp -f $HOME/upx/build/release/upx /usr/bin
        chmod 777 /usr/bin/upx
        cd
}

if [ ! -d "$HOME/upx" ]; then
    git clone https://github.com/upx/upx.git
    cd
    cd upx
    git submodule update --init
    nohup make -j1 > make.log 2>&1 &
    sleep 7
    cat make.log
    sleep 5
    cat make.log
    sleep 3
    cat make.log
    sleep 2
    cat make.log
    sleep 1
    cat make.log
    
    cd build/release
    nohup make -j1 > make2.log 2>&1 &
    
    sleep 7
    cat make2.log
    sleep 5
    cat make2.log
    sleep 3
    cat make2.log
    sleep 2
    cat make2.log
    sleep 1
    cat make2.log
    
    # manual yaa
    if [ ! -f "$HOME/upx/build/release/upx" ]; then
        sudo apt update
        sudo apt install --reinstall coreutils cmake make build-essential
        sudo apt upgrade
        making
        cd $HOME/upx/build/release
        chmod 777 upx
        cp -f upx /usr/bin
        chmod +x $HOME/upx/build/release/upx
        cp -f $HOME/upx/build/release/upx /usr/bin
        chmod 777 /usr/bin/upx
        cd
    else
        cd $HOME/upx/build/release
        chmod 777 upx
        cp -f upx /usr/bin
        chmod +x $HOME/upx/build/release/upx
        cp -f $HOME/upx/build/release/upx /usr/bin
        chmod 777 /usr/bin/upx
        cd
    fi

else
    if [ ! -f "/usr/bin/upx" ]; then
      if [ -f "$HOME/upx/build/release/upx" ]; then
        berikan_izin
      else
        sudo apt update
        sudo apt install --reinstall coreutils cmake make build-essential
        sudo apt upgrade
        making
        berikan_izin
      fi
    else
        printf "${p}[${m}!${p}]${h} ${CYAN} Upx Ultimate Packer X binary ${GREEN}terinstall ✓\n"
    fi
fi



}

		if [ -z $(command -v upx) ];then
		printf "${p}[${m}!${p}]${m}upx belum di install!!\n"
		printf "${p}[${m}!${p}]${h}apt install upx\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n"
		instalupx
		else
		#printf "${p}[${m}!${p}]${h} ${CYAN} upx ${GREEN}terinstall ✓\n"
		instalupx
		fi
		
