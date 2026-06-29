#!/bin/bash
# ============================================================================
# watch.sh - Recompilacion automatica al detectar cambios (latexmk -pvc)
# ============================================================================
# Uso: ./scripts/watch.sh
# Requiere: latexmk
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

if ! command -v latexmk &> /dev/null; then
    echo "[ERROR] latexmk no encontrado. Instale TeX Live."
    exit 1
fi

echo "Modo watch: Ctrl+C para detener."
latexmk -pdf -interaction=nonstopmode -pvc main.tex