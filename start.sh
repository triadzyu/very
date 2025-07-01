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
PROJECT_KNOCK_DIR="$HOME/knock"

#git clone https://github.com/Rem01Gaming/ssc
REPO_ENC="https://github.com/triadzyu/enc.git"
REPO_SUBF="https://github.com/triadzyu/subf.git"
REPO_UPX="https://github.com/upx/upx.git"
REPO_SSC="https://github.com/liberize/ssc.git"
REPO_KNOCK="https://github.com/guelfoweb/knock.git"


if [ ! -d "$PROJECT_KNOCK_DIR" ]; then
    pip install knock-subdomains
    git clone "$REPO_KNOCK" "$PROJECT_KNOCK_DIR"
    cd "$PROJECT_KNOCK_DIR"
    pip install .
    #knockpy -d $basedomain --recon --bruteforce
    cd
fi

if [ ! -d "$PROJECT_SUBF_DIR" ]; then
    git clone "$REPO_SUBF" "$PROJECT_SUBF_DIR"
    cd "$PROJECT_SUBF_DIR"
    bash build
    cd
fi
if [ ! -d "$PROJECT_ENC_DIR" ]; then
    git clone "$REPO_ENC" "$PROJECT_ENC_DIR"
fi
if [ ! -d "$PROJECT_SSC_DIR" ]; then
    git clone "$REPO_SSC" "$PROJECT_SSC_DIR"
    apt install binutils
    apt install libarchive-dev
    apt install acl-dev -y
    apt install libz-dev -y
    apt install git
    apt install perl -y
fi
if [ ! -d "$PROJECT_UPX_DIR" ]; then
    git clone "$REPO_UPX" "$PROJECT_UPX_DIR"
    cd "$PROJECT_UPX_DIR"
    git submodule update --init

    nohup make > make.log 2>&1 &

    for i in $(seq 1 300); do
        sleep 0.5
        cat make.log
    done
    
    cd
    cd $HOME/upx/build/release

    nohup make > make2.log 2>&1 &

    for i in $(seq 1 300); do
        sleep 0.5
        cat make2.log
    done
    #300=5mnt

    chmod 777 upx
    cp -f upx /usr/bin
    chmod +x $HOME/upx/build/release/upx
    cp -f $HOME/upx/build/release/upx /usr/bin
    chmod 777 /usr/bin/upx
    cd
fi
    if ! command -v upx &> /dev/null; then
        if [ ! -d "$PROJECT_UPX_DIR" ]; then
            git clone "$REPO_UPX" "$PROJECT_UPX_DIR"
        fi
        
        cd "$PROJECT_UPX_DIR"
        git submodule update --init
        
        nohup make > make.log 2>&1 &
        #300=5mnt
        for i in $(seq 1 300); do
            sleep 0.5
            cat make.log
        done
    
        cd
        cd $HOME/upx/build/release

        nohup make > make2.log 2>&1 &

        for i in $(seq 1 300); do
            sleep 0.5
            cat make2.log
        done
    
        chmod 777 upx
        cp -f upx /usr/bin
        chmod +x $HOME/upx/build/release/upx
        cp -f $HOME/upx/build/release/upx /usr/bin
        chmod 777 /usr/bin/upx
        cd
    else
        printf "${p}[${m}!${p}]${h} upx crypter terinstall ✓\n"
    fi

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

function bannerwrt(){
        clear
        echo -e "              Yaddy Kakkoii" | lolcat
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

##########################################################
############ OPENWRT REQUIRED PACKAGE
##########################################################
packages=(
    "gcc"
    "git"
    "git-http"
    "modemmanager"
    "python3-pip"
    "bc"
    "screen"
    "adb"
    "httping"
    "lolcat"
    "jq"
)
check_openwrt() {
    local package="$1"
    if opkg list-installed | grep -q "^$package -"; then
        echo "$package sudah terpasang."
    else
        echo "$package belum terpasang. Menginstal $package..."
        #opkg update && opkg install "$package"
        opkg install "$package"
        if [ $? -eq 0 ]; then
            echo "$package berhasil diinstal."
        else
            echo "Gagal menginstal $package."
        fi
    fi
}
download_packages_openwrt() {
    echo "Update dan instal paket"
    opkg update
    for pkg in "${packages[@]}"; do
        check_openwrt "$pkg"
    done
    sleep 1
}
#############################################################
############ TERMUX REQUIRED PACKAGE
##########################################################
pakettermux=(
    "bash"
    "libwebp"
    "ffmpeg"
    "imagemagick"
    "libarchive"
    "libandroid-wordexp"
    "wget"
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
    "patchelf"
    "file"
    "clang"
)

check_termux() {
    local pakettermux="$1"
    if ls /data/data/com.termux/files/usr/bin | grep -q "^$pakettermux"; then
        #echo "$pakettermux sudah terpasang.✓"
        printf "${p}[${m}!${p}]${h} $pakettermux terinstall ✓\n"
    else
        echo "$pakettermux belum terpasang. Menginstal $pakettermux..."
        apt install ${pakettermux} -y
        if [ $? -eq 0 ]; then
            echo "$pakettermux berhasil diinstal."
        else
            echo "Gagal menginstal $pakettermux."
            apt-get update -y
            apt-get upgrade -y
            apt install ${pakettermux} --fix-missing
        fi
    fi
}

download_packages_termux() {
    echo "Update dan instal paket"
    for pkg in "${pakettermux[@]}"; do
        check_termux "$pkg"
    done
    sleep 1
}



#############################################################
############ VPS REQUIRED PACKAGE
##########################################################
paketvps=(
    "wget"
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

download_packages_vps() {
    #echo "Update dan instal paket"
    for pkg in "${paketvps[@]}"; do
        check_vps "$pkg"
    done
    sleep 1
}
#############################################################

trap ctrl_c INT
#trap ctrl_d EXIT

ctrl_d() {
    clear
    if [ -f start.sh ]; then rm -f start.sh; fi
    echo -e "proses build telah selesai."
    exit 0
}

ctrl_c() {
    clear
    if [ -f start.sh ]; then rm -f start.sh; fi
    echo -e "proses build telah dibatalkan."
    exit 1
}

display_header() {
#clear
  echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          │ MAGELANG ⚡ PHREAKER │                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}║${NC}${GREEN}          █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█                ${NC}${CYAN}║${NC}"
  echo -e "${CYAN}╠══════════════════════════════════════════════════╣${NC}"
  echo -e "${CYAN}║${NC} ${MAGENTA}📅 Tanggal: $(date '+%A, %d %B %Y')${NC}                ${CYAN}║${NC}"
  echo -e "${CYAN}║${NC} ${MAGENTA}⏰ Waktu: $(date '+%H:%M:%S')${NC}                               ${CYAN}║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
}

function fortermux1(){
termux_packages=( "libwebp" "imagemagick" "libarchive" "libandroid-wordexp" "binutils" "coreutils" "ncurses-utils" )
    for paket in "${termux_packages[@]}"; do
        apt install "$paket" -y
    done
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
#clear
}

echo -e "\n\n${CLWhite} Sedang Menjalankan script.${CLYellow} Mohon Tunggu.."
echo -e "${CLWhite} Pastikan Koneksi Internet Lancar\n\n"

show_loading
sleep 1


function basic_tools(){
		if [ -z $(command -v curl) ];then
		printf "${p}[${m}!${p}]${m}curl belum di install!!\n"
		printf "${p}[${m}!${p}]${h}pkg install curl\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n"
		exit
		else
		printf "${p}[${m}!${p}]${h} curl terinstall ✓\n"
		fi
		
		if [ -z $(command -v nano) ];then
		printf "${p}[${m}!${p}]${m}nano belum di install!!\n"
		printf "${p}[${m}!${p}]${h}pkg install nano\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n"
		exit
		else
		printf "${p}[${m}!${p}]${h} nano terinstall ✓\n"
		fi
		
		if [ -z $(command -v nslookup) ];then
		printf "${p}[${m}!${p}]${m}nslookup belum di install!!\n"
		printf "${p}[${m}!${p}]${h}pkg install dnsutils\n"
		printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n"
		pkg install dnsutils
		else
		printf "${p}[${m}!${p}]${h} nslookup terinstall ✓\n"
		fi
}

# ============================================================
if ! command -v which &> /dev/null; then apt install which -y; fi
type -P wget 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'wget' not found, installing" && apt install wget -y
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
type -P nmap 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'nmap' not found, installing" && apt install nmap -y
type -P tput 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
type -P gpg 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'gpg' not found, installing gnupg" && apt install gnupg -y
type -P lolcat 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'lolcat' not found, installing" && apt install ruby -y && gem install lolcat
# ============================================================




instal_nodejs_termux(){
    echo "Menginstall Node_Modules"
    echo ""
    sleep 3
    pkg update && pkg upgrade -y
    pkg install nodejs -y
    apt install nodejs-lts -y
    node -v
    ln -s ${folder_bin}nodejs ${folder_bin}node
    npm install -g bash-obfuscate
    npm -v
    apt install binutils -y
    apt install ncurses-utils -y
    apt install yarn
    yarn install
    #npm start
}
instal_nodejs_vps(){
    apt update && apt upgrade -y
    apt install binutils -y
    apt install ncurses-utils -y
    apt install npm nodejs -y
    ln -s ${vps_bin}nodejs ${vps_bin}node
    npm install -g bash-obfuscate
    node -v
    npm -v
}
# ============================================================
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
IDX="https://raw.githubusercontent.com/njajaldoang/1dra/main/"
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
# ============================================================
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
# ============================================================

folder_bin=$(which curl | sed 's/curl//g')
termux_bin="/data/data/com.termux/files/usr/bin/"
vps_bin="/usr/bin/"

function dpkg_query(){
    if [ $(dpkg-query -W -f='${Status}' shc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall shc, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        apt update && apt upgrade -y
        apt install shc
    #if [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    #if [ $(dpkg-query -W -f='${Status}' nodejs-lts 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    elif [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall nodejs, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        if [[ -d ${termux_bin} ]]; then
            if [[ ! -f ${termux_bin}npm ]]; then
                instal_nodejs_termux
            fi
        else
            instal_nodejs_vps
        fi
    fi
}

#   br=xzz gzz=1dra gzt=stb

function fortermux(){
    #if [[ -e ${termux_bin}gzz ]]; then rm -f ${termux_bin}gzz; fi
    if [[ ! -f ${termux_bin}gzz ]]; then
        wget -qO ${termux_bin}xzz "${IDX}src/termxz"
        wget -qO ${termux_bin}brot "${IDX}src/termbrot"
        wget -qO ${termux_bin}gzz "${IDX}src/termgaza"
        wget -qO ${termux_bin}gzt "${IDX}src/termgstb"
        chmod +x ${termux_bin}gzt
        chmod +x ${termux_bin}gzz
        chmod +x ${termux_bin}brot
        chmod +x ${termux_bin}xzz
        gzz src/termcekip > $PREFIX/bin/cekip
        gzz src/termgetip > $PREFIX/bin/getip
        gzz src/termscan > $PREFIX/bin/scan
        xzz $PREFIX/bin/cekip > /dev/null 2>&1
        xzz $PREFIX/bin/getip > /dev/null 2>&1
        xzz $PREFIX/bin/scan > /dev/null 2>&1
        rm $PREFIX/bin/cekip~
        rm $PREFIX/bin/getip~
        rm $PREFIX/bin/scan~
        chmod +x ${termux_bin}cekip
        chmod +x ${termux_bin}getip
        chmod +x ${termux_bin}scan
    fi
}

function forvps(){
VDX="https://raw.githubusercontent.com/triadzyu/very/ganteng/"
    if [[ ! -f ${vps_bin}lzmv ]]; then
        wget -qO ${vps_bin}lzmv "${IDX}src/vxz"
    fi
    if [[ ! -f ${vps_bin}gzd ]]; then
        wget -qO ${vps_bin}gzd "${VDX}gzd"
        chmod +x ${vps_bin}gzd
    fi
    if [[ ! -f ${vps_bin}gzz ]]; then
        wget -qO ${vps_bin}gzz "${IDX}src/gaza"
        wget -qO ${vps_bin}gzt "${IDX}src/gazat"
        chmod +x ${vps_bin}gzt
        chmod +x ${vps_bin}gzz
        gzz src/termcekip > /usr/bin/cekip
        gzz src/termgetip > /usr/bin/getip
        gzz src/termscan > /usr/bin/scan
        lzmv /usr/bin/cekip > /dev/null 2>&1
        lzmv /usr/bin/getip > /dev/null 2>&1
        lzmv /usr/bin/scan > /dev/null 2>&1
        rm /usr/bin/cekip~
        rm /usr/bin/getip~
        rm /usr/bin/scan~
        chmod +x ${vps_bin}cekip
        chmod +x ${vps_bin}getip
        chmod +x ${vps_bin}scan
    fi
}

if [[ "$folder_bin" = "$termux_bin" ]]; then
    kakkoii
    echo -e "\nhai user termux! \n"
    if ! command -v which &> /dev/null; then apt install which -y; fi && if ! which gawk &> /dev/null; then apt install gawk; fi
    type -P tput 1>/dev/null
    [ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
    dpkg_query
    download_packages_termux
    
    echo -e "\n\n⌛please wait until finish, dont interupt process..."
    fortermux1
    fun_bar 'fortermux'
    echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
else
    if [[ -e /etc/openclash ]]; then
        bannerwrt
        echo -e "\nhai user openwrt! \n"
        download_packages_openwrt
        echo -e "\n\n⌛please wait until finish, dont interupt process..."
        if [[ ! -f ${vps_bin}xzwrt ]]; then wget -qO ${vps_bin}xzwrt "${IDX}src/vxz"; fi && if [[ -e ${vps_bin}gzz ]]; then rm -f ${vps_bin}gzz; fi
        if [[ ! -f ${vps_bin}gzz ]]; then
            wget -qO ${vps_bin}gzz "${IDX}src/gazawrti" && wget -qO ${vps_bin}gzt "${IDX}src/gazawrty" && chmod +x ${vps_bin}gzt && chmod +x ${vps_bin}gzz && gzz src/cekipwrt > /usr/bin/cekip && gzz src/getipwrt > /usr/bin/getip && gzz src/scanwrt > /usr/bin/scan && xzwrt /usr/bin/cekip > /dev/null 2>&1 && xzwrt /usr/bin/getip > /dev/null 2>&1 && xzwrt /usr/bin/scan > /dev/null 2>&1 && rm /usr/bin/cekip~ && rm /usr/bin/getip~ && rm /usr/bin/scan~ && chmod +x ${vps_bin}cekip && chmod +x ${vps_bin}getip && chmod +x ${vps_bin}scan
        fi
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
    else
        kakkoii
        echo -e "\nhai user vps! \n"
        if ! command -v which &> /dev/null; then apt install which -y; fi && if ! which gawk &> /dev/null; then apt install gawk; fi
        type -P tput 1>/dev/null
        [ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
        dpkg_query
        download_packages_vps
        echo -e "\n\n⌛please wait until finish, dont interupt process..."
        fun_bar 'forvps'
        echo -e "[ ${GREEN}INFO${NC} ] ✔ Success, install dependencies 🔥🔥🔥"
    fi
fi

show_loading
display_header
#bash -c \"$(wget -qO- https://raw.githubusercontent.com/triadzyu/gantengz/master/install.sh)\"

echo -e "
Silakan ketik command berikut:

bash -c \"\$(wget -qO- https://raw.githubusercontent.com/triadzyu/gantengz/master/install.sh)\"

bash -c \"\$(wget -qO- https://raw.githubusercontent.com/triadzyu/very/ganteng/start.sh)\"


"
