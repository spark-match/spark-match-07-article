# Issue 04 — Resultados y evidencia funcional

**Rama:** `feat/report-update`
**Criterio rúbrica:** #8 — Resultados y demostración — **2 pts, actualmente ~1.0 (En proceso)**
**Prioridad:** Alta
**Depende de:** Issue 01
**Archivo afectado:** `sections/08-results.tex`
**TODO existente:** línea 60 — *"reemplazar por capturas reales de la app corriendo, el ranking Top-N de un caso real y el enlace a la demo/video"*

## Contexto

Rúbrica, nivel Destacado (100%): *"Ejemplos reales de respuestas del modelo documentados. Capturas funcionales de la API. Video demostrativo o enlace a demo."* Hoy hay un ejemplo bien armado (caso Cusco) pero es ilustrativo, y la figura de captura está comentada (`% \includegraphics`) con la leyenda *"por incluir"*. Sin capturas reales, cae en "En proceso" (50%): *"solo mockup visual... sin evidencia funcional real"*.

## Tareas

- [ ] Ejecutar el caso canónico de Cusco (u otro real) contra el sistema realmente corriendo (local si no hay demo desplegada aún) y capturar el JSON de preferencias, el ranking Top-N y la justificación **tal como los produce el sistema**, no como ejemplo redactado a mano.
- [ ] Tomar captura de pantalla real de la interfaz conversacional (frontend Angular) y agregarla a `figures/`, referenciada en la `\figure` de la línea 54-59 (reemplazar el `% \includegraphics` comentado).
- [ ] Si corresponde, capturar también: terminal con el backend/agente corriendo, trazas de LangSmith, prueba de un endpoint (Postman/Swagger si el backend serverless expone alguno vía API Gateway).
- [ ] Actualizar la subsección "Evidencia funcional": reemplazar "enlace por definir tras el despliegue" con los enlaces reales (repos ya están bien, falta demo/video).
- [ ] Si NO hay demo en la nube desplegada para la fecha límite, decidir explícitamente y documentarlo así en el texto (ej. "demo ejecutada localmente, ver video") en vez de dejar el placeholder.
- [ ] Eliminar el `% TODO (equipo)` de la línea 60 una vez completado.

## Verificación

- [ ] La figura de la interfaz ya no está comentada — el PDF compilado la muestra.
- [ ] El JSON y el ranking mostrados provienen de una ejecución real y son reproducibles por el equipo evaluador si se les diera acceso.
- [ ] La subsección "Evidencia funcional" no contiene ningún placeholder tipo `[actualizar tras el despliegue]`.
- [ ] Coherencia con el video del Issue 02: la demo mostrada en el PDF y la del video deben corresponder al mismo sistema/versión.
