#!/bin/bash
# Script para iniciar a stack do TaskingAI

set -e  # Encerra o script se qualquer comando falhar

# Navega para o diretório docker
cd docker || { echo "Erro: Diretório docker não encontrado"; exit 1; }

# Para os containers existentes
echo "Parando containers existentes..."
docker compose -p taskingai down

# Ativa o BuildKit para melhorar o desempenho do build
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
# export COMPOSE_BAKE=true

# Faz o build de todos os serviços com nome específico para as imagens
echo "Construindo todos os serviços..."
docker compose -p taskingai --env-file .env build --progress=plain

# Inicia todos os serviços após o build
echo "Iniciando todos os serviços..."
docker compose -p taskingai --env-file .env up -d

echo "Stack do TaskingAI iniciada com sucesso!"