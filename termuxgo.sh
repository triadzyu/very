#!/usr/bin/env bash

echo -e "
# ======================================
#   ADVANCE VPS GO ENV & TOOL INSTALLER
# ======================================
"
# -------- Color & Logger -------------
RESET="\033[0m"
RED="\033[31;1m"
GREEN="\033[32;1m"
YELLOW="\033[33;1m"
CYAN="\033[36;1m"

log() {
    local type="$1"
    shift
    local msg="$*"

    case "$type" in
        INFO)  echo -e "${CYAN}[INFO]${RESET}  $msg" ;;
        OK)    echo -e "${GREEN}[OK]${RESET}    $msg" ;;
        WARN)  echo -e "${YELLOW}[WARN]${RESET}  $msg" ;;
        ERROR) echo -e "${RED}[ERROR]${RESET} $msg" ;;
    esac
}

echo -e "${YELLOW}=== 🚀 Triadz Advance Installer ===${RESET}"
sleep 1


# ======================================
#  ADD PATH ENTRIES SAFELY
# ======================================

ensure_path() {
    local p1="$HOME/go/bin"

    if ! grep -q "$p1" ~/.bashrc; then
        echo "export PATH=\$PATH:$p1" >> ~/.bashrc
        log INFO "Menambahkan PATH: $p1"
    fi

    export PATH="$PATH:$p1"
}


# ======================================
#  ADVANCE GO INSTALLER
# ======================================

install_go_advance() {
    log INFO "Memulai instalasi Go (Advance Mode)"

    # Arsitektur
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        *) log ERROR "Arsitektur tidak didukung: $ARCH"; return 1 ;;
    esac

    # Ambil versi terbaru
    latest=$(curl -s https://go.dev/VERSION?m=text | head -1)
    if [[ -z "$latest" ]]; then
        log ERROR "Tidak bisa mengambil versi terbaru Go"
        return 1
    fi

    FILE="${latest}.linux-${ARCH}.tar.gz"
    URL="https://go.dev/dl/${FILE}"

    log INFO "Mengunduh: $FILE"
    if ! wget -q "$URL" -O "${FILE}"; then
        log WARN "Download gagal, mencoba mirror..."

        MIRROR="https://golang.google.cn/dl/${FILE}"
        wget -q "$MIRROR" -O "${FILE}" || {
            log ERROR "Mirror juga gagal. Instalasi dihentikan."
            return 1
        }
    fi

    log INFO "Ekstrak Go ke $HOME..."
    rm -rf $HOME/go
    mkdir -p $HOME/go
    tar -C $HOME -xzf "$HOME/${FILE}"

    ensure_path

    log OK "Go berhasil terinstal: $(go version)"
}
install_go_advance
