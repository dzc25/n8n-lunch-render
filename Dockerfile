# Utiliser l'image officielle de n8n comme base
FROM n8nio/n8n:latest

# Installer les bibliothèques additionnelles globalement
RUN npm install -g cheerio@^1.0.0 \
    node-fetch@^2.7.0 \
    puppeteer@^23.10.1

# Fix éventuel pour Puppeteer (installer des dépendances système si nécessaire)
RUN apt-get update && apt-get install -y \
    libnss3 libatk1.0-0 libx11-xcb1 libxcb-dri3-0 \
    libxcomposite1 libxrandr2 libxdamage1 \
    libxkbcommon0 libgbm1 libpango-1.0-0 libcairo2 \
    && rm -rf /var/lib/apt/lists/*

