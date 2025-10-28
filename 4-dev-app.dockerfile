FROM node:18-alpine

WORKDIR /app

# Copier les fichiers de dépendances
COPY broken-app/package*.json ./

# Installer les dépendances
RUN npm install

# Copier le code source
COPY broken-app/ .

# Changer le propriétaire des fichiers vers l'utilisateur avec UID 1000
RUN chown -R 1000:1000 /app

# Passer à l'utilisateur non-root
USER 1000:1000

# Exposer le port 3000
EXPOSE 3000

# Démarrer l'application
CMD ["npm", "start"]