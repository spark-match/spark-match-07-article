# Issue 11 — QA final y compilación

**Rama:** `feat/report-update`
**Criterio rúbrica:** Transversal — verificación de cierre de todos los criterios 1-12
**Prioridad:** Bloqueante final (no se entrega sin este paso)
**Depende de:** Issues 02-10 completados

## Contexto

Paso de cierre antes de generar el `TFP_XXX_YYY_ZZZ.docx`/PDF final para CANVAS. El objetivo es confirmar, con los criterios de `RUBRICA-PROGRAMA.md` en mano, que cada sección subió efectivamente de nivel y que no quedan placeholders, TODOs ni inconsistencias entre secciones.

## Tareas

- [ ] Compilar el PDF completo (`.\compile.ps1` en Windows o `scripts/build.sh`) y confirmar 0 errores/warnings críticos de LaTeX.
- [ ] Buscar residuos de placeholders en todo el árbol: `grep -rn "TODO\|\[definir\]\|por definir\|\[actualizar" sections/ main.tex` — debe devolver vacío o solo ítems conscientemente diferidos y documentados como tales.
- [ ] Releer el Resumen (`main.tex`, sección "Resumen"): confirmar longitud razonable (~250-350 palabras es la convención académica típica para un resumen de este tipo de trabajo) y que refleje el contenido final (por ejemplo, si Issue 09 cambia la decisión de RAG, el resumen debe seguir siendo consistente).
- [ ] Verificar que las 8 referencias en `references.bib` siguen citándose correctamente (`grep -rn "\\\\cite" sections/ main.tex`) y que el estilo `apalike` se ve correcto en el PDF (formato APA razonable, no solo BibTeX crudo).
- [ ] Releer cada sección contra su descriptor de nivel "Destacado" en `RUBRICA-PROGRAMA.md` y confirmar honestamente en qué nivel quedó cada una (usar la tabla del Issue 00-INDEX como checklist final).
- [ ] Confirmar consistencia cruzada de cifras entre secciones (ej. 6,208 combinaciones / 554 carreras / 25 departamentos debe ser igual en `02-model-data.tex`, `08-results.tex` y `09-conclusions.tex`).
- [ ] Confirmar que el nombre del archivo de entrega sigue la convención `TFP_XXX_YYY_ZZZ.docx` (o el equivalente PDF) usando los primeros apellidos de los integrantes, según `TFP-GUIDELINES.md` sección 8.
- [ ] Revisar que el repositorio comprimido/enlace a entregar en CANVAS incluye lo exigido: código fuente, `requirements.txt`/`Dockerfile`/`docker-compose.yml`/`README.md` (verificar en los repos correspondientes, no solo en el artículo).

## Verificación

- [ ] El PDF final compila sin intervención manual desde un checkout limpio de `feat/report-update`.
- [ ] Ninguna sección contiene placeholders sin resolver ni texto entre corchetes.
- [ ] La tabla de estimación de puntaje (Issue 00-INDEX) se actualizó con el resultado real tras cerrar 02-10, y el puntaje total estimado se documentó (informalmente, para el equipo) antes de la entrega.
- [ ] Todos los enlaces del documento (repos, demo, video) fueron probados manualmente y abren correctamente.
