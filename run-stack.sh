#!/bin/bash
# Script para iniciar a stack do TaskingAI

set -e  # Encerra o script se qualquer comando falhar

# Navega para o diretório docker
cd docker || { echo "Erro: Diretório docker não encontrado"; exit 1; }

# Para os containers existentes
echo "Parando containers existentes..."
docker compose -p taskingai down

# Remove a imagem antiga do frontend para forçar rebuild com mais memória
echo "Removendo imagem antiga do frontend para reconstruir com mais memória..."
docker rmi -f taskingai-frontend 2>/dev/null || true

# Puxa as imagens mais recentes
echo "Atualizando imagens..."
docker compose -p taskingai pull

# Inicia os containers com maior limite de memória para Node.js
echo "Iniciando a stack do TaskingAI..."
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
docker compose -p taskingai --env-file .env up -d --build frontend

# Inicia o restante dos serviços
echo "Iniciando os demais serviços..."
docker compose -p taskingai --env-file .env up -d

echo "Stack do TaskingAI iniciada com sucesso!"