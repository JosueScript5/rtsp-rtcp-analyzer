#!/bin/bash

# Analyseur RTSP/RTCP - Écran d'Accueil
# Auteur : Chercheur en Sécurité
# Version : 1.0

clear

# Couleurs pour l'affichage
ROUGE='\033[0;31m'
VERT='\033[0;32m'
JAUNE='\033[1;33m'
BLEU='\033[0;34m'
VIOLET='\033[0;35m'
CYAN='\033[0;36m'
BLANC='\033[1;37m'
NC='\033[0m' # Pas de couleur

# Bannière ASCII
echo -e "${ROUGE}"
cat << "EOF"
██████╗ ████████╗███████╗██████╗       ██████╗ ████████╗ ██████╗██████╗ 
██╔══██╗╚══██╔══╝██╔════╝██╔══██╗      ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
██████╔╝   ██║   ███████╗██████╔╝█████╗██████╔╝   ██║   ██║     ██████╔╝
██╔══██╗   ██║   ╚════██║██╔═══╝ ╚════╝██╔══██╗   ██║   ██║     ██╔═══╝ 
██║  ██║   ██║   ███████║██║           ██║  ██║   ██║   ╚██████╗██║     
╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝           ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝     
                                                                          
 █████╗ ███╗   ██╗ █████╗ ██╗  ██╗   ██╗███████╗███████╗██████╗          
██╔══██╗████╗  ██║██╔══██╗██║  ╚██╗ ██╔╝╚══███╔╝██╔════╝██╔══██╗         
███████║██╔██╗ ██║███████║██║   ╚████╔╝   ███╔╝ █████╗  ██████╔╝         
██╔══██║██║╚██╗██║██╔══██║██║    ╚██╔╝   ███╔╝  ██╔══╝  ██╔══██╗         
██║  ██║██║ ╚████║██║  ██║███████╗██║   ███████╗███████╗██║  ██║         
╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚══════╝╚══════╝╚═╝  ╚═╝         
EOF
echo -e "${NC}"

echo -e "${CYAN}================================================================${NC}"
echo -e "${BLANC}                 Analyseur de Protocole RTSP/RTCP v1.0${NC}"
echo -e "${CYAN}================================================================${NC}"
echo ""
echo -e "${JAUNE}[INFO]${NC} Outil avancé d'analyse des protocoles de streaming temps réel"
echo -e "${JAUNE}[INFO]${NC} Conçu pour les professionnels de sécurité et analystes réseau"
echo ""
echo -e "${VERT}Fonctionnalités :${NC}"
echo -e "  ${BLEU}•${NC} Découverte et énumération de flux RTSP"
echo -e "  ${BLEU}•${NC} Analyse et surveillance de paquets RTCP"
echo -e "  ${BLEU}•${NC} Tests de contournement d'authentification"
echo -e "  ${BLEU}•${NC} Détection de détournement de flux"
echo -e "  ${BLEU}•${NC} Interception de trafic réseau"
echo -e "  ${BLEU}•${NC} Évaluation des vulnérabilités"
echo ""
echo -e "${ROUGE}[AVERTISSEMENT]${NC} Cet outil est réservé aux tests autorisés !"
echo -e "${ROUGE}[AVERTISSEMENT]${NC} Assurez-vous d'avoir les autorisations nécessaires avant utilisation."
echo ""
echo -e "${VIOLET}Développé par : Équipe de Recherche en Sécurité${NC}"
echo -e "${VIOLET}Licence : Usage éducatif et professionnel uniquement${NC}"
echo ""
echo -e "${CYAN}================================================================${NC}"
echo ""
echo -e "${BLANC}Appuyez sur ENTREE pour accéder au menu principal...${NC}"
read -r
