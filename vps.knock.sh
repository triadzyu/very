#!/bin/bash

# ============= WARNA =============
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

p="\033[39;1m"; m="\033[31;1m"; h="\033[32;1m"; CYAN="\033[0;36m"

# ========== KONFIGURASI ==========
PROJECT_KNOCK_DIR="$HOME/knock"
REPO_KNOCK="https://github.com/guelfoweb/knock.git"
TARGET_BIN="/usr/bin/knockpy"


# ===============================
#  Fungsi: Install knockpy V2
# ===============================
instalknockv2() {
    echo -e "${YELLOW}[+] Menyiapkan dependensi...${NC}"
    sudo apt update -y
    sudo apt install -y git python3 python3-pip python3-venv

    if [ ! -d "$PROJECT_KNOCK_DIR" ]; then
        echo -e "${YELLOW}[+] Meng-clone Knock dari GitHub...${NC}"
        git clone "$REPO_KNOCK" "$PROJECT_KNOCK_DIR"
        cd ${PROJECT_KNOCK_DIR}
        pip install .
    else
        echo -e "${YELLOW}[+] Repositori sudah ada, memperbarui...${NC}"
        cd "$PROJECT_KNOCK_DIR"
        git pull --rebase || git pull origin main || git pull
    fi

    if ! command -v knockpy >/dev/null 2>&1; then
      echo -e "${YELLOW}[+] Membuat virtual environment ${PROJECT_KNOCK_DIR}...${NC}"
      python3 -m venv ${PROJECT_KNOCK_DIR}
      echo -e "${YELLOW}[+] Aktifkan ${PROJECT_KNOCK_DIR}"
      source ${PROJECT_KNOCK_DIR}/bin/activate
      echo -e "${YELLOW}[+] Upgrade pip dan build tools "
      pip install --upgrade pip setuptools wheel
      cd "$PROJECT_KNOCK_DIR"
      echo -e "${YELLOW}[+] Menginstal Knock dependencies...${NC}"
      pip install -U .
      echo -e "${YELLOW}[+] Menyalin knockpy ke /usr/bin...${NC}"
      chmod +x ${PROJECT_KNOCK_DIR}/bin/knockpy
      cp -vf ${PROJECT_KNOCK_DIR}/bin/knockpy "$TARGET_BIN"
      echo -e "${CYAN}knockpy ${GREEN}berhasil terpasang & siap digunakan! ✓${NC}"
    fi
    cd
    
}

# ===============================
#  Fungsi: Install knockpy utama
# ===============================
instalknockpy(){

    # Jika folder belum pernah dibuat → clone & install
    if [ ! -d "$PROJECT_KNOCK_DIR" ]; then
        echo -e "${YELLOW}[+] Clone repository...${NC}"
        git clone "$REPO_KNOCK" "$PROJECT_KNOCK_DIR"
        cd "$PROJECT_KNOCK_DIR"
        pip install .
        cd
    fi

    if ! command -v knockpy >/dev/null 2>&1; then
      if [ -f "${PROJECT_KNOCK_DIR}/bin/activate" ]; then
        echo -e "${YELLOW}[+] Mengaktifkan venv...${NC}"
        apt install -y git python3 python3-pip python3-venv
        python3 -m venv ${PROJECT_KNOCK_DIR}
        source "${PROJECT_KNOCK_DIR}/bin/activate"
        cd ${PROJECT_KNOCK_DIR}
        pip install .
        chmod +x ${PROJECT_KNOCK_DIR}/bin/knockpy
        cp -f ${PROJECT_KNOCK_DIR}/bin/knockpy /usr/bin
        if ls /usr/bin | grep -q "knockpy"; then
            printf "${p}[${m}!${p}]${CYAN} knockpy ${GREEN}terinstall ✓${NC}\n"
        fi
      fi
    fi

    if ! command -v knockpy >/dev/null 2>&1; then
        instalknockv2
        return
    fi
    

    printf "${p}[${h}✓${p}]${CYAN} knockpy ${GREEN}sudah terinstall.${NC}\n"
    cd
}


# ===============================
#  Wrapper: General Checker
# ===============================
check_and_install() {
    local tool="$1"
    local func="$2"

    if ! command -v "$tool" &>/dev/null; then
        printf "${p}[${m}!${p}]${m}%s belum diinstall!!\n" "$tool"
        printf "${p}[${m}!${p}]${h}Menyiapkan proses instalasi %s...\n${p}" "$tool"
        "$func"
    else
        printf "${p}[${h}✓${p}]${h}%s sudah terinstall.${p}\n" "$tool"
    fi
}

# Eksekusi utama
check_and_install "knockpy" "instalknockpy"







#!/

instalknockv2() {
PROJECT_KNOCK_DIR="$HOME/knock"
REPO_KNOCK="https://github.com/guelfoweb/knock.git"
TARGET_BIN="/usr/bin/knockpy"

if ! command -v knockpy &> /dev/null; then
    echo -e "${YELLOW}[+] Menyiapkan dependensi...${NC}"
    sudo apt update -y
    sudo apt install -y git python3 python3-pip python3-venv

    if [ ! -d "$PROJECT_KNOCK_DIR" ]; then
        echo -e "${YELLOW}[+] Meng-clone Knock dari GitHub...${NC}"
        git clone "$REPO_KNOCK" "$PROJECT_KNOCK_DIR"
    else
        echo -e "${YELLOW}[+] Repositori sudah ada, memperbarui...${NC}"
        cd "$PROJECT_KNOCK_DIR"
        git pull --rebase || git pull origin main || git pull
    fi

    cd "$PROJECT_KNOCK_DIR"
    if [ ! -d "${PROJECT_KNOCK_DIR}" ]; then
        echo -e "${YELLOW}[+] Membuat virtual environment ${PROJECT_KNOCK_DIR}...${NC}"
        python3 -m venv ${PROJECT_KNOCK_DIR}
    fi

    echo -e "${YELLOW}[+] Aktifkan ${PROJECT_KNOCK_DIR}"
    source ${PROJECT_KNOCK_DIR}/bin/activate

    echo -e "${YELLOW}[+] Upgrade pip dan build tools "
    pip install --upgrade pip setuptools wheel

    echo -e "${YELLOW}[+] Menginstal Knock dependencies...${NC}"
    pip install -U .

    echo -e "${YELLOW}[+] Menyalin knockpy ke /usr/bin...${NC}"
    chmod +x ${PROJECT_KNOCK_DIR}/bin/knockpy
    sudo cp -f ${PROJECT_KNOCK_DIR}/bin/knockpy "$TARGET_BIN"
fi
# Cek hasil akhir
if command -v knockpy >/dev/null 2>&1; then
    echo -e "${CYAN}knockpy ${GREEN}berhasil terpasang & siap digunakan! ✓${NC}"
else
    echo -e "${RED}Gagal memasang knockpy :(${NC}"
    exit 1
fi
cd
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
        apt install -y git python3 python3-pip python3-venv
        python3 -m venv ${PROJECT_KNOCK_DIR}
        source ${PROJECT_KNOCK_DIR}/bin/activate
        cd ${PROJECT_KNOCK_DIR}
        pip install .
        chmod +x ${PROJECT_KNOCK_DIR}/bin/knockpy
        cp -f ${PROJECT_KNOCK_DIR}/bin/knockpy /usr/bin
        if ls /usr/bin | grep -q "knockpy"; then
            printf "${p}[${m}!${p}]${CYAN} knockpy ${GREEN}terinstall ✓${NC}\n"
        fi
    fi
    if command -v knockpy >/dev/null 2>&1; then
        echo -e "${CYAN}knockpy ${GREEN}berhasil terpasang & siap digunakan! ✓${NC}"
    else
        echo -e "${RED}Gagal memasang knockpy :(${NC}"
        instalknockv2
    fi
else
    if [ -f "${PROJECT_KNOCK_DIR}/bin/activate" ]; then
        source ${PROJECT_KNOCK_DIR}/bin/activate
    else
        instalknockv2
    fi
    printf "${p}[${m}!${p}]${CYAN} knockpy ${GREEN}terinstall ✓${NC}\n"
fi
cd
}
check_and_install() {
	local tool_name="$1"
	local install_func="$2"

	if ! command -v "$tool_name" &>/dev/null; then
		printf "${p}[${m}!${p}]${m}%s belum diinstall!!\n" "$tool_name"
		printf "${p}[${m}!${p}]${h}Menyiapkan proses instalasi %s...\n${p}" "$tool_name"
		"$install_func"
	else
		printf "${p}[${h}✓${p}]${h}%s sudah terinstall.${p}\n" "$tool_name"
	fi
}

check_and_install "knockpy" "instalknockpy"
