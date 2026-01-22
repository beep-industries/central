#!/bin/bash

# Script to copy .env.example files to .env in all subdirectories
# Usage: ./setup-env.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "======================================"
echo "  Setup Environment Files (.env)"
echo "======================================"
echo ""

# List of directories containing .env.example files
SERVICES=("authz" "client" "communities" "message" "real-time" "user")

# Counters
SUCCESS_COUNT=0
SKIP_COUNT=0
ERROR_COUNT=0

for service in "${SERVICES[@]}"; do
    ENV_EXAMPLE_FILE="${service}/.env.example"
    ENV_FILE="${service}/.env"

    # Check if .env.example file exists
    if [ -f "$ENV_EXAMPLE_FILE" ]; then
        # Check if .env already exists
        if [ -f "$ENV_FILE" ]; then
            echo -e "${YELLOW}⚠ ${service}/.env already exists, skipped${NC}"
            ((SKIP_COUNT++))
        else
            # Copy .env.example to .env
            cp "$ENV_EXAMPLE_FILE" "$ENV_FILE"
            echo -e "${GREEN}✓ ${service}/.env created successfully${NC}"
            ((SUCCESS_COUNT++))
        fi
    else
        echo -e "${RED}✗ ${service}/.env.example not found${NC}"
        ((ERROR_COUNT++))
    fi
done

echo ""
echo "======================================"
echo "  Summary"
echo "======================================"
echo -e "${GREEN}Created: ${SUCCESS_COUNT}${NC}"
echo -e "${YELLOW}Skipped: ${SKIP_COUNT}${NC}"
echo -e "${RED}Errors:  ${ERROR_COUNT}${NC}"
echo ""

if [ $SUCCESS_COUNT -gt 0 ]; then
    echo -e "${YELLOW}⚠ Don't forget to configure the values in the created .env files${NC}"
    echo ""
fi

echo "Done!"
