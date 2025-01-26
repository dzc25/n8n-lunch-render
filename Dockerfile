# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour les installations système
USER root

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
    nss \
    atk \
    cairo \
    pango \
    gtk+3.0 \
    alsa-lib \
    ttf-freefont \
    libx11 \
    libxcomposite \
    libxcursor \
    libxdamage \
    libxrandr \
    && rm -rf /var/cache/apk/*

# Définir le NODE_PATH pour inclure les bibliothèques personnalisées
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH

# Revenir à l'utilisateur par défaut
USER node
