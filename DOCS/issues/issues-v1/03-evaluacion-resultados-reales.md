# Issue 03 — Evaluación con resultados reales

**Rama:** `feat/report-update`
**Criterio rúbrica:** #7 — Evaluación de la aplicación — **2 pts, actualmente ~1.0 (En proceso)**
**Prioridad:** Alta
**Depende de:** Issue 01
**Archivo afectado:** `sections/07-evaluation.tex`
**TODO existente:** línea 59 — *"completar la tabla comparativa (Recall@K, latencia, costo) con los resultados medidos"*

## Contexto

Rúbrica, nivel Destacado (100%): *"Métricas apropiadas implementadas... casos de prueba documentados con resultados reales. Comparación de al menos dos enfoques. Limitaciones documentadas."* El marco conceptual ya está bien definido (Recall@K, F1 del extractor, LLM-as-judge), pero el texto mismo admite: *"los valores medidos se completarán con las pruebas finales"*. Sin resultados reales, la rúbrica lo clasifica como "En proceso" (50%) sin importar cuán bien redactado esté el marco.

## Tareas

- [ ] Ejecutar los 5-6 casos canónicos mencionados en `07-evaluation.tex` (el de Cusco de la sección 8 y al menos 4-5 más cubriendo distintas regiones/presupuestos/prioridades).
- [ ] Para el motor de scoring: calcular Recall@K / relevancia real contra el conjunto de casos de referencia.
- [ ] Para el extractor de preferencias: medir tasa de JSON malformado y exactitud de campos (región, presupuesto, pesos, RIASEC) sobre los mensajes de prueba reales.
- [ ] Para la justificación en lenguaje natural: si el LLM-as-judge todavía no está desplegado (según Issue 01), documentar al menos una evaluación humana mínima (Likert 1-5) sobre los casos ejecutados, en vez de dejarlo vacío.
- [ ] Completar la tabla comparativa de enfoques (pesos dinámicos LLM vs. pesos estáticos iguales vs. un solo criterio) con cifras reales de Recall@K, latencia y costo por consulta.
- [ ] Revisar y actualizar la sección "Limitaciones detectadas" si las pruebas revelan limitaciones nuevas no listadas.
- [ ] Eliminar el comentario `% TODO (equipo)` de la línea 59 una vez completado.

## Verificación

- [ ] La tabla comparativa tiene números reales, no placeholders ni "[definir]".
- [ ] Cada caso de prueba ejecutado queda trazable (script o notebook usado, en el repo `data-pipeline` o `deep-agent`, referenciado en el texto).
- [ ] Se comparan como mínimo dos enfoques (rúbrica lo exige explícitamente para Destacado).
- [ ] El texto ya no dice "se completará con las pruebas finales" — o si algo queda pendiente, se listó como limitación explícita, no como promesa vaga.
- [ ] Recompilar el PDF y confirmar que la tabla se renderiza correctamente.
