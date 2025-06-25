#!/bin/bash
CLBlack="\e[0;30m"
CLRed="\e[0;31m"
CLGreen="\e[0;32m"
CLYellow="\e[0;33m"
CLBlue="\e[0;34m"
CLPurple="\e[0;35m"
CLCyan="\e[0;36m"
CLWhite="\e[0;37m"

BGBlack="\e[40m"
BGRed="\e[41m"
BGGreen="\e[42m"
BGYellow="\e[43m"
BGBlue="\e[44m"
BGPurple="\e[45m"
BGCyan="\e[46m"
BGWhite="\e[47m"

RED='\033[0;31m'
NC='\e[0m'
Blue="\033[0;34m"
green='\033[0;32m'
purple="\033[1;95m"
Bold='\e[1m'
REDBG='\e[41m'
WHITE='\e[97m'

GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

tyblue='\e[1;36m'
NC='\e[0m'
b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";c="\033[35;1m";u="\033[36;1m"
k="\033[33;1m";n="\033[00m"

PROJECT_ENC_DIR="$HOME/enc"
PROJECT_SUBF_DIR="$HOME/subf"
PROJECT_SSC_DIR="$HOME/ssc"
PROJECT_UPX_DIR="$HOME/upx"

#git clone https://github.com/Rem01Gaming/ssc
REPO_ENC="https://github.com/triadzyu/enc.git"
REPO_SUBF="https://github.com/triadzyu/subf.git"
REPO_UPX="https://github.com/upx/upx.git"
REPO_SSC="https://github.com/liberize/ssc.git"

if [ ! -d "$PROJECT_SUBF_DIR" ]; then
    git clone "$REPO_SUBF" "$PROJECT_SUBF_DIR"
    cd "$PROJECT_SUBF_DIR"
    bash build
    cd
elif [ ! -d "$PROJECT_ENC_DIR" ]; then
    git clone "$REPO_ENC" "$PROJECT_ENC_DIR"
elif [ ! -d "$PROJECT_SSC_DIR" ]; then
    git clone "$REPO_SSC" "$PROJECT_SSC_DIR"
    apt install binutils
    apt install libarchive-dev
    apt install acl-dev
    apt install libz-dev
    apt install git
    apt install perl -y
elif [ ! -d "$PROJECT_UPX_DIR" ]; then
    git clone "$REPO_UPX" "$PROJECT_UPX_DIR"
    cd "$PROJECT_UPX_DIR"
    git submodule update --init
    nohup make > make.log 2>&1 &
    #make
    echo "print cat make.log"
    cat make.log
    cd
    cd /root/upx/build/release
    #make
    nohup make > make2.log 2>&1 &
    echo "print cat make2.log"
    cat make2.log
    sleep 11
    
    chmod 777 upx
    cp -f upx /usr/bin
    chmod +x /root/upx/build/release/upx
    cp -f /root/upx/build/release/upx /usr/bin
    cd
fi

contoh(){
PROJECT_ENC_DIR="$HOME/enc"
PROJECT_SUBF_DIR="$HOME/subf"
PROJECT_SSC_DIR="$HOME/ssc"
PROJECT_UPX_DIR="$HOME/upx"
    output_SSC="$HOME/enc/output_ssc"
    mkdir -p ${output_SSC}
    cd ${PROJECT_SSC_DIR}
    ./ssc -u -s -r -v "${output_SSC}/outfile.usr" "infile.sh"
    ./ssc -u -s -r -v xfile xfile.sh
    ./ssc -u -s -v tes.us tes.sh
    
    output_UPX="$HOME/enc/output_upx"
    mkdir -p ${output_UPX}
    cd ${PROJECT_UPX_DIR}
    upx -9 -vfk -o outfileupx infileshc
    upx -d outfileupx
    upx -9 --lzma -vfk -o upx_scan upx_scan.sh
    upx -9 --brute -vfk -o upx_scan upx_scan.sh
    upx -9 --ultra-brute -vfk -o upx_scan upx_scan.sh
}
