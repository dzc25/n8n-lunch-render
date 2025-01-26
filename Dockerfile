# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour pouvoir installer des paquets
USER root

# Ajouter les dépôts communautaires
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.16/community" >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache \
    libgpg-error \
    chromium \
    libstdc++ \
    nss \
    ca-certificates \
    ttf-freefont \
    libx11 \
    libxcomposite \
    libxdamage \
    alsa-lib && \
    echo "Chromium installé avec succès" && \
    chromium --version || echo "Erreur : Chromium non trouvé"


# Créer un répertoire pour les bibliothèques
WORKDIR /data/custom-libs

# Installer les dépendances Node.js nécessaires
RUN npm install cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1 \
    puppeteer-core \
    n8n-nodes-puppeteer

# Définir le NODE_PATH pour inclure les bibliothèques personnalisées
ENV NODE_PATH=/data/custom-libs/node_modules:$NODE_PATH

# Revenir à l'utilisateur n8n
USER n8n
