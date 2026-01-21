#!/bin/bash

# Script pour copier les fichiers .env.example vers .env dans tous les sous-répertoires
# Usage: ./setup-env.sh

# Couleurs pour l'output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo "  Setup Environment Files (.env)"
echo "======================================"
echo ""

# Liste des répertoires contenant des fichiers .env.example
SERVICES=("authz" "client" "communities" "message" "real-time" "user")

# Compteurs
SUCCESS_COUNT=0
SKIP_COUNT=0
ERROR_COUNT=0

for service in "${SERVICES[@]}"; do
    ENV_EXAMPLE_FILE="${service}/.env.example"
    ENV_FILE="${service}/.env"
    
    # Vérifier si le fichier .env.example existe
    if [ -f "$ENV_EXAMPLE_FILE" ]; then
        # Vérifier si .env existe déjà
        if [ -f "$ENV_FILE" ]; then
            echo -e "${YELLOW}⚠ ${service}/.env existe déjà, ignoré${NC}"
            ((SKIP_COUNT++))
        else
            # Copier .env.example vers .env
            cp "$ENV_EXAMPLE_FILE" "$ENV_FILE"
            echo -e "${GREEN}✓ ${service}/.env créé avec succès${NC}"
            ((SUCCESS_COUNT++))
        fi
    else
        echo -e "${RED}✗ ${service}/.env.example introuvable${NC}"
        ((ERROR_COUNT++))
    fi
done

echo ""
echo "======================================"
echo "  Résumé"
echo "======================================"
echo -e "${GREEN}Créés:  ${SUCCESS_COUNT}${NC}"
echo -e "${YELLOW}Ignorés: ${SKIP_COUNT}${NC}"
echo -e "${RED}Erreurs: ${ERROR_COUNT}${NC}"
echo ""

if [ $SUCCESS_COUNT -gt 0 ]; then
    echo -e "${YELLOW}⚠ N'oubliez pas de configurer les valeurs dans les fichiers .env créés${NC}"
    echo ""
fi

echo "Terminé!"
