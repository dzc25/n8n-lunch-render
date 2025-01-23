# Utiliser une image de base pour n8n
FROM n8nio/n8n:latest

# Installer les bibliothèques additionnelles
RUN npm install -g cheerio@^1.0.0 node-fetch@^2.7.0 puppeteer@^23.10.1
