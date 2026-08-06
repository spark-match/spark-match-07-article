# Issue 04 — Resultados y evidencia funcional

**Estado (2026-08-05): 🟡 Sección honesta y coherente con el resto del informe; sigue sin evidencia real (captura/ejecución).**
`08-results.tex` ya no presenta el ejemplo del caso Cusco como una ejecución
real: la subsección se renombró a *"Ejemplo de salida (caso canónico, diseño
objetivo)"* y trae un párrafo explícito aclarando que **no** es una captura
real, porque el extractor estructurado de región/presupuesto/pesos aún no
existe en el agente (consistente con la corrección del Issue 12 y con
`03-prompts.tex`/`07-evaluation.tex`). También se agregó un párrafo "Alcance
real del motor de scoring" al inicio de la sección con el mismo nivel de
honestidad que el resto del informe. Esto sube la calidad de lo que SÍ está
escrito, pero **no resuelve la brecha de evidencia** que exige la rúbrica
para "Destacado": la figura de la interfaz sigue comentada
(`% \includegraphics`) y no hay capturas reales de ejecución.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #8 — Resultados y demostración — **2 pts, actualmente ~1.0 (En proceso) — sin cambio de nivel hasta que haya evidencia real**
**Prioridad:** Alta — sigue siendo una de las dos brechas obligatorias más importantes (ver `DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md` sección 1.2)
**Depende de:** Issue 01
**Archivo afectado:** `sections/08-results.tex`
**TODO existente:** línea 102 — *"reemplazar por capturas reales de la app corriendo, el ranking Top-N de un caso real y el enlace a la demo/video"* (línea desplazada desde la 60 original, sigue vigente)

## Contexto

Rúbrica, nivel Destacado (100%): *"Ejemplos reales de respuestas del modelo documentados. Capturas funcionales de la API. Video demostrativo o enlace a demo."* Nivel "En proceso" (50%): *"solo mockup visual... sin evidencia funcional real"* — es exactamente donde sigue parado este criterio, aunque el texto que lo rodea ya es honesto y de mejor calidad.

## Tareas

- [ ] Ejecutar una conversación real contra el agente (sobre el alcance **actual**: afinidad RIASEC sobre el catálogo piloto de 19 carreras, no hace falta esperar a que se cierre el Issue 12) y capturar el JSON/ranking/justificación **tal como los produce el sistema**, no como ejemplo redactado a mano.
- [ ] Tomar captura de pantalla real de la interfaz conversacional (frontend Angular) y agregarla a `figures/`, referenciada en la `\figure` de la Fig.~\ref{fig:chat} (reemplazar el `% \includegraphics` comentado).
- [ ] Si corresponde, capturar también: terminal con el backend/agente corriendo, trazas de LangSmith, prueba de un endpoint.
- [ ] Actualizar la subsección "Evidencia funcional": reemplazar "enlace por definir tras el despliegue" con los enlaces reales (repos ya están bien, falta demo/video).
- [ ] Si NO hay demo en la nube desplegada para la fecha límite, decidir explícitamente y documentarlo así en el texto (ej. "demo ejecutada localmente, ver video") en vez de dejar el placeholder.
- [ ] Eliminar el `% TODO (equipo)` de la línea 102 una vez completado.

## Verificación

- [ ] La figura de la interfaz ya no está comentada — el PDF compilado la muestra.
- [ ] El JSON y el ranking mostrados provienen de una ejecución real y son reproducibles por el equipo evaluador si se les diera acceso.
- [ ] La subsección "Evidencia funcional" no contiene ningún placeholder tipo `[actualizar tras el despliegue]`.
- [ ] Coherencia con el video del Issue 02: la demo mostrada en el PDF y la del video deben corresponder al mismo sistema/versión.
