# RTSP-RTCP Analyzer


```
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
```

**Framework Avancé d'Analyse des Protocoles de Streaming en Temps Réel**

[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/user/rtsp-rtcp-analyzer)
[![Licence](https://img.shields.io/badge/licence-Éducationnelle-green.svg)](LICENSE)
[![Plateforme](https://img.shields.io/badge/plateforme-Linux-lightgrey.svg)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/shell-bash-orange.svg)](https://www.gnu.org/software/bash/)


## 📋 Table des Matières

- [Aperçu](#aperçu)
- [Fonctionnalités](#fonctionnalités)
- [Architecture](#architecture)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Modules](#modules)
- [Configuration](#configuration)
- [Exemples](#exemples)
- [Dépannage](#dépannage)
- [Contribution](#contribution)
- [Avertissement Légal](#avertissement-légal)
- [Licence](#licence)

## 🎯 Aperçu

**RTSP-RTCP Analyzer** est un outil de sécurité réseau complet conçu pour les testeurs de pénétration, les chercheurs en sécurité et les administrateurs réseau. Il fournit des capacités avancées pour découvrir, analyser et tester les implémentations du protocole RTSP (Real-Time Streaming Protocol) et RTCP (Real-Time Control Protocol).

### Capacités Principales

- **Découverte de Flux**: Détection automatisée des services RTSP sur les plages réseau
- **Analyse de Trafic**: Capture et analyse en temps réel des paquets RTCP
- **Tests d'Authentification**: Tests complets d'identifiants et techniques de contournement
- **Évaluation de Vulnérabilités**: Identification des failles de sécurité dans les implémentations de streaming
- **Surveillance Réseau**: Interception de trafic et détection de détournement de flux

## ✨ Fonctionnalités

### 🔍 Découverte et Énumération
- Découverte multi-threadée des services RTSP
- Scan de ports avec plages personnalisables
- Énumération des chemins communs
- Empreintage des services
- Cartographie de la topologie réseau

### 📊 Analyse de Trafic
- Capture de paquets RTCP en temps réel
- Dissection et analyse de protocole
- Rapports statistiques
- Surveillance de la bande passante
- Extraction des métriques de qualité

### 🔐 Tests de Sécurité
- Tests de contournement d'authentification
- Force brute d'identifiants
- Attaques par mots de passe communs
- Détection de détournement de session
- Analyse des faiblesses de chiffrement

### 📝 Rapports
- Rapports HTML détaillés
- Formats d'export JSON/XML
- Résumés exécutifs
- Résultats techniques
- Recommandations de remédiation

## 🏗️ Architecture

```
rtsp-rtcp-analyzer/
├── welcome.sh              # Point d'entrée de l'application
├── main.sh                 # Menu principal et navigation
├── config.sh               # Gestion de la configuration
├── utils.sh                # Fonctions utilitaires
├── install.sh              # Script d'installation
├── start.sh                # Script de démarrage
├── modules/                # Modules de fonctionnalités principales
│   ├── rtsp_discovery.sh   # Découverte des services RTSP
│   ├── rtcp_analyzer.sh    # Analyse du trafic RTCP
│   ├── auth_tester.sh      # Tests d'authentification
│   ├── stream_enum.sh      # Énumération des flux
│   ├── vuln_scanner.sh     # Scanner de vulnérabilités
│   ├── traffic_interceptor.sh # Interception de trafic
│   ├── report_generator.sh # Génération de rapports
│   └── config_manager.sh   # Interface de configuration
├── wordlists/              # Dictionnaires d'attaque
│   └── common_streams.txt  # Chemins RTSP communs
├── results/                # Répertoire de sortie
├── logs/                   # Fichiers de logs
└── README.md              # Documentation
```

## 🚀 Installation

### Prérequis

Assurez-vous que votre système répond aux exigences suivantes :

- **Système d'Exploitation**: Linux (Ubuntu 18.04+, Debian 9+, CentOS 7+)
- **Shell**: Bash 4.0+
- **Privilèges**: Accès root pour les opérations réseau
- **Réseau**: Interface réseau active

### Dépendances

L'outil nécessite les paquets suivants :

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install nmap curl netcat tcpdump ffmpeg jq

# CentOS/RHEL
sudo yum install nmap curl nc tcpdump ffmpeg jq

# Arch Linux
sudo pacman -S nmap curl netcat tcpdump ffmpeg jq
