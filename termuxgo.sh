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

echo -e "${YELLOW}=== 🚀 Triadz Advance Installer (Parallel Mode) ===${RESET}"
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
#  SAFE PATCH: FIX PERMISSION MODCACHE
# ======================================
fix_modcache() {
    log INFO "Membersihkan modcache Go dengan cara aman..."
    go clean -modcache 2>/dev/null
    chmod -R u+w "$HOME/go/pkg/mod" 2>/dev/null
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
    rm -rf "$HOME/go"
    mkdir -p "$HOME/go"
    tar -C "$HOME" -xzf "$HOME/${FILE}"

    ensure_path

    log OK "Go berhasil terinstal: $(go version)"
}


# ======================================
#  PARALLEL UNIVERSAL GO TOOL INSTALLER
# ======================================
install_all_tools_advance() {
    ensure_path

    log INFO "Menjalankan instalasi PARALLEL semua tools Go…"
    echo -e "
# ======================================
#   UNIVERSAL PARALLEL GO TOOL INSTALLER
# ======================================
"

    tools=(
        "subfinder|github.com/projectdiscovery/subfinder/v2/cmd/subfinder"
        "bugscanner-go|github.com/Toton-dhibar/bugscanner-go"
        "bugscanx-go|github.com/ayanrajpoot10/bugscanx-go"
        "nuclei|github.com/projectdiscovery/nuclei/v3/cmd/nuclei"
    )

    CPU=$(nproc 2>/dev/null || echo 4)
    log INFO "Parallel build menggunakan $CPU worker"

    pids=()

    for entry in "${tools[@]}"; do
        name="${entry%%|*}"
        module="${entry##*|}"

        (
            log INFO "[Parallel] Instalasi: $name"

            if command -v "$name" >/dev/null 2>&1; then
                log OK "$name sudah terpasang → skip"
                exit 0
            fi

            if ! go install -v "$module"@latest &> "$HOME/${name}_parallel.log"; then
                log ERROR "Gagal install $name (lihat ~/{$name}_parallel.log)"
                exit 1
            fi

            if [[ -f "$HOME/go/bin/$name" ]]; then
                cp -f "$HOME/go/bin/$name" /usr/bin/ 2>/dev/null
            fi

            log OK "$name selesai dipasang!"
        ) &

        pids+=($!)

        while (( $(jobs -rp | wc -l) >= CPU )); do
            sleep 0.3
        done
    done

    for pid in "${pids[@]}"; do
        wait "$pid"
    done

    fix_all_conflicts

    log OK "Semua tools selesai dipasang (Parallel Mode)!"
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
#  TERMUX PROFILE
# ======================================
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

if ! grep -q 'Triadz' "$HOME/.bash_profile"; then
    echo "$termuxprofil" >> "$HOME/.bash_profile"
    log OK "Profil Termux ditambahkan"
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

if ! grep -q 'menu=' "$HOME/.bashrc"; then
    echo "$termuxbashrc" >> "$HOME/.bashrc"
    log OK "Alias menu ditambahkan, Silakan keluar & buka kembali Termux"
fi
}


# ======================================
#  MAIN RUNNER
# ======================================

install_go_advance
fix_modcache
install_all_tools_advance
install_profile

log OK "Instalasi Triadz Advance (Parallel Edition) selesai!"
echo -e "${GREEN}Silakan jalankan: subfinder, bugscanner-go, bugscanx-go${RESET}\nmenu"
