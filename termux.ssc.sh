#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
m="\033[31;1m"
p="\033[39;1m"
REPO1_SSC="https://github.com/Rem01Gaming/ssc.git"
REPO2_SSC="https://github.com/liberize/ssc.git"
if [ ! -d "$HOME/ssc" ]; then
    git clone https://github.com/liberize/ssc.git
    apt install binutils -y
    apt install libarchive-dev -y
    apt install acl-dev -y
    apt install libz-dev -y
    apt install git
    apt install perl -y
    chmod +x $HOME/ssc/ssc
    cp -vf $HOME/ssc/ssc /usr/bin
    if ls /usr/bin | grep -q "ssc"; then
        printf "${p}[${m}!${p}]${CYAN} ssc Shell Script Compiler ${GREEN}terinstall ✓${NC}\n"
    fi
else
    if [ ! -f "/usr/bin/ssc" ]; then
        chmod +x $HOME/ssc/ssc
        cp -vf $HOME/ssc/ssc /usr/bin
    fi
    printf "${p}[${m}!${p}]${CYAN} ssc Shell Script Compiler ${GREEN}terinstall ✓${NC}\n"
fi
if [[ ! -f $HOME/ssc/.pro ]]; then
    rm -rf $HOME/ssc
    cd
    git clone https://github.com/triadzyu/ssc.git
fi
