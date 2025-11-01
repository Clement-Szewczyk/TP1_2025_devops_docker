#!/bin/bash

# Construire l'image Docker
echo "Construction de l'image Docker..."
docker build -t broken-app -f 4-dev-app.dockerfile .

# Arrêter et supprimer le conteneur existant s'il existe
echo "Nettoyage du conteneur existant..."
docker stop broken-app-container 2>/dev/null || true
docker rm broken-app-container 2>/dev/null || true

# Exécuter le conteneur
echo "Démarrage du conteneur..."
docker run -d --name broken-app-container -p 3000:3000 broken-app

echo "Le conteneur fonctionne sur le port 3000."
