# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour pouvoir installer des paquets
USER root

# Installer Chromium et ses dépendances nécessaires à Puppeteer
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    libx11 \
    libxcomposite \
    libxrandr \
    libxdamage \
    libatk \
    libcups \
    alsa-lib \
    libxtst \
    libpangocairo \
    pango \
    libcairo \
    gdk-pixbuf \
    glib

# Définir les variables d'environnement pour Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances Node.js nécessaires
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1 \
    n8n-nodes-puppeteer

# Définir le NODE_PATH pour inclure les bibliothèques personnalisées
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH

# Revenir à l'utilisateur n8n
USER n8n
