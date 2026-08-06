# Issue 09 — Prompts: decidir tecnología de vector store (RAG)

**Rama:** `feat/report-update`
**Criterio rúbrica:** #3 — Ingeniería de prompts y adaptación — **2 pts, actualmente ~1.5 (Logrado)**
**Prioridad:** Baja (opcional para llegar a Destacado; no crítico si el tiempo apremia)
**Archivo afectado:** `sections/03-prompts.tex`

## Contexto

Rúbrica, nivel Destacado (100%): *"Integración de datos externos (base vectorial u otro) implementada **o justificada**."* Hoy el texto dice que la tecnología del vector store "queda por definir" y que se descartó `pgvector` — es una justificación parcial (dice qué NO se eligió, no qué SÍ se eligió ni por qué). Nivel Logrado (75%) ya está cubierto ("Base vectorial planificada"), así que este issue es para subir un nivel, no para no reprobar.

## Tareas

- [ ] Decidir la tecnología real de vector store si el equipo la definió en la bitácora de arquitectura mencionada en el texto (`ChromaDB` local, `pgvector` sobre Aurora, `Pinecone`, u otra).
- [ ] Si ya se decidió: documentar la elección con justificación breve (costo, integración con Aurora existente, simplicidad).
- [ ] Si NO se va a implementar antes de la entrega: mantener la sección como "trabajo futuro" pero agregar una justificación más completa (por qué no era prioritario para este alcance, qué se ganaría implementándolo) en vez de solo "queda por definir".

## Verificación

- [ ] La subsección "Flujo RAG" ya no dice literalmente "por definir" sin ningún criterio de decisión — o bien ya tiene tecnología elegida, o bien tiene una justificación explícita de por qué se pospuso.
- [ ] Si se implementó, hay al menos un ejemplo de consulta al vector store documentado (similar al ejemplo de la sección 8).
