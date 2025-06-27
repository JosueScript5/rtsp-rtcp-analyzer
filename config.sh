#!/bin/bash

# Analyseur RTSP/RTCP - Fichier de Configuration
# Auteur : Chercheur en Sécurité
# Version : 1.0

# Couleurs
ROUGE='\033[0;31m'
VERT='\033[0;32m'
JAUNE='\033[1;33m'
BLEU='\033[0;34m'
VIOLET='\033[0;35m'
CYAN='\033[0;36m'
BLANC='\033[1;37m'
NC='\033[0m'

# Configuration par Défaut
TIMEOUT_DEFAUT=10
THREADS_DEFAUT=50
REPERTOIRE_SORTIE_DEFAUT="./resultats"
LISTE_MOTS_DEFAUT="./wordlists/flux_communs.txt"
AGENT_UTILISATEUR_DEFAUT="RTSP-Analyzer/1.0"

# Configuration Réseau
PORT_RTSP=554
PORT_RTCP=5005
PORT_HTTP=80
PORT_HTTPS=443

# Chemins RTSP Courants
CHEMINS_COURANTS=(
    "/live"
    "/stream"
    "/video"
    "/cam"
    "/camera"
    "/live.sdp"
    "/stream.sdp"
    "/video.sdp"
    "/h264"
    "/mjpeg"
    "/mpeg4"
    "/onvif"
    "/axis-media"
    "/MediaInput"
    "/streaming"
    "/rtsp"
    "/live/main"
    "/live/sub"
    "/ch01"
    "/ch02"
    "/channel1"
    "/channel2"
)

# Identifiants Courants
IDENTIFIANTS_COURANTS=(
    "admin:admin"
    "admin:password"
    "admin:123456"
    "admin:"
    "root:root"
    "root:password"
    "user:user"
    "guest:guest"
    "admin:admin123"
    "admin:12345"
    "service:service"
    "operator:operator"
    "viewer:viewer"
    "anonymous:anonymous"
    "test:test"
)

# Chemins des Fichiers
FICHIER_LOG="$REPERTOIRE_SORTIE_DEFAUT/analyseur.log"
FICHIER_RESULTATS="$REPERTOIRE_SORTIE_DEFAUT/resultats.txt"
FICHIER_RAPPORT="$REPERTOIRE_SORTIE_DEFAUT/rapport.html"

# Création des répertoires si inexistants
mkdir -p "$REPERTOIRE_SORTIE_DEFAUT"
mkdir -p "./wordlists"
mkdir -p "./modules"
mkdir -p "./logs"
