#!/bin/bash
# ==============================
# Data Science Academy
# Script: script10.sh
# ==============================
# Backup dos scripts (com versionamento)

# Fonte
path_src=/mnt/dsacademy

# Destino
# mkdir /tmp/Backup
path_dst=/tmp/Backup

echo
echo -e "\e[0;33mIniciando o Backup dos Scripts do Lab 4.\e[0m"

# Loop pelos arquivos de origem
for file_src in $path_src/*; do

  cp -a -- "$file_src" "$path_dst/${file_src##*/}-$(date +"%d-%m-%y-%r")"

done

echo
echo -e "\e[0;33mBackup Concluído. Verificando a pasta /tmp/Backup.\e[0m"
cd /tmp/Backup
ls -la
cd /mnt/dsacademy
echo
echo -e "\e[0;33mObrigado.\e[0m"
