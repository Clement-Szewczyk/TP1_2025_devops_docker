# On utilise une image officielle de curl
FROM curlimages/curl:latest

# Créer un utilisateur non-root avec UID 1000
USER 1000:1000

# Définir le répertoire de travail
WORKDIR /home/curl_user

# Définir l'ENTRYPOINT pour toujours exécuter curl
ENTRYPOINT ["curl"]
