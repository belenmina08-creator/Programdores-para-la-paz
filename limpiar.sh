#!/bin/bash

set -e

echo "🚀 Iniciando limpieza..."

# Eliminar únicamente los archivos de la raíz
rm -rf ./node_modules
rm -f ./package.json
rm -f ./package-lock.json

# Crear .gitignore si no existe
touch .gitignore

# Añadir regla si no existe
if ! grep -q "^node_modules/" .gitignore; then
    echo "node_modules/" >> .gitignore
fi

echo "🔍 Eliminando node_modules del tracking de Git..."

find . -type d -name "node_modules" | while read -r dir; do
    git rm -r --cached "$dir" 2>/dev/null || true
done

git add .gitignore
git add -A

if ! git diff --cached --quiet; then
    git commit -m "gitignore añadido"
fi

echo "✅ Terminado"