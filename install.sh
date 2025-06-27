#!/bin/bash

# Script d'Installation de l'Analyseur RTSP/RTCP
# Auteur : Chercheur en Sécurité

echo "Installation de l'Analyseur RTSP-RTCP en cours..."

# Rendre tous les scripts exécutables
chmod +x *.sh
chmod +x modules/*.sh

# Créer les répertoires nécessaires
mkdir -p results
mkdir -p logs
mkdir -p wordlists

# Créer la liste des flux courants
cat > wordlists/common_streams.txt << 'EOF'
/live
/stream
/video
/cam
/camera
/live.sdp
/stream.sdp
/video.sdp
/h264
/mjpeg
/mpeg4
/onvif
/axis-media
/MediaInput
/streaming
/rtsp
/live/main
/live/sub
/ch01
/ch02
/channel1
/channel2
/user=admin&password=&channel=1&stream=0.sdp
/user=admin&password=admin&channel=1&stream=0.sdp
EOF

# Vérifier et installer les dépendances
echo "Vérification des dépendances..."
deps=("nmap" "curl" "nc" "tcpdump" "ffmpeg" "jq")
missing=()

for dep in "${deps[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        missing+=("$dep")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo "Dépendances manquantes : ${missing[*]}"
    echo "Installer avec : sudo apt-get install ${missing[*]}"
fi

echo "Installation terminée !"
echo "Lancer : ./welcome.sh pour démarrer l'outil"
