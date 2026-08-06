# Issue 09 — Prompts: decidir tecnología de vector store (RAG)

**Estado (2026-08-05): ✅ Resuelto.** `sections/03-prompts.tex`, subsección
"Flujo RAG", ya no dice "por definir" ni "se descartó pgvector". El texto
actual documenta que **`pgvector` sobre RDS PostgreSQL es la dirección
planeada** (no descartada), citando que el propio código de
`search_careers` (en `spark-match-08-deep-agent`) documenta esa intención en
su docstring. Se explica también qué resuelve hoy (búsqueda por palabra
clave sobre el catálogo piloto) y qué falta (fecha de migración, aún no
definida en la bitácora de arquitectura del equipo). Esto es consistente con
la corrección equivalente ya aplicada en la Sección 10 (Recomendaciones).

Sigue sin implementarse (no hay ejemplo real de consulta al vector store),
pero el nivel "Destacado" de este criterio solo exige implementación **o**
justificación, y la justificación ya está.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #3 — Ingeniería de prompts y adaptación — **2 pts, antes ~1.5 (Logrado), ahora con justificación explícita hacia Destacado**
**Prioridad:** Baja — cerrado
**Archivo afectado:** `sections/03-prompts.tex`

## Contexto

Rúbrica, nivel Destacado (100%): *"Integración de datos externos (base vectorial u otro) implementada **o justificada**."*

## Tareas

- [x] Documentar la tecnología planeada (`pgvector` sobre RDS PostgreSQL) con justificación (ya está definida en el propio código, se integra con la infraestructura existente sin agregar un servicio nuevo).
- [x] Reemplazar el lenguaje de "se descartó pgvector" por "es la dirección planeada, no descartada", consistente con la Sección 10.
- [ ] Si se implementa antes de la entrega: agregar un ejemplo real de consulta al vector store (no bloqueante, mejora adicional).

## Verificación

- [x] La subsección "Flujo RAG" ya no dice literalmente "por definir" — tiene tecnología elegida y justificada.
- [ ] Si se implementó, hay al menos un ejemplo de consulta al vector store documentado (similar al ejemplo de la sección 8) — no implementado, no bloqueante.
