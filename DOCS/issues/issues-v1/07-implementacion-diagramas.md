# Issue 07 — Implementación: diagramas más detallados

**Rama:** `feat/report-update`
**Criterio rúbrica:** #4 — Implementación de la aplicación — **3 pts, actualmente ~2.25 (Logrado)**
**Prioridad:** Media
**Depende de:** Issue 01 (para reflejar el estado real de integración de cada componente)
**Archivo afectado:** `sections/04-implementation.tex`
**TODO existente:** línea 59 — *"agregar diagramas más detallados generados desde los repos (diagrama de flujo, diagrama de estados y user journey) en mermaid renderizado"*

## Contexto

Rúbrica, nivel Destacado (100%): *"Flujo documentado con diagrama y código funcional. Integración real entre LLM, API, base de datos e interfaz. Arquitectura modular y escalable verificable en el repositorio con pruebas de funcionamiento."* El diagrama TikZ actual es de alto nivel (componentes principales) y suficiente para "Logrado". Para "Destacado" falta mostrar el detalle del flujo (diagrama de secuencia/estados) y dejar más claro qué está "verificable con pruebas" vs. qué es scaffold.

## Tareas

- [ ] Agregar un diagrama de flujo/secuencia (puede ser TikZ o Mermaid renderizado a imagen) que muestre paso a paso la interacción: usuario → agente → extracción de preferencias → scoring → justificación → respuesta.
- [ ] Revisar la subsección 4.4 ("Backend serverless y frontend"): actualizar la descripción de "scaffolds" si Issue 01 confirma que alguno de los dos componentes ya tiene integración real, o mantenerla honesta si siguen siendo scaffold.
- [ ] Si hay pruebas automatizadas reales (unit tests del motor de scoring, tests del extractor), referenciarlas explícitamente aquí como evidencia de "verificable con pruebas de funcionamiento".
- [ ] Eliminar el `% TODO (equipo)` de la línea 59 una vez completado.

## Verificación

- [ ] El nuevo diagrama aporta un nivel de detalle distinto al diagrama de arquitectura general (no es una redundancia).
- [ ] La descripción de qué está integrado vs. qué es scaffold es consistente con lo confirmado en Issue 01.
- [ ] Recompilar el PDF: el/los diagramas se renderizan correctamente y no rompen el layout.
