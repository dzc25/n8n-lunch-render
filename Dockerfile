# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Passer à l'utilisateur root pour pouvoir installer des paquets
USER root

# Installer Chromium et ses dépendances nécessaires
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    chromium \
    libgpg-error \
    libstdc++ \
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
    glib && \
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
