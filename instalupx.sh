#!/bin/bash

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


function instal_upx_termux() {
echo -e "
    # 📦 Installer UPX untuk Termux (Android)
    # Pasang ke $PREFIX/bin
"

URL="https://release-assets.githubusercontent.com/github-production-release-asset/67031040/81265d49-8d8f-4e04-8f4c-574c0cfd5604?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-11-11T15%3A16%3A33Z&rscd=attachment%3B+filename%3Dupx-5.0.2-arm64_linux.tar.xz&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2025-11-11T14%3A16%3A23Z&ske=2025-11-11T15%3A16%3A33Z&sks=b&skv=2018-11-09&sig=su3PXF%2F8SqHnwblac%2BabIsKkQ4PG56e9UTEgvSjnNkM%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc2Mjg3MTEwMiwibmJmIjoxNzYyODcwODAyLCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.lABJkS4BCszWZ3-QO_AhGctL_dijxaliWA53RowBYr4&response-content-disposition=attachment%3B%20filename%3Dupx-5.0.2-arm64_linux.tar.xz&response-content-type=application%2Foctet-stream"
if command -v upx >/dev/null 2>&1; then
  upx --version
else
  curl -L -o upx-5.0.2-arm64_linux.tar.xz "$URL"
  if [[ ! -f "upx-5.0.2-arm64_linux.tar.xz" ]]; then
    echo "❌ Gagal download upx via curl"
    wget -O "upx-5.0.2-arm64_linux.tar.xz" "$URL"
  else
    echo "✅ Sukses download upx via curl, ekstrak now"
  fi
  tar -xf upx-5.0.2-arm64_linux.tar.xz
  cp -vf upx-5.0.2-arm64_linux/upx $PREFIX/bin/
  chmod +x $PREFIX/bin/upx
  rm -rf upx-5.0.2-arm64_linux.tar.xz upx-5.0.2-arm64_linux
  upx --version
fi
upx

}

function instal_upx_vps() {
URL="https://release-assets.githubusercontent.com/github-production-release-asset/67031040/33708fbd-e153-4f56-bd95-cbd5af137374?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-11-11T14%3A34%3A39Z&rscd=attachment%3B+filename%3Dupx-5.0.2-amd64_linux.tar.xz&rsct=application%2Foctet-stream"
UPX_VERSION="${UPX_VERSION:-5.0.2}"
ASSET="upx-5.0.2-amd64_linux.tar.xz"
DEST="/usr/bin"
ARCH_RAW="$(uname -m)"
case "$ARCH_RAW" in
  aarch64|arm64) ARCH="arm64" ;;
  armv7*|armv6*) ARCH="arm" ;;
  x86_64|amd64) ARCH="amd64" ;;
  i686|i386) ARCH="i386" ;;
  *) ARCH="arm64" ;;
esac

cleanup () {
rm -rf upx-5.0.2-amd64_linux.tar.xz upx-5.0.2-amd64_linux
}
trap 'cleanup' INT EXIT

echo -e "
    # 📦 Installer UPX untuk VPS (Linux)
    # Pasang ke /usr/bin
"
# Warna
info(){ echo -e "\033[1;34m[INFO]\033[0m $*"; }
ok(){ echo -e "\033[1;32m[OK]\033[0m $*"; }
err(){ echo -e "\033[1;31m[ERR]\033[0m $*"; }

  if command -v upx >/dev/null 2>&1; then
    info "📦 UPX v${UPX_VERSION} (arsitektur: ${ARCH}) sudah terpasang di VPS..."
    sleep 3
    upx --version
    sleep 2
    upx
  else
    info "📦 Memasang UPX v${UPX_VERSION} (arsitektur: ${ARCH}) di VPS..."
    curl -L -o upx-5.0.2-amd64_linux.tar.xz "$URL"
    if [[ ! -f "upx-5.0.2-amd64_linux.tar.xz" ]]; then
      err "❌ Gagal download upx via curl"
      wget -O "upx-5.0.2-amd64_linux.tar.xz" "$URL"
    fi
    if [[ ! -s "$ASSET" ]]; then
        err "❌ Gagal mengunduh file UPX!"
        exit 1
    fi
    tar -xf upx-5.0.2-amd64_linux.tar.xz
    if [[ ! -f upx-5.0.2-amd64_linux/upx ]]; then
        err "Binary UPX tidak ditemukan dalam arsip!"
        exit 2
    fi
    cp -vf upx-5.0.2-amd64_linux/upx /usr/bin/
    chmod +x /usr/bin/upx
    ok "✅ UPX berhasil dipasang di $DEST  😁👍"
    sleep 2
    #rm -rf upx-5.0.2-amd64_linux.tar.xz upx-5.0.2-amd64_linux
    upx --version || err "UPX gagal dijalankan!"
    sleep 3
    upx
  fi
  REPO_UPX="https://github.com/upx/upx.git"
  PROJECT_UPX_DIR="$HOME/upx"
  if [ ! -f "/usr/bin/upx" ]; then
    if [ ! -d "$PROJECT_UPX_DIR" ]; then
      git clone "$REPO_UPX"
    fi
  else
    printf "${p}[${m}!${p}]${h} ${CYAN} Upx Ultimate Packer X binary ${GREEN}terinstall ✓\n"
  fi
}

function instalupx() {
if [[ -d "/data/data/com.termux/files/home" ]]; then
    instal_upx_termux
else
    instal_upx_vps
fi
}
	
		
		if [ -z $(command -v upx) ];then
			printf "${p}[${m}!${p}]${m}upx belum di install!!\n"
			printf "${p}[${m}!${p}]${h}run => apt install upx ✓\n"
			printf "${p}[${m}!${p}]${m}Silahkan Install dulu\n"
			sleep 2
			instalupx
		else
			printf "${p}[${m}!${p}]${h} ${CYAN} upx ${GREEN}terinstall ✓\n"
		fi
		
	
