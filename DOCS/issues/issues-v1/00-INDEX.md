# Issues v1 — Cierre del informe Spark Match para entrega final

**Rama de trabajo:** `feat/report-update` exclusivamente. No se toca `main` ni `dev`.
**Base de la revisión:** `DOCS/RUBRICA-PROGRAMA.md` y `DOCS/TFP-GUIDELINES.md`.
**Fecha de entrega final:** domingo 09/08/2026, 13:00 hrs.
**Puntaje estimado actual:** ~13 / 20 hoy, ~16-17 / 20 si se cierran las
brechas obligatorias restantes. Ver el desglose completo, criterio por
criterio, en **`DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md`**
(reemplaza a esta línea como fuente de verdad del puntaje — se actualiza con
más detalle que este índice).

## Estado consolidado (actualización 2026-08-05, segunda pasada)

Se completó una revisión sección por sección (1 a 10) del informe contra el
código real de los 9 repos del ecosistema, más allá del alcance original de
estos issues. Resultado:

- **Cerrados esta sesión:** issue 07 (diagramas Mermaid, incluyendo el
  reemplazo de un diagrama de arquitectura que resultó estar mal — dibujaba
  un flujo `UI → Backend → Agent` que contradice el ADR-012 del backend) e
  issue 09 (tecnología RAG ya justificada: `pgvector` sobre RDS, dirección
  planeada, no descartada).
- **Avanzados pero no cerrados:** issues 01, 03, 04, 05, 06 — el contenido
  ya no tiene errores factuales (se corrigieron varios: W&B fabricado,
  despliegue en Bedrock AgentCore inexistente, backend empaquetado como
  contenedor inexistente, LLM-as-judge presentado como dependiente del
  despliegue cuando no lo es) y es mucho más rico y honesto, pero la
  **evidencia real** que cada uno pide (URLs, costos, capturas, métricas
  medidas) sigue sin existir porque requiere ejecutar/desplegar el sistema,
  no solo escribir mejor.
- **Sin tocar:** issues 02 (video), 08 (snippet de código), 10 (nombre del
  docente), 11 (QA final, bloqueado por los anteriores).
- **Issue 12** sigue siendo la brecha de mayor impacto: el reencuadre
  honesto ("Camino 2") ya se extendió a las 10 secciones del informe, pero
  la decisión de si cerrar la brecha en código ("Camino 1") sigue sin
  tomarse.

## Orden de ejecución recomendado

El orden importa: los issues 02-06 (llenar TODOs con datos reales) dependen de que el issue 01 recopile evidencia real de los otros repos del ecosistema, y el issue 01 a su vez debe partir del alcance real que fija el issue 12. No redactar contenido "de relleno" — si un repo no tiene aún la evidencia, el issue debe quedar documentado como bloqueado, no inventado.

| # | Issue | Criterio rúbrica | Pts en juego | Prioridad | Estado | Depende de |
|---|---|---|---|---|---|---|
| 12 | [Brecha crítica: motor de scoring no integrado](12-brecha-motor-scoring-real.md) | 4 (y transversal 1,2,7,8) | 3.0 | **Bloqueante — máxima** | 🟡 Camino 2 aplicado, Camino 1 pendiente de decisión | — |
| 01 | [Recopilar evidencia real de los repos](01-recopilar-evidencia-repos.md) | Transversal | — | **Bloqueante** | 🟡 Evidencia de código aplicada; falta evidencia "en vivo" | 12 |
| 02 | [Video de exposición](02-video-exposicion.md) | 12 | 2.0 | **Alta** | ⬜ Sin resolver (logística, no código) | 01, 03, 04 |
| 03 | [Evaluación con resultados reales](03-evaluacion-resultados-reales.md) | 7 | 2.0 | **Alta** | 🟡 Marco corregido, faltan resultados medidos | 01, 12 |
| 04 | [Resultados y evidencia funcional](04-resultados-demo-evidencia.md) | 8 | 2.0 | **Alta** | 🟡 Texto honesto, falta evidencia real | 01 |
| 05 | [Monitoreo con métricas reales](05-monitoreo-metricas-reales.md) | 6 | 2.0 | Media | 🟡 Contenido corregido, faltan métricas medidas | 01 |
| 06 | [Despliegue: URL de demo y costos](06-despliegue-demo-costos.md) | 5 | 2.0 | Media | 🟡 Arquitectura corregida, falta URL/costos | 01 |
| 07 | [Implementación: diagramas detallados](07-implementacion-diagramas.md) | 4 | 3.0 (refuerzo) | Media | ✅ Resuelto | 01 |
| 08 | [Modelo y datos: snippet de código](08-modelo-datos-codigo-snippet.md) | 2 | 1.0 (refuerzo) | Baja | ⬜ Sin resolver | — |
| 09 | [Prompts: definir tecnología RAG](09-prompts-rag-vectorstore.md) | 3 | 2.0 (refuerzo) | Baja | ✅ Resuelto | — |
| 10 | [Portada: completar docente](10-portada-docente.md) | Administrativo | — | Alta (rápido) | ⬜ Sin resolver | — |
| 11 | [QA final y compilación](11-qa-compilacion-final.md) | Transversal | — | **Bloqueante final** | 🟡 Compilación limpia, bloqueado por 02-10 | 02-10 |

## Cómo usar cada issue

Cada archivo sigue la misma estructura: Contexto → Tareas → Verificación. Marca los checkboxes a medida que avanzas y no des un issue por cerrado sin completar su sección de Verificación — esa sección es la que confirma que el cambio realmente sube el nivel del criterio en la rúbrica (no basta con "escribir más texto").

## Reglas transversales para todos los issues

- Todo commit va a `feat/report-update`. Nunca a `main` ni `dev`.
- Ningún dato "ilustrativo" se presenta como real. Si no hay evidencia (captura, log, métrica) todavía, el texto debe decirlo explícitamente (como ya hace el borrador actual) en vez de inventar cifras.
- Cada issue cerrado debe recompilar el PDF (`.\compile.ps1` o `scripts/build.sh`) sin errores antes de marcarse como listo.
- Al cerrar todos los issues 01-10, ejecutar el issue 11 como paso final obligatorio.
