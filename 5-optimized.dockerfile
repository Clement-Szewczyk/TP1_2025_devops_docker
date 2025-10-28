# Build project GO
FROM golang:1.21-alpine AS builder

# Définir le répertoire de travail
WORKDIR /build

# Copier les fichiers de dépendances et les télécharger
COPY go.mod go.sum* ./
RUN go mod download

# Copier le code source
COPY . .

# Compilation statique
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags="-w -s" -o app .


# Runtime minimaliste
FROM scratch

# Copier les certificats CA depuis alpine
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copier le binaire
COPY --from=builder /build/app /app

# Définir l'utilisateur non-root (UID 1000)
USER 1000:1000

# Exposer le port 8080
EXPOSE 8080

# Définir l'ENTRYPOINT
ENTRYPOINT ["/app"]