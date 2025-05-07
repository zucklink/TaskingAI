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

# Ativa o BuildKit para melhorar o desempenho do build
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export COMPOSE_BAKE=true

# Faz o build de todos os serviços, utilizando cache quando disponível
echo "Construindo todos os serviços..."
docker compose -p taskingai --env-file .env build --progress=plain

# Inicia todos os serviços após o build
echo "Iniciando todos os serviços..."
docker compose -p taskingai --env-file .env up -d

echo "Stack do TaskingAI iniciada com sucesso!"