# Issue 01 — Recopilar evidencia real de los repos del ecosistema

**Rama:** `feat/report-update`
**Criterio rúbrica:** Transversal (bloquea 02, 03, 04, 05, 06)
**Prioridad:** Bloqueante
**Repos a inspeccionar:** `spark-match-03-backend`, `spark-match-04-frontend`, `spark-match-05-data-pipeline`, `spark-match-06-model-training`, `spark-match-08-deep-agent`, `spark-match-02-infrastructure`, `spark-match-01-devops`

## Contexto

Los TODOs que quedan en `sections/*.tex` (05, 06, 07, 08) piden "valores medidos", "capturas reales", "URL de demo" y "costos reales". Antes de redactar una sola línea hay que confirmar **qué de eso ya existe de verdad** en el código/infra de los otros repos, y qué todavía no. Escribir el issue de contenido sin este paso previo arriesga inventar datos que no se sostienen si alguien pide verlos en la exposición.

## Tareas

- [ ] Revisar `spark-match-05-data-pipeline`: confirmar que `features.csv` existe, tiene 6,208 filas / 554 carreras únicas / 25 departamentos (cifras citadas en `02-model-data.tex` y `08-results.tex`). Si difieren, anotar las cifras reales actuales.
- [ ] Revisar `spark-match-08-deep-agent`: confirmar si el agente (`deepagents` + `langmem` + `ChatBedrock`) corre localmente o desplegado, y si hay trazas reales en LangSmith capturables como captura de pantalla.
- [ ] Revisar `spark-match-03-backend`: confirmar si el backend serverless (TS + SAM) tiene un despliegue real en `dev` (URL de API Gateway) o sigue siendo scaffold sin desplegar.
- [ ] Revisar `spark-match-04-frontend`: confirmar si hay una build corriendo (local o desplegada) de la que se pueda capturar pantalla de una conversación real.
- [ ] Revisar `spark-match-02-infrastructure`: confirmar qué recursos Terraform están efectivamente aplicados (`terraform apply` ejecutado) vs. solo definidos, y si hay costos reales visibles en AWS Budgets/Cost Explorer.
- [ ] Revisar `spark-match-06-model-training` y el etiquetado RIASEC: confirmar si hay un run de W&B o MLflow con métricas reales registradas.
- [ ] Revisar `spark-match-01-devops`: confirmar el estado real de los workflows (SonarCloud, CodeQL, checkov, tflint) — si corrieron exitosamente al menos una vez.
- [ ] Consolidar hallazgos en una tabla simple (puede ser un comentario en este mismo archivo o un nuevo `DOCS/issues/issues-v1/_evidencia-recopilada.md`): por cada repo, qué evidencia real existe y dónde (link/commit/ruta), y qué sigue pendiente.

## Verificación

- [ ] Cada afirmación que se vaya a usar en 02-06 tiene una fuente verificable (commit, log, captura, URL) — no "se asume que funciona".
- [ ] Las cifras del dataset (6,208 / 554 / 25) están confirmadas contra el CSV real, no solo copiadas del borrador anterior.
- [ ] Queda explícito qué partes NO tienen evidencia real todavía (para que los issues 02-06 sepan qué secciones deben mantenerse honestas sobre limitaciones, en vez de forzar contenido).
