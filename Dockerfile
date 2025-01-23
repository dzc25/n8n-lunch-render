# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances dans ce répertoire
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1

# Définir correctement le NODE_PATH pour inclure le dossier personnalisé
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH

