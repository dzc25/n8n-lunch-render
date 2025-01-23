# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Installer les dépendances requises pour Puppeteer
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libx11-6 \
    libxcomposite1 \
    libxrandr2 \
    libatk1.0-0 \
    libcups2 \
    libnspr4 \
    libgdk-pixbuf2.0-0 \
    libdbus-1-3 \
    libxtst6 \
    libatk-bridge2.0-0 \
    libasound2 \
    libdconf1 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0

# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances dans ce répertoire
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1

# Définir correctement le NODE_PATH pour inclure le dossier personnalisé
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH
