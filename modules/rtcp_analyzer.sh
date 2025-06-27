#!/bin/bash

# Module d'Analyse du Trafic RTCP
# Auteur : Chercheur en Sécurité

source ../config.sh
source ../utils.sh

analyseur_rtcp() {
    afficher_entete "ANALYSEUR DE TRAFIC RTCP"
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez l'interface réseau (ex : eth0, wlan0):"
    read -r interface
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez l'IP cible (optionnel, laisser vide pour tout le trafic):"
    read -r target_ip
    
    echo -e "${JAUNE}[ENTREE]${NC} Durée de capture en secondes (défaut : 60):"
    read -r duration
    duration=${duration:-60}
    
    # Vérification de l'interface
    if ! ip link show "$interface" &>/dev/null; then
        afficher_statut "ERREUR" "Interface $interface introuvable"
        return 1
    fi
    
    afficher_statut "INFO" "Démarrage de la capture RTCP sur $interface"
    afficher_statut "INFO" "Durée : ${duration}s | Cible : ${target_ip:-'TOUT'}"
    
    # Création des fichiers de capture
    local capture_file="/tmp/rtcp_capture_$$.pcap"
    local analysis_file="/tmp/rtcp_analyse_$$.txt"
    
    # Construction du filtre tcpdump
    local filter="udp and (port 5004 or port 5005 or portrange 5004-5007)"
    if [ -n "$target_ip" ]; then
        filter="$filter and host $target_ip"
    fi
    
    afficher_statut "INFO" "Filtre : $filter"
    
    # Démarrage de la capture
    afficher_statut "INFO" "Démarrage de la capture de paquets..."
    timeout "$duration" tcpdump -i "$interface" -w "$capture_file" "$filter" &>/dev/null &
    local tcpdump_pid=$!
    
    # Affichage de la progression
    for ((i=1; i<=duration; i++)); do
        afficher_progression $i $duration
        sleep 1
    done
    echo ""
    
    # Attente de la fin de tcpdump
    wait $tcpdump_pid 2>/dev/null
    
    if [ -f "$capture_file" ]; then
        afficher_statut "SUCCES" "Capture terminée : $capture_file"
        
        # Analyse des paquets capturés
        afficher_statut "INFO" "Analyse des paquets RTCP..."
        
        # Extraction des statistiques RTCP
        tcpdump -r "$capture_file" -nn 2>/dev/null | while read -r line; do
            if [[ $line == *"UDP"* ]]; then
                local timestamp=$(echo "$line" | awk '{print $1}')
                local src=$(echo "$line" | awk '{print $3}')
                local dst=$(echo "$line" | awk '{print $5}')
                local size=$(echo "$line" | grep -oP 'length \K\d+')
                
                echo "[$timestamp] $src -> $dst (${size:-0} octets)" >> "$analysis_file"
                afficher_statut "TROUVE" "Paquet RTCP : $src -> $dst"
            fi
        done
        
        # Génération des statistiques
        local total_packets=$(wc -l < "$analysis_file" 2>/dev/null || echo "0")
        local unique_sources=$(awk '{print $2}' "$analysis_file" 2>/dev/null | sort -u | wc -l)
        local unique_destinations=$(awk '{print $4}' "$analysis_file" 2>/dev/null | sort -u | wc -l)
        
        afficher_statut "INFO" "Résumé de l'analyse :"
        echo -e "  ${BLEU}•${NC} Paquets RTCP totaux : $total_packets"
        echo -e "  ${BLEU}•${NC} Sources uniques : $unique_sources"
        echo -e "  ${BLEU}•${NC} Destinations uniques : $unique_destinations"
        
        # Sauvegarde de l'analyse détaillée
        {
            echo "=== Rapport d'Analyse du Trafic RTCP ==="
            echo "Date : $(date)"
            echo "Interface : $interface"
            echo "Durée : ${duration}s"
            echo "Cible : ${target_ip:-'TOUT'}"
            echo ""
            echo "=== Statistiques ==="
            echo "Paquets totaux : $total_packets"
            echo "Sources uniques : $unique_sources"
            echo "Destinations uniques : $unique_destinations"
            echo ""
            echo "=== Détails des Paquets ==="
            cat "$analysis_file" 2>/dev/null
        } >> "$RESULTS_FILE"
        
        afficher_statut "SUCCES" "Analyse sauvegardée dans $RESULTS_FILE"
        
        # Nettoyage
        rm -f "$capture_file" "$analysis_file"
    else
        afficher_statut "ERREUR" "Aucun paquet capturé"
    fi
    
    echo ""
    echo -e "${JAUNE}Appuyez sur ENTREE pour retourner au menu principal...${NC}"
    read -r
}

# Exécution de la fonction
analyseur_rtcp
