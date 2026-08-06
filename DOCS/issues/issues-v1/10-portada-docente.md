# Issue 10 — Portada: completar nombre del docente

**Estado (2026-08-05): ⬜ Sin resolver.** `main.tex:29` sigue con
`[Nombre del Docente]`. Nota aparte: esta sesión se corrigió un bug de
layout no relacionado en la misma portada — el bloque de la carátula se
desbordaba a una segunda página, dejando "Lima, Perú — 2026" huérfano en la
página 2 (se ajustaron los espacios verticales fijos para que todo quepa en
la página 1). Sigue siendo trivial de cerrar: solo falta el nombre real.

**Rama:** `feat/report-update`
**Criterio rúbrica:** Administrativo (no puntúa directamente, pero es un placeholder visible en la primera página)
**Prioridad:** Alta (trivial de resolver, alto impacto visual si se olvida)
**Archivo afectado:** `main.tex` línea 29

## Contexto

La portada ya tiene a los 5 integrantes reales (Fabiola Tapara Quispe, Angel Hincho Jove, Andy Huamani Tacoma, Nikolai Asencios García, David Barreto Lara), pero el campo `\textbf{Docente:} & [Nombre del Docente]` sigue como placeholder.

## Tareas

- [ ] Confirmar el nombre completo del docente del II Programa de Especialización en IA Generativa y MLOps.
- [ ] Reemplazar `[Nombre del Docente]` en `main.tex:29`.

## Verificación

- [ ] La portada compilada ya no muestra corchetes ni placeholders.
- [ ] El nombre coincide con el registro oficial del programa (evitar errores de tipeo en un documento formal de entrega).
