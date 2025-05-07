#!/bin/bash
# Script para iniciar a stack do TaskingAI

set -e  # Encerra o script se qualquer comando falhar

# Navega para o diretório docker
cd docker || { echo "Erro: Diretório docker não encontrado"; exit 1; }

# Para os containers existentes
echo "Parando containers existentes..."
docker-compose -p taskingai down

# Puxa as imagens mais recentes
echo "Atualizando imagens..."
docker-compose -p taskingai pull

# Inicia os containers
echo "Iniciando a stack do TaskingAI..."
docker-compose -p taskingai --env-file .env up -d

echo "Stack do TaskingAI iniciada com sucesso!"