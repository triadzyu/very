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

install_go_tool() {
    local name="$1"
    local module="$2"

    log INFO "Memeriksa: $name"

    if command -v "$name" >/dev/null 2>&1; then
        local path
        path=$(command -v "$name")
        log OK "path: $path"
        chmod +x "$path" 2>/dev/null
        return 0
    fi

    log WARN "$name tidak ditemukan → instalasi dimulai..."

    if ! go install -v "$module"@latest 2>$HOME/${name}_err.log; then
        log ERROR "Instalasi gagal untuk $name"
        log ERROR "$(cat $HOME/${name}_err.log)"
        return 1
    fi

    # Pastikan binary dapat dipanggil
    if ! command -v "$name" >/dev/null 2>&1; then
        if [[ -f "$HOME/go/bin/$name" ]]; then
            cp -f "$HOME/go/bin/$name" /usr/bin/
            log OK "$name ditempatkan di /usr/bin/"
        else
            log ERROR "Binary $name tidak ditemukan setelah instalasi"
            return 1
        fi
    fi

    log OK "$name berhasil terinstal!"
}


# ======================================
#  FIX CONFLICT BINARY /usr/bin vs go/bin
# ======================================
fix_tool_conflict() {
    local name="$1"

    if [[ -f "/usr/bin/$name" && -f "$HOME/go/bin/$name" ]]; then
        log WARN "Duplikasi binary terdeteksi: $name"

        t1=$(stat -c %Y "/usr/bin/$name")
        t2=$(stat -c %Y "$HOME/go/bin/$name")

        if (( t2 > t1 )); then
            cp -f "$HOME/go/bin/$name" /usr/bin/
            log OK "Versi terbaru disalin ke /usr/bin/"
        else
            cp -f "/usr/bin/$name" "$HOME/go/bin/"
            log OK "Sinkronisasi versi lama → go/bin"
        fi
    fi
}

fix_all_conflicts() {
    fix_tool_conflict subfinder
    fix_tool_conflict bugscanner-go
    fix_tool_conflict bugscanx-go
    fix_tool_conflict nuclei
}


# ======================================
#  INSTALL ALL TOOLS
# ======================================
install_all_tools_advance() {
    ensure_path

    log INFO "Memulai instalasi semua tools Go…"

echo -e "
# ======================================
#  UNIVERSAL GO TOOL INSTALLER
# ======================================
"

    install_go_tool "subfinder"     "github.com/projectdiscovery/subfinder/v2/cmd/subfinder"
    install_go_tool "bugscanner-go" "github.com/Toton-dhibar/bugscanner-go"
    install_go_tool "bugscanx-go"   "github.com/ayanrajpoot10/bugscanx-go"
    install_go_tool "nuclei"        "github.com/projectdiscovery/nuclei/v3/cmd/nuclei"
    
    fix_all_conflicts

    log OK "Semua tools selesai dipasang & diverifikasi!"
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
# ======================================
#  MAIN RUNNER
# ======================================

install_go_advance
install_all_tools_advance
install_profile

log OK "Instalasi Triadz Advance selesai!"
echo -e "${GREEN}Silakan jalankan tools: subfinder, bugscanner-go, bugscanx-go${RESET}\n menu"

