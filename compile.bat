@echo off
REM =============================================================================
REM Compile LaTeX document with bibliography (Windows CMD)
REM Requires: MiKTeX with pdflatex
REM =============================================================================
echo Compiling Spark Match article...
echo.
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
echo.
echo Compilation complete: main.pdf
pause