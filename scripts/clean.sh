#!/bin/bash
# ============================================================================
# clean.sh - Limpia archivos auxiliares de LaTeX
# ============================================================================
# Uso: ./scripts/clean.sh
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "Limpiando archivos auxiliares..."

rm -f *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out
rm -f *.run.xml *.synctex.gz *.toc *.lof *.lot *.nav *.snm *.vrb
rm -f *.bcf *.idx *.ilg *.ind *.dvi *.ps
rm -f compile.log

echo "Limpieza completa."