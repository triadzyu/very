#!/bin/bash
if [ -d "$HOME/reedem" ]; then
git clone https://github.com/kejuashuejia/reedem
fi

cd /data/data/com.termux/files/home/

copy_akun() {
    local source_dir="$1"
    local dest_dir="$2"

local files=(
"active.number"
"api.key"
"refresh-tokens.json"
"ax.fp"
"bookmark.json"
)

    echo "Memindahkan kredensial dari $source_dir ke $dest_dir..."
    
    for file in "${files[@]}"; do
        if [ -f "$source_dir/$file" ]; then
            cp -vf "$source_dir/$file" "$dest_dir/$file"
            echo "✓ $file berhasil disalin"
        else
            echo "⚠ $file tidak ditemukan di $source_dir"
        fi
    done
}

copy_akun "me-cli" "reedem"
