#!/bin/bash
mkdir -p $HOME/go
    if ! command -v bugscanner-go &> /dev/null; then
        echo "[*] Menginstal bugscanner-go..."
        go install -v github.com/Toton-dhibar/bugscanner-go@latest
        chmod +x /usr/bin/bugscanner-go
    fi
    if ! command -v bugscanx-go &> /dev/null; then
        echo "[*] Menginstal bugscanx-go..."
        go install -v github.com/Ayanrajpoot10/bugscanx-go@latest
        chmod +x /usr/bin/bugscanx-go
    fi
    if ! command -v subfinder &> /dev/null; then
        echo "[*] Menginstal subfinder..."
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        chmod +x /usr/bin/subfinder
    fi
