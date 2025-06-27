#!/bin/bash

# Analyseur RTSP/RTCP - Fonctions Utilitaires
# Auteur : Chercheur en Sécurité
# Version : 1.0

# Afficher un en-tête formaté
afficher_entete() {
    local titre="$1"
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${BLANC}                    $titre${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo ""
}

# Afficher un message de statut
afficher_statut() {
    local statut="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    case $statut in
        "INFO")
            echo -e "${BLEU}[$timestamp] [INFO]${NC} $message"
            ;;
        "SUCCES")
            echo -e "${VERT}[$timestamp] [SUCCES]${NC} $message"
            ;;
        "AVERTISSEMENT")
            echo -e "${JAUNE}[$timestamp] [AVERTISSEMENT]${NC} $message"
            ;;
        "ERREUR")
            echo -e "${ROUGE}[$timestamp] [ERREUR]${NC} $message"
            ;;
        "TROUVE")
            echo -e "${VIOLET}[$timestamp] [TROUVE]${NC} $message"
            ;;
    esac
    
    # Journaliser dans le fichier
    echo "[$timestamp] [$statut] $message" >> "$FICHIER_LOG"
}

# Vérifier les outils requis
verifier_dependances() {
    local deps=("nmap" "curl" "nc" "tcpdump" "ffmpeg")
    local manquants=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            manquants+=("$dep")
        fi
    done
    
    if [ ${#manquants[@]} -ne 0 ]; then
        afficher_statut "AVERTISSEMENT" "Dépendances manquantes : ${manquants[*]}"
        echo -e "${JAUNE}[INFO]${NC} Installer les outils manquants avec :"
        echo -e "${BLANC}sudo apt-get install ${manquants[*]}${NC}"
        echo ""
        echo -e "${JAUNE}Continuer quand même ? (y/N) : ${NC}"
        read -r choix_continuation
        if [[ ! $choix_continuation =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Valider une adresse IP
valider_ip() {
    local ip="$1"
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Valider une plage de ports
valider_port() {
    local port="$1"
    if [[ $port =~ ^[0-9]+$ ]] && [ "$port" -ge 1 ] && [ "$port" -le 65535 ]; then
        return 0
    else
        return 1
    fi
}

# Générer un user agent aléatoire
obtenir_user_agent_aleatoire() {
    local agents=(
        "VLC media player"
        "FFmpeg/4.0"
        "GStreamer/1.0"
        "QuickTime/7.6"
        "RealPlayer/12.0"
        "Windows Media Player/12.0"
        "RTSP-Client/1.0"
        "IP Camera Viewer"
    )
    echo "${agents[$RANDOM % ${#agents[@]}]}"
}

# Afficher une barre de progression
afficher_progression() {
    local actuel="$1"
    local total="$2"
    local largeur=50
    local pourcentage=$((actuel * 100 / total))
    local complete=$((actuel * largeur / total))
    local restante=$((largeur - complete))
    
    printf "\r${BLEU}[INFO]${NC} Progression : ["
    printf "%*s" $complete | tr ' ' '='
    printf "%*s" $restante | tr ' ' '-'
    printf "] %d%% (%d/%d)" $pourcentage $actuel $total
}

# Sauvegarder les résultats dans un fichier
sauvegarder_resultat() {
    local resultat="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $resultat" >> "$FICHIER_RESULTATS"
}

# Nettoyer les fichiers temporaires
nettoyage() {
    afficher_statut "INFO" "Nettoyage des fichiers temporaires..."
    rm -f /tmp/rtsp_*.tmp
    rm -f /tmp/rtcp_*.tmp
}

# Configurer le nettoyage à la sortie
trap nettoyage EXIT
