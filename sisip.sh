#!/bin/bash
sisip(){
blue='\033[0;36m'
for tools in welcome warning; do
  url="https://raw.githubusercontent.com/triadzyu/very/ganteng/${tools}"
  dst="/usr/local/sbin/$tools"
  [ -f "$dst" ] && rm -vf "$dst"
  wget -qO "$dst" "$url"
  chmod +x "$dst"
  echo -e "${blue} "$dst" telah diperbarui ✓✓${NC} "
done
}
sisip
