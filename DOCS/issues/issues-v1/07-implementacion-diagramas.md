# Issue 07 — Implementación: diagramas más detallados

**Estado (2026-08-05): ✅ Resuelto.** Se agregaron 7 diagramas Mermaid
(fuente en `figures/mermaid/*.mmd`, renderizados a PNG con
`@mermaid-js/mermaid-cli` vía `npx`, sin intervención manual) e insertados en
el PDF. El TODO de la línea 59 ya no existe.

- `01-secuencia-conversacion.mmd` → Fig. en Sección 4 (landscape): pedido
  explícito de "diagrama de flujo/secuencia".
- `04-estados-agente.mmd` → Fig. en Sección 4: pedido explícito de "diagrama
  de estados".
- `06-user-journey.mmd` → Fig. en Sección 1: pedido explícito de "user
  journey".
- `02-pipeline-datos.mmd`, `03-arquitectura-despliegue-aws.mmd`,
  `05-cicd-pipeline.mmd` → figuras adicionales en Secciones 2 y 5 que no
  pedía el issue original pero llenan huecos reales (esas secciones no tenían
  ninguna figura).
- `07-arquitectura-logica.mmd` → **reemplaza** el diagrama TikZ original
  (`fig:architecture`). Ese TikZ dibujaba `UI → Backend → Agent` como cadena
  lineal, lo cual **no era coherente**: contradecía tanto el ADR-012 de
  `spark-match-03-backend` ("frontend llama a ambos directamente, no hay
  proxy") como el propio párrafo introductorio de la Sección 4. El nuevo
  diagrama muestra las dos conexiones directas reales (frontend→backend para
  auth/CRUD, frontend→agente para `/ag-ui` con el mismo JWT) y mantiene el
  marcado en rojo de `features.csv` como no conectado aún.

Todos los diagramas usan el mismo código de color (verde = implementado,
rojo punteado = pendiente/diseño objetivo) para ser consistentes con el resto
del informe. Dos de ellos (secuencia y CI/CD) van en página landscape
(`\usepackage{pdflscape}`, agregado a `config/preamble.tex`) por ser
demasiado anchos para una página vertical.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #4 — Implementación de la aplicación — **3 pts, antes ~2.25 (Logrado), ahora con evidencia visual más cercana a Destacado**
**Prioridad:** Media — cerrado
**Depende de:** Issue 01 (para reflejar el estado real de integración de cada componente)
**Archivo afectado:** `sections/01-use-case.tex`, `sections/02-model-data.tex`, `sections/04-implementation.tex`, `sections/05-orchestration.tex`, `figures/mermaid/`
**TODO existente:** ~~línea 59 — "agregar diagramas más detallados generados desde los repos (diagrama de flujo, diagrama de estados y user journey) en mermaid renderizado"~~ eliminado.

## Contexto

Rúbrica, nivel Destacado (100%): *"Flujo documentado con diagrama y código funcional. Integración real entre LLM, API, base de datos e interfaz. Arquitectura modular y escalable verificable en el repositorio con pruebas de funcionamiento."* El diagrama TikZ actual es de alto nivel (componentes principales) y suficiente para "Logrado". Para "Destacado" falta mostrar el detalle del flujo (diagrama de secuencia/estados) y dejar más claro qué está "verificable con pruebas" vs. qué es scaffold.

## Tareas

- [x] Agregar un diagrama de flujo/secuencia (Mermaid renderizado a imagen) que muestre paso a paso la interacción: usuario → agente → extracción de preferencias → scoring → justificación → respuesta.
- [ ] Revisar la subsección 4.4 ("Backend serverless y frontend"): actualizar la descripción de "scaffolds" si Issue 01 confirma que alguno de los dos componentes ya tiene integración real, o mantenerla honesta si siguen siendo scaffold. *(Ya se corrigió el frontend a "módulos funcionales reales, pendientes de integrarse" en la Sección 8; falta revisar si la Sección 4 usa exactamente la misma redacción.)*
- [ ] Si hay pruebas automatizadas reales (unit tests del motor de scoring, tests del extractor), referenciarlas explícitamente aquí como evidencia de "verificable con pruebas de funcionamiento". *(No abordado en esta pasada — pendiente.)*
- [x] Eliminar el `% TODO (equipo)` de la línea 59.

## Verificación

- [x] El nuevo diagrama aporta un nivel de detalle distinto al diagrama de arquitectura general (no es una redundancia) — de hecho el diagrama de arquitectura general mismo fue reemplazado por estar desactualizado (ver nota arriba).
- [ ] La descripción de qué está integrado vs. qué es scaffold es consistente con lo confirmado en Issue 01 — pendiente de una pasada final de consistencia (Issue 11).
- [x] Recompilado el PDF: los 7 diagramas se renderizan correctamente (36 páginas, 0 errores, 0 referencias indefinidas), sin overfull hbox en las figuras.
