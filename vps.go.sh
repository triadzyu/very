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

ensure_path() {
    local p1="/usr/local/go/bin"
    local p2="$HOME/go/bin"

    # Pastikan baris PATH tidak duplikat
    #if ! grep -q "$p1" ~/.bashrc; then
    #    echo "export PATH=\$PATH:$p1" >> ~/.bashrc
    #    log INFO "Menambahkan PATH: $p1"
    #fi
    
    if ! grep -qE "(^|:)$p1(:|$)" ~/.bashrc; then
        echo "export PATH=\$PATH:$p1" >> ~/.bashrc
        log INFO "Menambahkan PATH: $p1"
    fi

    if ! grep -qE "(^|:)$p2(:|$)" ~/.bashrc; then
        echo "export PATH=\$PATH:$p2" >> ~/.bashrc
        log INFO "Menambahkan PATH: $p2"
    fi

    # Apply to current shell session
    export PATH="$PATH:$p1:$p2"
}



install_go_advance() {
    echo -e "${YELLOW}=== 🚀 Auto-Fix Go Environment & Install Tools ===${p}"
    sleep 1
    #echo "[*] Menghapus instalasi Go lama..."
    #rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.0.linux-arm64.tar.gz
    #rm -rf go1* $PREFIX/lib/go* $PREFIX/bin/go $PREFIX/share/go 2>/dev/null || true
    #latest="go1.24.0"
    latest="$(curl -s https://go.dev/VERSION?m=text | head -1)"
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        armv7l)  ARCH="armv6l" ;; # fallback untuk arm32
        *) log ERROR "Unknown Arsitektur : $ARCH"; return 1 ;;
    esac
    if [[ -z "$ARCH" ]]; then
        log ERROR "Tidak bisa mengambil versi terbaru Go"
        return 1
    else
        echo -e "[*] Mendeteksi arsitektur:${YELLOW} $ARCH ${p}"
    fi
    
    FILE="${latest}.linux-${ARCH}.tar.gz"
    GO_URL="https://go.dev/dl/${FILE}"
    
    echo -e "[*] Mengunduh Go $latest untuk${YELLOW} ${ARCH}...${p}"
    log INFO "Mengunduh: $FILE"
    if ! wget "$GO_URL" -O "${FILE}"; then
        log WARN "Download gagal, mencoba mirror..."

        MIRROR="https://golang.google.cn/dl/${FILE}"
        wget -q "$MIRROR" -O "${FILE}" || {
            log ERROR "Mirror juga gagal. Instalasi dihentikan."
            return 1
        }
    fi

    log INFO "Ekstrak Go ke /usr/local..."
    rm -rf /usr/local/go
    tar -C /usr/local -xzf "/usr/local/${FILE}"
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
katana
httpx
# =============================

Silakan ketik command berikut:
domain="whatsapp.com"
nuclei -target https://$domain

subfinder -d $domain -o $domain.txt

bugscanner-go scan direct -f $domain.txt -o cf.$domain.txt
bugscanner-go scan sni -f $domain.txt --threads 16 --timeout 8 --deep 3
bugscanner-go scan cdn-ssl --proxy-filename cf.$domain.txt --target $domain

bugscanx-go direct -f $domain.txt -o cfx.$domain.txt
bugscanx-go sni -f $domain.txt --threads 16 --timeout 8 --deep 3
bugscanx-go ping -f $domain.txt --threads 15 -o ping.$domain.txt
bugscanx-go proxy -f $domain.txt --target $domain
bugscanx-go cdn-ssl --proxy-filename cfx.$domain.txt --target $domain

katana -u https://$domain
httpx -u $domain -sc
cat domains | httpx | katana
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

cek_go_version() {
    if command -v go >/dev/null 2>&1; then
        CURRENT_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
        if [[ "$CURRENT_VERSION" == "1.24.0" ]]; then
            return 0  # versi cocok
        else
            return 1  # versi tidak cocok
        fi
    else
        return 1  # belum terinstal
    fi
}


install_alat() {
    local name=$1
    local module="$2"
    local tool_path="$(command -v ${name} 2>/dev/null)"
    local folderbin="$(dirname "$tool_path")"

    log INFO "Memeriksa: $name"
    if [ -n "$tool_path" ]; then
        echo -e "[✓] Tools ${name} sudah terinstal \n[+] Lokasi $folderbin"
        chmod +x ${tool_path}
    else
        echo "[✗]${RED} ${name} tidak ditemukan"
        log WARN "$name tidak ditemukan → instalasi dimulai..."
        if [[ "$name" =~ ^subfinder ]]; then
            echo "[*] Menginstal subfinder..."
            if ! go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        if [[ "$name" =~ ^bugscanner ]]; then
            echo "[*] Menginstal bugscanner-go..."
            if ! go install -v github.com/Toton-dhibar/bugscanner-go@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        if [[ "$name" =~ ^bugscanx ]]; then
            echo "[*] Menginstal bugscanx-go..."
            if ! go install -v github.com/ayanrajpoot10/bugscanx-go@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        if [[ "$name" =~ ^nuclei ]]; then
            echo "[*] Menginstal nuclei..."
            if ! go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        if [[ "$name" =~ ^katana ]]; then
            echo "[*] Menginstal katana..."
            if ! go install -v github.com/projectdiscovery/katana/cmd/katana@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        if [[ "$name" =~ ^httpx ]]; then
            echo "[*] Menginstal httpx*..."
            if ! go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>$HOME/${name}_err.log; then
                log ERROR "Instalasi gagal untuk $name"
                log ERROR "$(cat $HOME/${name}_err.log)"
                return 1
            fi
        fi
        
    fi
}

mytools=(
subfinder
bugscanner-go
bugscanx-go
nuclei
katana
httpx
)

finishing() {
    install_profile
    
    mkdir -p /usr/local/go
    mkdir -p /usr/local/go/bin

    echo -e "# 5️⃣ ${YELLOW}Instal semua tools${p}"
    sleep 1

    for mytool in "${mytools[@]}"; do
        install_alat "$mytool" 
    done

    echo "[✓] Semua tools telah terinstal "
    log OK "Semua tools selesai dipasang & diverifikasi!"
    
    log OK "Instalasi Triadz Advance selesai!"
    echo -e "${GREEN}Silakan jalankan tools: subfinder, bugscanner-go, bugscanx-go, nuclei ${RESET}\n menu"
}

install_go() {
    apt install golang -y
    ensure_path
    log OK "Go berhasil terinstal: $(go version)"
    go clean -modcache
    finishing
}

main() {
    local path
    path=$(command -v "go")
    chmod +x "$path" 2>/dev/null
    log INFO "Check and install Go (Advance Mode)"

    if ! command -v "go" >/dev/null 2>&1; then
        echo -e "[*] ${YELLOW} Belum terinstall Go...${p}"
        sleep 2
        log INFO "Memulai instalasi Go (Advance Mode)"
        sleep 2
        install_go
    else
        log OK "path: $path"
        echo -e "[✓] ${CYAN}Golang sudah terpasang..${p}"
        LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1 | sed 's/go//')
        CURRENT_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
        if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
            echo -e "[✓] ${CYAN} Versi Go sudah up to date..${p}"
        else
            echo -e "[✓] ${CYAN} Tersedia Versi Go yang lebih tinggi..${p}"
            echo -e "[✓] ${CYAN} CURRENT VERSION = $CURRENT_VERSION..${p}"
            echo -e "[✓] ${CYAN} LATEST  VERSION = $LATEST_VERSION..${p}"
            read -p "Apakah Anda yakin ingin update ke versi terbaru ? (y/n): " CONFIRM
            if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
                install_go_advance
            else
                echo -e "[✓] ${CYAN} Melanjutkan Versi Go yang sekarang..${p}"
            fi
        fi
        finishing
        return 0
    fi
}
main


