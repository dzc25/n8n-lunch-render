# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances Node.js nécessaires
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1 \
    n8n-nodes-puppeteer
    
# Installer les dépendances système nécessaires pour Chromium
RUN apk update && \
    apk add --no-cache \
    libnss3 \
    libatk-bridge2.0-0 \
    libxss1 \
    libgdk-pixbuf2.0 \
    libx11 \
    libxcomposite \
    libxcursor \
    libxdamage \
    libxrandr \
    libxft \
    alsa-lib \
    ttf-freefont \
    && rm -rf /var/cache/apk/*

# Définir le NODE_PATH pour inclure les bibliothèques personnalisées
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH
