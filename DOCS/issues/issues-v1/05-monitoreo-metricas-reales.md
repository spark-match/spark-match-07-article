# Issue 05 — Monitoreo con métricas reales

**Estado (2026-08-05): 🟡 Contenido corregido y mucho más rico; métricas medidas siguen pendientes.**
Se encontró y corrigió un dato **fabricado**: el informe mencionaba
"Weights & Biases (W&B)" como parte del stack de monitoreo, pero
`spark-match-06-model-training` (el repo donde debería vivir ese tracking)
está **vacío** — solo tiene archivos de gobernanza (`CODEOWNERS`,
`.gitignore`), sin una sola línea de código ni un run real de W&B o MLflow.
Se quitó W&B de `06-monitoring.tex`, del `README.md` y del Resumen de
`main.tex`, y se agregó un párrafo de corrección explicando qué existe
realmente (MLflow solo como dependencia opcional **comentada**, pendiente de
que MLflow soporte pandas 3.x — "Fase 4"). También se enriqueció
"Versionado de datos" con el detalle real del pipeline DVC (4 etapas, etapa
`ingest` congelada desde 2026-07-12 por la caída de *Ponte en Carrera*) y se
agregaron los pesos reales del rubric del LLM-as-judge y el tamaño real del
dataset de evals (29 casos) a la subsección de evaluación automática.

Lo que **sigue pendiente**: ninguna métrica de LangSmith ni de AWS
Budgets/Cost Explorer tiene todavía un valor numérico real — la sección
describe bien la instrumentación (que es real y está bien implementada,
`src/observability/langsmith.py`) pero no una sola cifra medida. Ver
`DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md` sección 1.3.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #6 — Monitoreo y mantenimiento — **2 pts, antes ~1.5, contenido más honesto y detallado pero aún sin métricas medidas**
**Prioridad:** Media
**Depende de:** Issue 01
**Archivo afectado:** `sections/06-monitoring.tex`, `README.md`, `main.tex`
**TODO existente:** línea 79 — *"completar los valores medidos de estas métricas tras las pruebas"* (línea desplazada desde la 58 original, sigue vigente)

## Contexto

Rúbrica, nivel Destacado (100%): *"Estrategia de monitoreo implementada... con métricas reales de desempeño en producción. Gestión de drift documentada con alertas configuradas. Logging funcional con ejemplos."*

## Tareas

- [x] Quitar W&B (fabricado) del stack de monitoreo y documentar qué existe realmente (MLflow planeado, no activo).
- [x] Documentar el pipeline DVC real (4 etapas) y el estado de la etapa `ingest` congelada.
- [x] Documentar los pesos reales y el tamaño del dataset del LLM-as-judge.
- [ ] Extraer de LangSmith al menos una métrica real: latencia promedio por conversación, tokens consumidos, tasa de éxito de invocaciones.
- [ ] Extraer de AWS Budgets/Cost Explorer el costo real acumulado del LLM y/o de la infraestructura (aunque sea de un período corto de pruebas).
- [ ] Añadir al menos un ejemplo concreto de log estructurado o traza (captura o extracto de LangSmith) como evidencia de "logging funcional con ejemplos".
- [ ] Revisar si ya existen alertas configuradas en AWS Budgets (umbral de gasto); si es así, documentarlas con el valor real del umbral.
- [ ] Eliminar el `% TODO (equipo)` de la línea 79 una vez completado.

## Verificación

- [ ] Al menos una métrica de la sección "Métricas de desempeño" tiene un valor numérico real, no solo la lista de qué se piensa medir.
- [ ] Hay evidencia (captura o cifra) de al menos una corrida real en LangSmith.
- [x] La gestión de drift sigue siendo honesta sobre su alcance actual (dataset congelado, motivo documentado) — no se exagera diciendo que hay alertas de drift si no existen.
- [ ] Recompilar el PDF y verificar que no queden placeholders sin resolver en la sección.
