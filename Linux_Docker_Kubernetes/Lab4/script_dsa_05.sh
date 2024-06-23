#!/bin/bash
# ==============================
# Data Science Academy
# Script: script5.sh
# ==============================
# Case
clear
echo "MENU"
echo "========="
echo "1 FCD"
echo "2 FADA"
echo "3 FED"
echo "4 FAD"
echo "5 FEM"
echo "6 FEI"
echo "7 FEB"
echo "8 FRPA"
echo "9 FLP"
echo "10 FML"
echo "11 FAE"
echo "12 FIAV"
echo "13 FSIB"
echo "S Sair"
echo "Digite o número da Formação que você está fazendo na DSA (ou S para sair e encerrar o script): "
read MENUCHOICE
case $MENUCHOICE in
 1)
  echo "Você escolheu a Formação Cientista de Dados. Parabéns!";;
 2)
  echo "Você escolheu a Formação Analista de Dados. Parabéns!";;
 3)
  echo "Você escolheu a Formação Engenheiro de Dados. Parabéns!";;
 4)
  echo "Você escolheu a Formação Arquiteto de Dados. Parabéns!";;
 5)
  echo "Você escolheu a Formação Engenheiro de Machine Learning. Parabéns!";;
 6)
  echo "Você escolheu a Formação Engenheiro de IA. Parabéns!";;
 7)
  echo "Você escolheu a Formação Engenheiro Blockchain. Parabéns!";;
 8)
  echo "Você escolheu a Formação Desenvolvedor RPA. Parabéns!";;
 9)
  echo "Você escolheu a Formação Linguagem Python Para Data Science. Parabéns!";;
 10)
  echo "Você escolheu a Formação Machine Learning. Parabéns!";;
 11)
  echo "Você escolheu a Formação Análise Estatística. Parabéns!";;
 12)
  echo "Você escolheu a Formação Inteligência Artificial Para Vendas. Parabéns!";;
 13)
  echo "Você escolheu a Formação Suporte e Infraestrutura de Big Data. Parabéns!";;
 S)
  echo "Você pediu para encerrar o script!";;
esac
