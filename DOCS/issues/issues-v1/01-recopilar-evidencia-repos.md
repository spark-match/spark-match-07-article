# Issue 01 — Recopilar evidencia real de los repos del ecosistema

**Estado (2026-08-05): 🟡 Parcialmente resuelto.** Se hizo una revisión
exhaustiva del código real (no solo documentación) de todos los repos,
sección por sección del informe, y los hallazgos se aplicaron **directamente
en `sections/*.tex`** en vez de consolidarse en un archivo aparte
`_evidencia-recopilada.md` (se prefirió así porque cada hallazgo ya quedó
trazable en el propio texto del informe, con la fuente citada inline). Lo
que sigue sin confirmarse son específicamente los datos "en vivo" (URLs,
costos reales, capturas) que dependen de que alguien del equipo ejecute o
despliegue algo — eso no se puede verificar solo leyendo código.

**Confirmado con evidencia directa de código (aplicado en el informe):**
- `features.csv`: 6,208 filas / 554 carreras únicas / 25 departamentos — confirmado por conteo directo (`wc -l` + `csv.DictReader`).
- El agente corre en **ECS Fargate** detrás de ALB + CloudFront (no Bedrock AgentCore Runtime) — confirmado en `spark-match-02-infrastructure/modules/agent-service/main.tf` y el `Dockerfile` de `spark-match-08-deep-agent`.
- El agente **sí expone FastAPI/uvicorn** (`/ag-ui`, `/health`) — antes el informe decía lo contrario.
- El backend Lambda se empaqueta como **ZIP vía esbuild**, no como imagen de contenedor — confirmado en `template.yaml`.
- El frontend llama **directamente** al backend y al agente (sin proxy) — confirmado en el ADR-012 de `spark-match-03-backend`.
- `spark-match-06-model-training` está **vacío** (solo gobernanza) — no hay ningún run de W&B ni de MLflow real; MLflow solo existe como dependencia opcional comentada en `spark-match-05-data-pipeline/pyproject.toml`.
- El pipeline DVC (`dvc.yaml`) tiene 4 etapas reales; la etapa `ingest` está `frozen` desde 2026-07-12 porque el portal *Ponte en Carrera* devuelve HTTP 500.
- El framework de LLM-as-judge (`evals/`) corre automáticamente en cada PR en modo `mock` (confirmado en `ci.yml` de `spark-match-08-deep-agent`); tiene 29 casos reales en `evals/dataset.jsonl`.
- Los workflows de SonarCloud, CodeQL, checkov, tflint, gitleaks **existen y están wireados** en `spark-match-01-devops` y se invocan desde los repos — confirmado por grep directo de los workflows reutilizables.
- El motor de scoring de 5 criterios **no está integrado**: solo afinidad RIASEC opera, sobre un catálogo piloto de 19 carreras (no sobre `features.csv`) — ver Issue 12.

**Aún no confirmado (requiere acción del equipo, no solo lectura de código):**
- Si `terraform apply` ya corrió contra `dev`/`prod`, o los recursos solo están definidos.
- URL real de API Gateway del backend o del agente (ALB/CloudFront) si ya hay un despliegue vivo.
- Costo real acumulado en AWS Budgets/Cost Explorer.
- Si los workflows de CI ya corrieron exitosamente al menos una vez (verificamos que existen y están bien configurados, no el historial de runs en GitHub Actions).
- Capturas reales de LangSmith (confirmamos que la instrumentación está bien implementada en `src/observability/langsmith.py`, no que haya trazas capturables ya generadas).

Estos puntos pendientes son exactamente los que documenta
`DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md` como brechas
obligatorias de evidencia (no de redacción).

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
