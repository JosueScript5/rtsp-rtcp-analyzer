#!/bin/bash

# Script de Démarrage de l'Analyseur RTSP/RTCP
# Auteur : Chercheur en Sécurité

# Vérification des privilèges root pour les opérations réseau
if [[ $EUID -eq 0 ]]; then
    echo "Attention : Exécution en tant que root. Certaines opérations réseau nécessitent des privilèges élevés."
fi

# Lancement de l'application
./welcome.sh
./main.sh
