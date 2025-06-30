# gantengz
gzt=stb
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
IDX="https://raw.githubusercontent.com/njajaldoang/1dra/main/"
gzz=1dra

br=xzz 
    if [[ ! -f ${vps_bin}lzmv ]]; then
        wget -qO ${vps_bin}lzmv "${IDX}src/vxz"
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
PROJECT_ENC_DIR="$HOME/enc"
PROJECT_SUBF_DIR="$HOME/subf"
PROJECT_SSC_DIR="$HOME/ssc"
PROJECT_UPX_DIR="$HOME/upx"
    output_SSC="$HOME/enc/output_ssc"
    mkdir -p ${output_SSC}
    cd ${PROJECT_SSC_DIR}
    ./ssc -u -s -r -v "${output_SSC}/outfile.usr" "infile.sh"
    ./ssc -u -s -r -v xfile xfile.sh
    ./ssc -u -s -v tes.us tes.sh
    
    output_UPX="$HOME/enc/output_upx"
    mkdir -p ${output_UPX}
    cd ${PROJECT_UPX_DIR}
    upx -9 -vfk -o outfileupx infileshc
    upx -d outfileupx
    upx -9 --lzma -vfk -o upx_scan upx_scan.sh
    upx -9 --brute -vfk -o upx_scan upx_scan.sh
    upx -9 --ultra-brute -vfk -o upx_scan upx_scan.sh
