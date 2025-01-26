# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour installer les dépendances
USER root

# Installer les dépendances nécessaires pour Google Chrome
RUN apk update && \
    apk add --no-cache \
    wget \
    libx11 \
    libxcomposite \
    libxrandr \
    libxdamage \
    libxcb \
    libxi \
    fontconfig \
    freetype \
    ttf-freefont \
    libc6-compat \
    udev \
    nss \
    alsa-lib

# Télécharger et installer Google Chrome stable
RUN mkdir -p /opt/google/chrome && \
    wget -q -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    ar -x /tmp/google-chrome-stable_current_amd64.deb /opt/google/chrome && \
    rm /tmp/google-chrome-stable_current_amd64.deb && \
    echo "Google Chrome stable installé avec succès"

# Ajouter le chemin de Google Chrome au PATH
ENV PATH="${PATH}:/opt/google/chrome/opt/google/chrome"

# Créer un répertoire pour les bibliothèques personnalisées
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

