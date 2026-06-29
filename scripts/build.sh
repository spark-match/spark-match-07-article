#!/bin/bash
# ============================================================================
# build.sh - Compila el articulo LaTeX a PDF
# ============================================================================
# Uso: ./scripts/build.sh
# Requiere: latexmk y pdflatex instalados
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=========================================="
echo "  Compilando articulo Spark Match"
echo "=========================================="
echo ""

cd "$PROJECT_DIR"

# Verificar que latexmk esta disponible
if command -v latexmk &> /dev/null; then
    echo "[INFO] Usando latexmk para compilacion..."
    latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
elif command -v pdflatex &> /dev/null; then
    echo "[INFO] latexmk no disponible. Usando pdflatex..."
    # Compilar multiples veces para resolver referencias
    pdflatex -interaction=nonstopmode -halt-on-error main.tex
    bibtex main || true
    pdflatex -interaction=nonstopmode -halt-on-error main.tex
    pdflatex -interaction=nonstopmode -halt-on-error main.tex
else
    echo "[ERROR] No se encontro latexmk ni pdflatex."
    echo "        Instale TeX Live: sudo apt-get install texlive-full"
    exit 1
fi

echo ""
echo "=========================================="
echo "  Compilacion exitosa: main.pdf"
echo "=========================================="