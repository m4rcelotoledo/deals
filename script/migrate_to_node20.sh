#!/bin/bash

# Exit on any error and undefined variables
set -euo pipefail

echo "🚀 Migrando para Node.js 20 LTS..."

# Remover dependências antigas
echo "📦 Removendo dependências antigas..."
rm -rf node_modules yarn.lock

# Remover webpacker do Gemfile se ainda estiver lá
if grep -q "webpacker" Gemfile; then
    echo "🔧 Removendo webpacker do Gemfile..."
    sed -i '/webpacker/d' Gemfile
fi

# Instalar novas dependências
echo "📦 Instalando novas dependências..."
bundle install
yarn install

# Verificar versão do Node.js
echo "🔍 Verificando versão do Node.js..."
node --version
yarn --version

# Compilar assets
echo "🎨 Verificando configuração do pipeline de assets..."
if [ -f "config/webpacker.yml" ]; then
    echo "❌ Erro: O arquivo config/webpacker.yml ainda existe. Remova-o para continuar."
    exit 1
fi
if ! grep -q "jsbundling-rails" Gemfile.lock && ! grep -q "importmap-rails" Gemfile.lock; then
    echo "❌ Erro: A aplicação não está configurada para o novo pipeline de assets. Certifique-se de usar jsbundling-rails ou importmap-rails."
    exit 1
fi
echo "🎨 Compilando assets..."
rails assets:precompile

echo "✅ Migração concluída! A aplicação está pronta para Node.js 20 LTS!"
echo "💡 Para testar, execute: rails server"
