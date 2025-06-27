#!/bin/bash

# Module de Test d'Authentification
# Auteur : Chercheur en Sécurité

source ../config.sh
source ../utils.sh

testeur_auth() {
    afficher_entete "TESTEUR D'AUTHENTIFICATION RTSP"
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez l'URL RTSP (ex : rtsp://192.168.1.100:554/live):"
    read -r rtsp_url
    
    if [[ ! $rtsp_url =~ ^rtsp:// ]]; then
        afficher_statut "ERREUR" "Format d'URL RTSP invalide"
        return 1
    fi
    
    echo -e "${JAUNE}[ENTREE]${NC} Type de test :"
    echo -e "  ${VERT}[1]${NC} Identifiants courants"
    echo -e "  ${VERT}[2]${NC} Liste personnalisée"
    echo -e "  ${VERT}[3]${NC} Test avec un seul identifiant"
    echo -n -e "${JAUNE}Choisissez [1-3]: ${NC}"
    read -r test_type
    
    afficher_statut "INFO" "Début du test d'authentification sur $rtsp_url"
    
    case $test_type in
        1)
            tester_identifiants_courants "$rtsp_url"
            ;;
        2)
            tester_liste_personnalisee "$rtsp_url"
            ;;
        3)
            tester_identifiant_unique "$rtsp_url"
            ;;
        *)
            afficher_statut "ERREUR" "Type de test invalide"
            return 1
            ;;
    esac
}

tester_identifiants_courants() {
    local url="$1"
    local host=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f1)
    local port=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f2)
    port=${port:-554}
    
    afficher_statut "INFO" "Test des identifiants courants..."
    
    local succes_count=0
    local total_count=${#CREDENTIALS_COURANTS[@]}
    
    for i in "${!CREDENTIALS_COURANTS[@]}"; do
        local cred="${CREDENTIALS_COURANTS[$i]}"
        local username=$(echo "$cred" | cut -d':' -f1)
        local password=$(echo "$cred" | cut -d':' -f2)
        
        afficher_progression $((i+1)) $total_count
        
        # Test d'authentification
        local auth_url="rtsp://$username:$password@$host:$port$(echo "$url" | sed "s|rtsp://$host:$port||")"
        
        if tester_auth_rtsp "$auth_url"; then
            echo ""
            afficher_statut "TROUVE" "Identifiants valides : $username:$password"
            sauvegarder_resultat "AUTH_REUSSI: $auth_url"
            ((succes_count++))
        fi
        
        sleep 0.1  # Limitation du débit
    done
    
    echo ""
    afficher_statut "INFO" "Test d'authentification terminé"
    afficher_statut "INFO" "Connexions réussies : $succes_count/$total_count"
}

tester_liste_personnalisee() {
    local url="$1"
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez le chemin de la liste d'utilisateurs :"
    read -r user_wordlist
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez le chemin de la liste de mots de passe :"
    read -r pass_wordlist
    
    if [[ ! -f "$user_wordlist" ]] || [[ ! -f "$pass_wordlist" ]]; then
        afficher_statut "ERREUR" "Fichiers de liste introuvables"
        return 1
    fi
    
    local host=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f1)
    local port=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f2)
    port=${port:-554}
    
    afficher_statut "INFO" "Test des identifiants depuis les listes..."
    
    local succes_count=0
    local tentative_count=0
    
    while IFS= read -r username; do
        while IFS= read -r password; do
            ((tentative_count++))
            
            local auth_url="rtsp://$username:$password@$host:$port$(echo "$url" | sed "s|rtsp://$host:$port||")"
            
            if tester_auth_rtsp "$auth_url"; then
                afficher_statut "TROUVE" "Identifiants valides : $username:$password"
                sauvegarder_resultat "AUTH_REUSSI: $auth_url"
                ((succes_count++))
            fi
            
            if ((tentative_count % 10 == 0)); then
                afficher_statut "INFO" "$tentative_count combinaisons testées..."
            fi
            
            sleep 0.1
        done < "$pass_wordlist"
    done < "$user_wordlist"
    
    afficher_statut "INFO" "Test par liste terminé"
    afficher_statut "INFO" "Connexions réussies : $succes_count/$tentative_count"
}

tester_identifiant_unique() {
    local url="$1"
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez le nom d'utilisateur :"
    read -r username
    
    echo -e "${JAUNE}[ENTREE]${NC} Entrez le mot de passe :"
    read -s password
    echo ""
    
    local host=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f1)
    local port=$(echo "$url" | sed 's|rtsp://||' | cut -d'/' -f1 | cut -d':' -f2)
    port=${port:-554}
    
    local auth_url="rtsp://$username:$password@$host:$port$(echo "$url" | sed "s|rtsp://$host:$port||")"
    
    afficher_statut "INFO" "Test des identifiants : $username:***"
    
    if tester_auth_rtsp "$auth_url"; then
        afficher_statut "SUCCES" "Authentification réussie !"
        sauvegarder_resultat "AUTH_REUSSI: $username:$password @ $url"
    else
        afficher_statut "ERREUR" "Échec de l'authentification"
    fi
}

tester_auth_rtsp() {
    local url="$1"
    
    # Utilisation de curl pour tester l'authentification RTSP
    timeout 5 curl -s --connect-timeout 3 -I "$url" &>/dev/null
    return $?
}

# Exécuter la fonction
testeur_auth

echo ""
echo -e "${JAUNE}Appuyez sur ENTREE pour retourner au menu principal...${NC}"
read -r
