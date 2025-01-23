# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour installer les paquets nécessaires
USER root

# Mettre à jour l'index des paquets et installer bash
RUN apk update && apk add --no-cache bash

# Installer les dépendances requises pour Puppeteer
RUN apk add --no-cache \
    libglib2.0 \
    nss \
    x11-libs \
    libxcomposite \
    libxrandr \
    at-spi2-atk \
    cups-libs \
    nspr \
    gdk-pixbuf \
    dbus \
    libxtst \
    atk-bridge \
    alsa-lib \
    dconf \
    gtk+3.0

# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances dans ce répertoire
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1

# Définir correctement le NODE_PATH pour inclure le dossier personnalisé
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH

# Revenir à l'utilisateur n8n pour la suite des opérations
USER n8n

