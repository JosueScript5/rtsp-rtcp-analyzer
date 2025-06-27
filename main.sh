#!/bin/bash

# Analyseur RTSP/RTCP - Menu Principal
# Auteur : Chercheur en Sécurité
# Version : 1.0

source ./config.sh
source ./utils.sh

# Fonction du Menu Principal
afficher_menu_principal() {
    clear
    afficher_entete "MENU PRINCIPAL"
    
    echo -e "${VERT}[1]${NC} Découverte de Flux RTSP"
    echo -e "${VERT}[2]${NC} Analyse du Trafic RTCP"
    echo -e "${VERT}[3]${NC} Tests d'Authentification"
    echo -e "${VERT}[4]${NC} Énumération des Flux"
    echo -e "${VERT}[5]${NC} Scan de Vulnérabilités"
    echo -e "${VERT}[6]${NC} Interception du Trafic"
    echo -e "${VERT}[7]${NC} Générateur de Rapport"
    echo -e "${VERT}[8]${NC} Configuration"
    echo -e "${ROUGE}[9]${NC} Quitter"
    echo ""
    echo -e "${CYAN}================================================================${NC}"
    echo -n -e "${JAUNE}Choisissez une option [1-9]: ${NC}"
}

# Boucle principale
main() {
    # Vérification des dépendances
    verifier_dependances
    
    while true; do
        afficher_menu_principal
        read -r choix
        
        case $choix in
            1)
                echo -e "${BLEU}[INFO]${NC} Lancement de la Découverte de Flux RTSP..."
                ./modules/rtsp_discovery.sh
                ;;
            2)
                echo -e "${BLEU}[INFO]${NC} Démarrage de l'Analyseur de Trafic RTCP..."
                ./modules/rtcp_analyzer.sh
                ;;
            3)
                echo -e "${BLEU}[INFO]${NC} Initialisation des Tests d'Authentification..."
                ./modules/auth_tester.sh
                ;;
            4)
                echo -e "${BLEU}[INFO]${NC} Début de l'Énumération des Flux..."
                ./modules/stream_enum.sh
                ;;
            5)
                echo -e "${BLEU}[INFO]${NC} Exécution du Scan de Vulnérabilités..."
                ./modules/vuln_scanner.sh
                ;;
            6)
                echo -e "${BLEU}[INFO]${NC} Démarrage de l'Intercepteur de Trafic..."
                ./modules/traffic_interceptor.sh
                ;;
            7)
                echo -e "${BLEU}[INFO]${NC} Génération du Rapport d'Analyse..."
                ./modules/report_generator.sh
                ;;
            8)
                echo -e "${BLEU}[INFO]${NC} Ouverture de la Configuration..."
                ./modules/config_manager.sh
                ;;
            9)
                echo -e "${VERT}[INFO]${NC} Fermeture de l'Analyseur RTSP-RTCP..."
                echo -e "${JAUNE}[INFO]${NC} Merci d'avoir utilisé notre outil !"
                exit 0
                ;;
            *)
                echo -e "${ROUGE}[ERREUR]${NC} Option invalide. Veuillez choisir entre 1 et 9."
                sleep 2
                ;;
        esac
    done
}

# Exécution de la fonction principale
main "$@"
