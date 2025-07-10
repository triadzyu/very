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


function kakkoii(){
clear
figlet -f small -t "      Yaddy Kakkoii" | lolcat
echo -e "              TELEGRAM : t.me/Crystalllz | Crypter"
echo -e "              ⚡MAGELANG ⚡PHREAKER ⚡| versi beta"
echo ""
echo "*****************************************************"
echo "*            Not Open Source @Crystalllz            *"
echo "*****************************************************"
echo "*                 AUTO CREATE YAML                  *"
echo "*                      Author                       *"
echo "*                Mas Triadzz Ganteng                *"
echo "* Telegram: t.me/Crystalllz | Github: Yaddy Kakkoii *"
echo "*                       1337                        *"
echo "*****************************************************"
echo ""
}

show_loading() {
  echo -ne "${ORANGE}Memuat..."
  local i=0
  while [ $i -lt 5 ]; do
    echo -n "."
    sleep 0.1
    ((i++))
  done
  echo -e "${NC}"
clear
}
display_header() {
show_loading
kakkoii
  echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          │ MAGELANG ⚡ PHREAKER │                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}╠══════════════════════════════════════════════════╣${NC}"
  echo -e "${CYAN}║${NC} ${CYAN}📅 Tanggal: $(date '+%A, %d %B %Y')${NC}                ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC} ${BLUE}⏰ Waktu: $(date '+%H:%M:%S')${NC}                               ${CYAN}║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
}

paketvps=(
    "wget"
    "curl"
    "nmap"
    "zip"
    "nmap"
    "jq"
    "bc"
    "screen"
    "vim"
    "httping"
    "gcc"
    "sshpass"
    "perl"
    "git"
    "python"
    "python3"
    "shc"
    "gawk"
    "which"
    "nano"
)

check_vps() {
    local paketvps="$1"
    if ls /usr/bin | grep -q "^$paketvps"; then
        #echo "$paketvps sudah terpasang.✓"
        printf "${p}[${m}!${p}]${CYAN} $paketvps ${GREEN}terinstall ✓${NC}\n"
    else
        echo "$paketvps belum terpasang. Menginstal $package..."
        apt install ${paketvps} -y
        if [ $? -eq 0 ]; then
            echo "$paketvps berhasil diinstal."
        else
            echo "Gagal menginstal $paketvps."
        fi
    fi
}

instalknockpy(){
PROJECT_KNOCK_DIR="$HOME/knock"
REPO_KNOCK="https://github.com/guelfoweb/knock.git"
if [ ! -d "$PROJECT_KNOCK_DIR" ]; then
    git clone "$REPO_KNOCK"
    cd "$PROJECT_KNOCK_DIR"
    pip install .
    cd
    if ! command -v knockpy &> /dev/null; then
        apt install python3.12-venv
        apt install python3-venv
        python3 -m venv $HOME/knock
        source $HOME/knock/bin/activate
        cd $HOME/knock
        pip install .
        chmod +x $HOME/knock/bin/knockpy
        cp -f $HOME/knock/bin/knockpy /usr/bin
        if ls /usr/bin | grep -q "knockpy"; then
            printf "${p}[${m}!${p}]${CYAN} knockpy ${GREEN}terinstall ✓${NC}\n"
        fi
    fi
else
    if [ -f "$HOME/knock/bin/activate" ]; then
        source $HOME/knock/bin/activate
    fi
    printf "${p}[${m}!${p}]${CYAN}knockpy ${GREEN}terinstall ✓${NC}\n"
fi
}

instalssc(){
#https://github.com/Rem01Gaming/ssc.git
#REPO_SSC="https://github.com/liberize/ssc.git"
if [ ! -d "$HOME/ssc" ]; then
    git clone https://github.com/liberize/ssc.git
    apt install binutils -y
    apt install libarchive-dev -y
    apt install acl-dev -y
    apt install libz-dev -y
    apt install git
    apt install perl -y
    chmod +x $HOME/ssc/ssc
    cp -f $HOME/ssc/ssc /usr/bin
    if ls /usr/bin | grep -q "ssc"; then
        printf "${p}[${m}!${p}]${CYAN} ssc Shell Script Compiler ${GREEN}terinstall ✓${NC}\n"
    fi
else
    if [ ! -f "/usr/bin/ssc" ]; then
        chmod +x $HOME/ssc/ssc
        cp -f $HOME/ssc/ssc /usr/bin
    fi
    printf "${p}[${m}!${p}]${CYAN} ssc Shell Script Compiler ${GREEN}terinstall ✓${NC}\n"
fi
}

instalsubfinder(){
    if ! command -v go &> /dev/null; then
        apt install golang -y
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.bashrc
        echo 'export GOPATH=/usr/local' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
        source ~/.bashrc
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "\n${p}[${m}!${p}]${CYAN} golang terinstall ✓\n"
    fi
    if ! grep -q 'go/bin' "$HOME/.bashrc"; then
        apt install golang -y
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/usr/local/go/bin"' >> "$HOME/.bashrc"
        echo 'export GOPATH=/usr/local' >> "$HOME/.bashrc"
        echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        source "$HOME/.bashrc"
    fi
    if ! command -v subfinder &> /dev/null; then
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "${p}[${m}!${p}]${CYAN} subfinder terinstall ✓\n"
    fi
    if ! command -v bugscanx-go &> /dev/null; then
        #go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        /usr/local/go/bin/go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        cp -f /usr/local/bin/bugscanx-go /usr/bin/
        chmod +x /usr/bin/bugscanx-go
    else
        printf "${p}[${m}!${p}]${CYAN} bugscanx-go terinstall ✓\n"
    fi

    if ! command -v bugscanner-go &> /dev/null; then
        mkdir -p $HOME/go
        /usr/local/go/bin/go install -v github.com/Toton-dhibar/bugscanner-go@latest
        cp -f /usr/local/bin/bugscanner-go /usr/bin/
        chmod +x /usr/bin/bugscanner-go
    else
        printf "${p}[${m}!${p}]${CYAN} bugscanner-go terinstall ✓\n"
    fi
}

instal_nodejs_vps(){
    apt update && apt upgrade -y
    apt install binutils -y
    apt install ncurses-utils -y
    apt install npm nodejs -y
    ln -s /usr/bin/nodejs /usr/bin/node
    npm install -g bash-obfuscate
    node -v
    npm -v
}

download_packages_vps() {
# ============================================================
if ! command -v which &> /dev/null; then apt install which -y; fi
if ! which gawk &> /dev/null; then apt install gawk; fi

type -P nslookup 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'nslookup' not found, installing dns-utils" && apt install dnsutils
type -P tput 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
type -P gpg 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'gpg' not found, installing gnupg" && apt install gnupg -y
type -P lolcat 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'lolcat' not found, installing" && apt install ruby -y && gem install lolcat
type -P pip 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'python3-pip' not found, installing" && apt install python3-pip -y
# ============================================================
		if [ -z $(command -v subfinder) ];then
		printf "${p}[${m}!${p}]${m}subfinder belum di install!!\n"
		printf "${p}[${m}!${p}]${h}apt install subfinder\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n${p}"
		instalsubfinder
		else
		#printf "${p}[${m}!${p}]${h} ${CYAN}ssc ${GREEN}terinstall ✓\n"
		instalsubfinder
		fi
		
		if [ -z $(command -v ssc) ];then
		printf "${p}[${m}!${p}]${m}ssc belum di install!!\n"
		printf "${p}[${m}!${p}]${h}apt install ssc\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n${p}"
		instalssc
		else
		#printf "${p}[${m}!${p}]${h} ${CYAN}ssc ${GREEN}terinstall ✓\n"
		instalssc
		fi
		
		if [ -z $(command -v knockpy) ];then
		printf "${p}[${m}!${p}]${m}knockpy belum di install!!\n"
		printf "${p}[${m}!${p}]${h}pip install knockpy-subdomain\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n${p}"
		instalknockpy
		else
		#printf "${p}[${m}!${p}]${h} ${CYAN}knockpy ${GREEN}terinstall ✓\n"
		instalknockpy
		fi
		
		if [ -z $(command -v node) ];then
		printf "${p}[${m}!${p}]${m}node belum di install!!\n"
		printf "${p}[${m}!${p}]${h}apt install nodejs\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n${p}"
		instal_nodejs_vps
		else
		printf "${p}[${m}!${p}]${h} ${CYAN}node js ${GREEN}terinstall ✓\n"
		fi


    #echo "Update dan instal paket"
    for pkg in "${paketvps[@]}"; do
        check_vps "$pkg"
    done
    sleep 1
}

function forvps(){
IDX="https://raw.githubusercontent.com/njajaldoang/1dra/main/"
VDX="https://raw.githubusercontent.com/triadzyu/very/ganteng/"
    if [[ ! -f /usr/bin/lzmv ]]; then
        wget -qO /usr/bin/lzmv "${IDX}src/vxz"
    else
        printf "${p}[${m}!${p}]${h} ${CYAN}lzmv ${GREEN}terinstall ✓\n"
    fi
    if [[ ! -f /usr/bin/gzd ]]; then
        #gzd info.rng > /usr/bin/cekip
        wget -qO /usr/bin/gzd "${VDX}gzd"
        chmod +x /usr/bin/gzd
    else
        printf "${p}[${m}!${p}]${h} ${CYAN}gzd ${GREEN}terinstall ✓\n"
    fi
    if [[ ! -f /usr/bin/gzz ]]; then
        wget -qO /usr/bin/gzz "${IDX}src/gaza"
        wget -qO /usr/bin/gzt "${IDX}src/gazat"
        chmod +x /usr/bin/gzt
        chmod +x /usr/bin/gzz
        gzz src/termcekip > /usr/bin/cekip
        gzz src/termgetip > /usr/bin/getip
        gzz src/termscan > /usr/bin/scan
        lzmv /usr/bin/cekip > /dev/null 2>&1
        lzmv /usr/bin/getip > /dev/null 2>&1
        lzmv /usr/bin/scan > /dev/null 2>&1
        rm /usr/bin/cekip~
        rm /usr/bin/getip~
        rm /usr/bin/scan~
        chmod +x /usr/bin/cekip
        chmod +x /usr/bin/getip
        chmod +x /usr/bin/scan
    else
        printf "${p}[${m}!${p}]${h} ${CYAN}gzz ${GREEN}terinstall ✓\n"
        printf "${p}[${m}!${p}]${h} ${CYAN}cekip ${GREEN}terinstall ✓\n"
        printf "${p}[${m}!${p}]${h} ${CYAN}getip ${GREEN}terinstall ✓\n"
        printf "${p}[${m}!${p}]${h} ${CYAN}scan ${GREEN}terinstall ✓\n"
    fi
}
# ============================================================
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
# ============================================================
function makedirectory(){
    mkdir -p $HOME/.var
    mkdir -p $HOME/.var/local
    mkdir -p $HOME/.var/local/sbin
    mkdir -p $HOME/.var/local/backup
}
function checkdirectory(){
if [ -d $HOME/.var ]; then rm -rf $HOME/.var; fi
if [ ! -d $HOME/.var ]; then makedirectory; fi
}
# ============================================================
if [ ! -f $HOME/.var/local/sbin/spiner ]; then
    checkdirectory
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
else
    rm -rf $HOME/.var/local/sbin/spiner
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
fi
source $HOME/.var/local/sbin/spiner

REPO_SUBF="https://github.com/triadzyu/subf.git"
PROJECT_SUBF_DIR="$HOME/subf"
if [ ! -d "$PROJECT_SUBF_DIR" ]; then
    git clone "$REPO_SUBF" "$PROJECT_SUBF_DIR"
    cd "$PROJECT_SUBF_DIR"
    bash build
    cd
fi
mainz(){
    display_header
    echo -e "\n\n⌛please wait until finish, dont interupt process..."
    fun_bar 'forvps'
    echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥\n\n"
    
    display_header
    download_packages_vps
    echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥\n\n"


#bash -c \"$(wget -qO- https://raw.githubusercontent.com/triadzyu/gantengz/master/install.sh)\"

echo -e "
Silakan ketik command berikut:

bash -c \"\$(wget -qO- https://raw.githubusercontent.com/triadzyu/gantengz/master/install.sh)\"

bash -c \"\$(wget -qO- https://raw.githubusercontent.com/triadzyu/very/ganteng/start.sh)\"



"

#   bash -c "$(wget -qO- https://raw.githubusercontent.com/triadzyu/very/ganteng/start.sh)"

}
mainz

function install_tools() {
#install golang

#HOME="/root"
#HOME="/usr/local"
#HOME="/srv/zroot"
#PREFIX="/usr"

pasang_di_root(){
    if ! command -v go &> /dev/null; then
        apt install golang -y
        mkdir -p /root/go
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /root/go -xzf go1.24.0.linux-amd64.tar.gz
        #echo 'export PATH="$PATH:/root/go/go/bin"' >> ~/.profile
        echo 'export PATH="$PATH:/root/go/go/bin"' >> ~/.bashrc
        echo 'export GOPATH=/root/go' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
        source ~/.bashrc
        /root/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /root/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "\n${p}[${m}!${p}]${h} golang terinstall ✓\n"
    fi
    if ! grep -q 'go/bin' "$HOME/.bashrc"; then
        apt install golang -y
        mkdir -p /root/go
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /root/go -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/root/go/go/bin"' >> "$HOME/.bashrc"
        echo 'export GOPATH="/root/go"' >> "$HOME/.bashrc"
        echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        /root/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /root/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        source "$HOME/.bashrc"
    fi
    if ! command -v subfinder &> /dev/null; then
        /root/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /root/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "${p}[${m}!${p}]${h} subfinder terinstall ✓\n"
    fi
    if ! command -v bugscanx-go &> /dev/null; then
        mkdir -p $HOME/go
        #go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        $HOME/go/go/bin/go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        cp -f $HOME/go/bin/bugscanx-go /usr/bin/
        chmod +x /usr/bin/bugscanx-go
    else
        printf "${p}[${m}!${p}]${h} bugscanx-go terinstall ✓\n"
    fi

    if ! command -v bugscanner-go &> /dev/null; then
        mkdir -p $HOME/go
        $HOME/go/go/bin/go install -v github.com/Toton-dhibar/bugscanner-go@latest
        cp -f $HOME/go/bin/bugscanner-go /usr/bin/
        chmod +x /usr/bin/bugscanner-go
    else
        printf "${p}[${m}!${p}]${h} bugscanner-go terinstall ✓\n"
    fi
}
pasang_di_local(){
    if ! command -v go &> /dev/null; then
        apt install golang -y
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/usr/local/go/bin"' >> ~/.bashrc
        echo 'export GOPATH=/usr/local' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
        source ~/.bashrc
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "\n${p}[${m}!${p}]${h} golang terinstall ✓\n"
    fi
    if ! grep -q 'go/bin' "$HOME/.bashrc"; then
        apt install golang -y
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/usr/local/go/bin"' >> "$HOME/.bashrc"
        echo 'export GOPATH=/usr/local' >> "$HOME/.bashrc"
        echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        source "$HOME/.bashrc"
    fi
    if ! command -v subfinder &> /dev/null; then
        /usr/local/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /usr/local/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "${p}[${m}!${p}]${h} subfinder terinstall ✓\n"
    fi
    if ! command -v bugscanx-go &> /dev/null; then
        #go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        /usr/local/go/bin/go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        cp -f /usr/local/bin/bugscanx-go /usr/bin/
        chmod +x /usr/bin/bugscanx-go
    else
        printf "${p}[${m}!${p}]${h} bugscanx-go terinstall ✓\n"
    fi

    if ! command -v bugscanner-go &> /dev/null; then
        mkdir -p $HOME/go
        /usr/local/go/bin/go install -v github.com/Toton-dhibar/bugscanner-go@latest
        cp -f /usr/local/bin/bugscanner-go /usr/bin/
        chmod +x /usr/bin/bugscanner-go
    else
        printf "${p}[${m}!${p}]${h} bugscanner-go terinstall ✓\n"
    fi
}
pasang_di_home(){
#HOME="/srv/zroot"
    if ! command -v go &> /dev/null; then
        apt install golang -y
        mkdir -p /srv/zroot/go
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /srv/zroot/go -xzf go1.24.0.linux-amd64.tar.gz
        #echo 'export PATH="$PATH:/root/go/go/bin"' >> ~/.profile
        echo 'export PATH="$PATH:/srv/zroot/go/go/bin"' >> ~/.bashrc
        echo 'export GOPATH=/srv/zroot/go' >> ~/.bashrc
        echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
        source ~/.bashrc
        /srv/zroot/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /srv/zroot/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "\n${p}[${m}!${p}]${h} golang terinstall ✓\n"
    fi
    if ! grep -q 'go/bin' "$HOME/.bashrc"; then
        apt install golang -y
        mkdir -p /srv/zroot/go
        wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
        tar -C /srv/zroot/go -xzf go1.24.0.linux-amd64.tar.gz
        echo 'export PATH="$PATH:/srv/zroot/go/go/bin"' >> "$HOME/.bashrc"
        echo 'export GOPATH="/srv/zroot/go"' >> "$HOME/.bashrc"
        echo 'export PATH=$PATH:$GOPATH/bin' >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        /srv/zroot/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f /root/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        source "$HOME/.bashrc"
    fi
    if ! command -v subfinder &> /dev/null; then
        /srv/zroot/go/go/bin/go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        cp -f $HOME/go/bin/subfinder /usr/bin/
        chmod +x /usr/bin/subfinder
    else
        printf "${p}[${m}!${p}]${h} subfinder terinstall ✓\n"
    fi
    if ! command -v bugscanx-go &> /dev/null; then
        mkdir -p $HOME/go
        #go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        $HOME/go/go/bin/go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        cp -f $HOME/go/bin/bugscanx-go /usr/bin/
        chmod +x /usr/bin/bugscanx-go
    else
        printf "${p}[${m}!${p}]${h} bugscanx-go terinstall ✓\n"
    fi

    if ! command -v bugscanner-go &> /dev/null; then
        mkdir -p $HOME/go
        $HOME/go/go/bin/go install -v github.com/Toton-dhibar/bugscanner-go@latest
        cp -f $HOME/go/bin/bugscanner-go /usr/bin/
        chmod +x /usr/bin/bugscanner-go
    else
        printf "${p}[${m}!${p}]${h} bugscanner-go terinstall ✓\n"
    fi
}

#pasang_di_termux
#pasang_di_root
#pasang_di_local
#pasang_di_home





    echo -e "${p}"
}
#install_tools




