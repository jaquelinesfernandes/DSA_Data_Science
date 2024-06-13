#!/bin/bash
# ==============================
# Data Science Academy
# Script: script6.sh
# ==============================

# Extrai a data corrente do sistema
# Use date --help para verificar as opções
horario_corrente=$(date +"%H%M%S")

# Cria um backup da pasta usando a data corrente no nome do arquivo
tar -czf dados_$horario_corrente.tar.gz /root/dados/ml-latest-small

# Move o arquivo para outra pasta
mv dados_$horario_corrente.tar.gz /tmp