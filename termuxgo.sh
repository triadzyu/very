#!/usr/bin/env bash
p="\033[39;1m"
m="\033[31;1m"
CYAN='\033[0;36m'
YELLOW="\033[1;33m"
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
echo -e "${YELLOW}=== 🚀 Auto-Fix Go Environment & Install Tools ===${p}"
sleep 1

ensure_path() {
    local p1="$HOME/go/bin"

    if ! grep -q "$p1" ~/.bashrc; then
        echo "export PATH=\$PATH:$p1" >> ~/.bashrc
        log INFO "Menambahkan PATH: $p1"
    fi

    export PATH="$PATH:$p1"
}

install_go_advance() {
    apt install golang -y
    ensure_path
    log OK "Go berhasil terinstal: $(go version)"
    go clean -modcache
}

install_profile() {
termuxprofil=$(cat <<'EOF'
# ==== Triadz Ganteng Profile ====
export EDITOR=nano
alias ll='ls -la --color=auto'
alias cls='clear'

if [ -t 1 ]; then
    clear
    echo -e "
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        Powered by Triadz Magelang
            ==> ketik: menu
                  😁👍
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    "
    source ~/.bashrc
fi
# =============================
EOF
)

# Pasang profiling termux
if ! grep -q 'Triadz' "$HOME/.bash_profile"; then
    echo "$termuxprofil" >> "$HOME/.bash_profile"
    log OK "Profil Termux ditambahkan"
    source "$HOME/.bash_profile"
fi

termuxbashrc=$(cat <<'EOF'
alias menu='echo -e "
# =============================
List command:
# =============================
subfinder
bugscanx-go
bugscanner-go
nuclei
# =============================
"'
EOF
)
# Pasang bashrc termux
if ! grep -q 'menu=' "$HOME/.bashrc"; then
    echo "$termuxbashrc" >> "$HOME/.bashrc"
    log OK "Alias menu ditambahkan, Silakan Keluar Termux lalu buka Kembali"
fi
}

main() {
    log INFO "Memulai instalasi Go (Advance Mode)"
    if ! command -v "go" >/dev/null 2>&1; then
        echo -e "[*] ${YELLOW}memasang Go...${p}"
        sleep 2
        install_go_advance
    else
        local path
        path=$(command -v "go")
        log OK "path: $path"
        chmod +x "$path" 2>/dev/null
        echo -e "[✓] ${CYAN}Golang sudah terpasang..${p}"
        return 0
    fi
    
    install_profile
    log OK "Instalasi Triadz Advance selesai!"
    echo -e "${GREEN}Silakan jalankan tools: subfinder, bugscanner-go, bugscanx-go${RESET}\n menu"
}
main}

install_profile() {
termuxprofil=$(cat <<'EOF'
# ==== Triadz Ganteng Profile ====
export EDITOR=nano
alias ll='ls -la --color=auto'
alias cls='clear'

if [ -t 1 ]; then
    clear
    echo -e "
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        Powered by Triadz Magelang
            ==> ketik: menu
                  😁👍
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    "
    source ~/.bashrc
fi
# =============================
EOF
)

# Pasang profiling termux
if ! grep -q 'Triadz' "$HOME/.bash_profile"; then
    echo "$termuxprofil" >> "$HOME/.bash_profile"
    log OK "Profil Termux ditambahkan"
    source "$HOME/.bash_profile"
fi

termuxbashrc=$(cat <<'EOF'
alias menu='echo -e "
# =============================
List command:
# =============================
subfinder
bugscanx-go
bugscanner-go
nuclei
# =============================
"'
EOF
)
# Pasang bashrc termux
if ! grep -q 'menu=' "$HOME/.bashrc"; then
    echo "$termuxbashrc" >> "$HOME/.bashrc"
    log OK "Alias menu ditambahkan, Silakan Keluar Termux lalu buka Kembali"
fi
}

main() {
    log INFO "Memulai instalasi Go (Advance Mode)"
    #latest=$(curl -s https://go.dev/VERSION?m=text | head -1)
    if cek_go_version; then
        echo -e "[✓] ${CYAN}Go versi 1.24.0 sudah terpasang. Melewati instalasi ulang...${p}"
    else
        echo -e "[*] Go belum sesuai, ${YELLOW}memasang Go 1.24.0...${p}"
        sleep 2
        install_go_advance
    fi
    install_profile
    log OK "Instalasi Triadz Advance selesai!"
    echo -e "${GREEN}Silakan jalankan tools: subfinder, bugscanner-go, bugscanx-go${RESET}\n menu"
}
main
