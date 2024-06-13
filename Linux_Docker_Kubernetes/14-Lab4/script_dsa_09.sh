#!/bin/bash
# ==============================
# Data Science Academy
# Script: script9.sh
# ==============================
# Auditoria de Segurança

# Atenção: Execute o comando abaixo no bash antes de executar este script:

# apt install net-tools

clear
echo "###############################################"
echo "###############################################"
echo "Relatório de Auditoria de Segurança no Linux."
echo "###############################################"
echo "###############################################"
echo "Vamos começar a auditoria em 3 segundos..."
sleep 3
echo
echo "Este é o nome da máquina: $HOSTNAME"
echo
echo "Começando a auditoria..."
START=$(date +%s)
echo
echo -e "\e[0;33m1. Detalhes do Kernel Linux\e[0m"
uname -a
echo
echo -e "\e[0;33m2. Versão desta Distribuição Linux\e[0m"
cat /etc/os-release | grep -e VERSION=
echo
echo -e "\e[0;33m3. Buscando arquivos com permissão 777\e[0m"
find / -type f -perm 0777;
echo
echo -e "\e[0;33m4. Conexões Ativas e Portas Abertas\e[0m"
netstat -natp
echo
echo -e "\e[0;33m5. Histórico de Comandos Executados\e[0m"
history
echo
echo -e "\e[0;33m6. Interfaces de Rede\e[0m"
ifconfig -a
echo
echo -e "\e[0;33m7. Lista de todos os pacotes instalados\e[0m"
apt-cache pkgnames
echo
echo -e "\e[0;33m8. Parâmetros de Rede\e[0m"
cat /etc/sysctl.conf
echo
echo -e "\e[0;33m9. Políticas de Senha\e[0m"
cat /etc/pam.d/common-password
echo
echo -e "\e[0;33m10. Source List\e[0m"
cat /etc/apt/sources.list
echo
echo -e "\e[0;33m11. Checando Dependências Quebradas\e[0m"
apt-get check
echo
echo -e "\e[0;33m12. Listando pacotes que podem ser atualizados\e[0m"
apt list --upgradeable
echo
echo -e "\e[0;33m13. Usuários com acesso ao SO\e[0m"
cut -d: -f1 /etc/passwd
echo
echo -e "\e[0;33m14. Checando Null Passwords\e[0m"
users="$(cut -d: -f 1 /etc/passwd)"
for x in $users
do
passwd -S $x |grep "NP"
done
echo
echo -e "\e[0;33m15. Informações da CPU e do Sistema\e[0m"
cat /proc/cpuinfo
echo
END=$(date +%s)
DIFF=$(( $END - $START ))
echo Auditoria concluída em $DIFF segundos!
echo
echo Data de geração do relatório:
date
echo
echo Parabéns por estar aprendendo Linux aqui na Data Science Academy!
echo

