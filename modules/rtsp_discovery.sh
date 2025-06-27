#!/bin/bash

# Module de Découverte de Flux RTSP
# Auteur : Chercheur en Sécurité

source ../config.sh
source ../utils.sh

decouverte_rtsp() {
    afficher_entete "DÉCOUVERTE DE FLUX RTSP"
    
    echo -e "${JAUNE}[ENTRÉE]${NC} Entrez l'IP cible ou plage d'IP (ex : 192.168.1.1 ou 192.168.1.0/24):"
    read -r target
    
    echo -e "${JAUNE}[ENTRÉE]${NC} Entrez la plage de ports (défaut : 554,8554,8080,80,81,8081):"
    read -r ports
    ports=${ports:-"554,8554,8080,80,81,8081"}
    
    echo -e "${JAUNE}[ENTRÉE]${NC} Nombre de threads (défaut : 50):"
    read -r threads
    threads=${threads:-50}
    
    afficher_statut "INFO" "Lancement de la découverte RTSP sur $target"
    afficher_statut "INFO" "Ports : $ports | Threads : $threads"
    
    # Fichier temporaire pour les résultats
    local temp_file="/tmp/rtsp_decouverte_$$.tmp"
    
    # Scan Nmap pour les services RTSP
    afficher_statut "INFO" "Recherche des services RTSP..."
    nmap -sS -p "$ports" --script rtsp-url-brute,rtsp-methods "$target" -oG "$temp_file" 2>/dev/null
    
    # Analyse des résultats
    local found_hosts=()
    while IFS= read -r line; do
        if [[ $line == *"open"* ]]; then
            local host=$(echo "$line" | grep -oP '\d+\.\d+\.\d+\.\d+')
            local port=$(echo "$line" | grep -oP '\d+/open' | cut -d'/' -f1)
            found_hosts+=("$host:$port")
            afficher_statut "TROUVE" "Service RTSP détecté : $host:$port"
        fi
    done < "$temp_file"
    
    # Test des chemins RTSP courants
    if [ ${#found_hosts[@]} -gt 0 ]; then
        afficher_statut "INFO" "Test des chemins RTSP courants..."
        
        for host_port in "${found_hosts[@]}"; do
            local host=$(echo "$host_port" | cut -d':' -f1)
            local port=$(echo "$host_port" | cut -d':' -f2)
            
            afficher_statut "INFO" "Test des chemins sur $host:$port"
            
            for path in "${COMMON_PATHS[@]}"; do
                local rtsp_url="rtsp://$host:$port$path"
                
                # Test de l'URL RTSP
                timeout 5 curl -s --connect-timeout 3 -I "$rtsp_url" &>/dev/null
                if [ $? -eq 0 ]; then
                    afficher_statut "TROUVE" "Flux RTSP valide : $rtsp_url"
                    sauvegarder_resultat "FLUX_RTSP: $rtsp_url"
                    
                    # Tentative de récupération des infos du flux
                    ffprobe -v quiet -print_format json -show_streams "$rtsp_url" 2>/dev/null | \
                    jq -r '.streams[] | "Stream: \(.codec_type) - \(.codec_name) - \(.width)x\(.height)"' 2>/dev/null
                fi
            done
        done
    else
        afficher_statut "AVERTISSEMENT" "Aucun service RTSP trouvé sur la cible"
    fi
    
    # Nettoyage
    rm -f "$temp_file"
    
    echo ""
    echo -e "${VERT}[INFO]${NC} Découverte terminée. Résultats sauvegardés dans $RESULTS_FILE"
    echo -e "${JAUNE}Appuyez sur ENTREE pour retourner au menu principal...${NC}"
    read -r
}

# Exécution de la fonction
decouverte_rtsp
