# Issues v1 — Cierre del informe Spark Match para entrega final

**Rama de trabajo:** `feat/report-update` exclusivamente. No se toca `main` ni `dev`.
**Base de la revisión:** `DOCS/RUBRICA-PROGRAMA.md` y `DOCS/TFP-GUIDELINES.md`.
**Fecha de entrega final:** domingo 09/08/2026, 13:00 hrs.
**Puntaje estimado actual:** ~13-13.5 / 20 (ver revisión previa). Objetivo: maximizar puntaje cerrando los TODOs reales que quedan en `sections/*.tex`.

## Orden de ejecución recomendado

El orden importa: los issues 02-06 (llenar TODOs con datos reales) dependen de que el issue 01 recopile evidencia real de los otros repos del ecosistema. No redactar contenido "de relleno" — si un repo no tiene aún la evidencia, el issue debe quedar documentado como bloqueado, no inventado.

| # | Issue | Criterio rúbrica | Pts en juego | Prioridad | Depende de |
|---|---|---|---|---|---|
| 01 | [Recopilar evidencia real de los repos](01-recopilar-evidencia-repos.md) | Transversal | — | **Bloqueante** | — |
| 02 | [Video de exposición](02-video-exposicion.md) | 12 | 2.0 | **Alta** | 01 |
| 03 | [Evaluación con resultados reales](03-evaluacion-resultados-reales.md) | 7 | 2.0 | **Alta** | 01 |
| 04 | [Resultados y evidencia funcional](04-resultados-demo-evidencia.md) | 8 | 2.0 | **Alta** | 01 |
| 05 | [Monitoreo con métricas reales](05-monitoreo-metricas-reales.md) | 6 | 2.0 | Media | 01 |
| 06 | [Despliegue: URL de demo y costos](06-despliegue-demo-costos.md) | 5 | 2.0 | Media | 01 |
| 07 | [Implementación: diagramas detallados](07-implementacion-diagramas.md) | 4 | 3.0 (refuerzo) | Media | 01 |
| 08 | [Modelo y datos: snippet de código](08-modelo-datos-codigo-snippet.md) | 2 | 1.0 (refuerzo) | Baja | — |
| 09 | [Prompts: definir tecnología RAG](09-prompts-rag-vectorstore.md) | 3 | 2.0 (refuerzo) | Baja | — |
| 10 | [Portada: completar docente](10-portada-docente.md) | Administrativo | — | Alta (rápido) | — |
| 11 | [QA final y compilación](11-qa-compilacion-final.md) | Transversal | — | **Bloqueante final** | 02-10 |

## Cómo usar cada issue

Cada archivo sigue la misma estructura: Contexto → Tareas → Verificación. Marca los checkboxes a medida que avanzas y no des un issue por cerrado sin completar su sección de Verificación — esa sección es la que confirma que el cambio realmente sube el nivel del criterio en la rúbrica (no basta con "escribir más texto").

## Reglas transversales para todos los issues

- Todo commit va a `feat/report-update`. Nunca a `main` ni `dev`.
- Ningún dato "ilustrativo" se presenta como real. Si no hay evidencia (captura, log, métrica) todavía, el texto debe decirlo explícitamente (como ya hace el borrador actual) en vez de inventar cifras.
- Cada issue cerrado debe recompilar el PDF (`.\compile.ps1` o `scripts/build.sh`) sin errores antes de marcarse como listo.
- Al cerrar todos los issues 01-10, ejecutar el issue 11 como paso final obligatorio.
