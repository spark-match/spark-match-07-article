# Issue 03 — Evaluación con resultados reales

**Estado (2026-08-05): 🟡 Marco corregido y fortalecido; resultados medidos siguen pendientes.**
Al revisar el código real de `spark-match-08-deep-agent/evals/`, se encontró
que el informe tenía un **error factual, no solo una carencia**: decía que el
LLM-as-judge "se implementa del lado de AWS y queda pendiente hasta que el
agente esté desplegado". Eso es falso — `evals/runner.py --mode mock` ya
corre automáticamente en **cada pull request** (job `evals` en `ci.yml`),
sin LLM ni credenciales AWS, y `--mode live` invoca el agente en proceso sin
necesitar despliegue tampoco. Esto ya se corrigió en `07-evaluation.tex` con
un párrafo explícito de corrección. También se corrigió el conteo de casos:
no son "5-6 casos canónicos", son **29 casos reales** ya versionados en
`evals/dataset.jsonl`.

**Ajuste de alcance importante (dependencia del Issue 12):** la tarea
original de "calcular Recall@K" no tiene sentido ejecutarla todavía, porque
el ranking multicriterio completo **no existe en código** — solo la afinidad
RIASEC está integrada, sobre un catálogo piloto de 19 carreras. Recall@K
mide qué tan bien un ranking recupera los resultados relevantes; sin ranking
multicriterio no hay qué medir con esa métrica. El texto de
`07-evaluation.tex` ya se ajustó para reflejar esto explícitamente (ver
párrafo "Recuperación y ranking (diseño objetivo)").

Lo que **sigue pendiente** (obligatorio, no solo deseable — ver
`DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md` sección 1.3): correr
`evals/runner.py --mode live` (o el modo mock) y publicar al menos un
resultado real (tasa de acierto del código RIASEC, puntaje del LLM-as-judge,
latencia, costo por conversación) — hoy la sección documenta el marco pero
no tiene ni un solo número medido.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #7 — Evaluación de la aplicación — **2 pts, antes ~1.0 (En proceso), ahora el marco es sólido pero sigue sin resultados medidos**
**Prioridad:** Alta
**Depende de:** Issue 01, Issue 12 (define qué es medible hoy)
**Archivo afectado:** `sections/07-evaluation.tex`
**TODO existente:** línea 89 — *"completar la tabla comparativa (Recall@K, latencia, costo) con los resultados medidos"* (línea desplazada desde la 59 original; el TODO en sí sigue vigente, con Recall@K ya marcado como no aplicable todavía)

## Contexto

Rúbrica, nivel Destacado (100%): *"Métricas apropiadas implementadas... casos de prueba documentados con resultados reales. Comparación de al menos dos enfoques. Limitaciones documentadas."*

## Tareas

- [x] Corregir la afirmación falsa sobre la dependencia del despliegue — el eval ya corre hoy, automáticamente.
- [x] Corregir el conteo de casos de prueba (29 reales, no 5-6 ilustrativos).
- [x] Ajustar el alcance de Recall@K: documentado como no aplicable hasta que exista el ranking multicriterio (Issue 12).
- [ ] Ejecutar `evals/runner.py --mode live` (o `--mode mock`) sobre el dataset real de 29 casos y publicar al menos una cifra real: tasa de acierto del código RIASEC, puntaje del LLM-as-judge, latencia, costo por conversación.
- [ ] Para la justificación en lenguaje natural: complementar con evaluación humana mínima (Likert 1-5) sobre los casos ejecutados si el tiempo alcanza.
- [ ] Completar la tabla comparativa de enfoques (afinidad RIASEC integrada vs. pesos estáticos iguales) con las cifras que arroje la corrida real — el alcance de la comparación debe limitarse a lo que hoy es medible (ver nota de alcance arriba).
- [ ] Revisar y actualizar la sección "Limitaciones detectadas" si las pruebas revelan limitaciones nuevas no listadas.
- [ ] Eliminar el comentario `% TODO (equipo)` de la línea 89 una vez completado.

## Verificación

- [ ] La tabla comparativa tiene números reales, no placeholders ni "[definir]".
- [ ] Cada caso de prueba ejecutado queda trazable (comando exacto usado, referenciado en el texto).
- [x] El texto ya no afirma que el eval depende del despliegue del agente.
- [ ] Recompilar el PDF y confirmar que la tabla se renderiza correctamente.
