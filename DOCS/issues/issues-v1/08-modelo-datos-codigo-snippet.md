# Issue 08 — Modelo y datos: agregar snippet de código

**Rama:** `feat/report-update`
**Criterio rúbrica:** #2 — Selección de modelo y datos — **1 pt, actualmente ~0.75 (Logrado)**
**Prioridad:** Baja (mejora incremental, no bloqueante)
**Archivo afectado:** `sections/02-model-data.tex`

## Contexto

Rúbrica, nivel Destacado (100%): *"Preprocesamiento y embeddings descritos con lógica clara y **código adjunto**."* El preprocesamiento ya está muy bien descrito por etapas (`ingestion.py`, `data_clean.py`, `feature_engineering.py`) pero solo se nombran los módulos — no hay ningún bloque `lstlisting` en esta sección (la versión anterior en `dev` sí tenía uno de ejemplo con `dvc.api`). Es la brecha más pequeña de todo el informe: un solo snippet puede mover el criterio de Logrado a Destacado.

## Tareas

- [ ] Elegir el fragmento más representativo del pipeline real (por ejemplo, la imputación por etapas o la normalización Min-Max con log-transform descritas en el texto) desde `spark-match-05-data-pipeline`.
- [ ] Insertar un bloque `\begin{lstlisting}[style=pythonstyle, ...]` con ese fragmento real (no un ejemplo genérico) en la subsección "Preprocesamiento".
- [ ] Verificar que el snippet corresponde línea por línea al código real del repo (no una versión simplificada que ya no coincide).

## Verificación

- [ ] El snippet insertado es código real copiado de `spark-match-05-data-pipeline`, con referencia al archivo de origen en el caption.
- [ ] El PDF compila correctamente con el nuevo bloque de código (sin desbordes de página).
