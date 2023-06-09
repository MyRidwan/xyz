#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : KytProject
# (C) Copyright 2023
# =========================================
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/usr/local/etc/xray/xtrojan.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "\033[0;34m╔===========================================╗\033[0m"
        echo -e "\e[0;35m     Delete XRAY Trojan TCP XTLS Account \033[0m"
        echo -e "\033[0;34m╚===========================================╝\033[0m"
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi
        echo -e "\033[0;34m╔===========================================╗\033[0m"
        echo -e "\e[0;35m     Delete XRAY Trojan TCP XTLS Account \033[0m"
        echo -e "\033[0;34m╚===========================================╝\033[0m"
	    echo " Select the existing client you want to remove"
	    echo " Press CTRL+C to return"
	    echo -e "\033[0;34m===========================================\033[0m"
	    echo "     No  Expired   User"
	    grep -E "^### " "/usr/local/etc/xray/xtrojan.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/usr/local/etc/xray/xtrojan.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/usr/local/etc/xray/xtrojan.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/xtrojan.json
rm -f /home/vps/public_html/$user-TRDIRECT.yaml /home/vps/public_html/$user-TRSPLICE.yaml
systemctl restart xray@xtrojan.service
clear
echo ""
echo " XRAY Trojan TCP XTLS Account Deleted"
echo -e "\033[0;34m===========================================\033[0m"
echo " Client Name : $user"
echo " Expired On  : $exp"
echo -e "\033[0;34m===========================================\033[0m"
echo ""
echo "Autoscript By KytProject"
