# Pre-evaluación 2 — Proyección de nota (Spark Match / CareerMatch Perú)

**Fecha de esta evaluación:** 2026-08-08, ~20:55 (hora Perú)
**Ramas evaluadas:** `main` de los 9 repos (la rama que un evaluador clonaría por defecto), contrastada explícitamente contra `dev` donde hay diferencias de contenido reales.
**Entrega final:** domingo 2026-08-09, 13:00 hrs — **quedan ~16 horas**.
**Base:** `DOCS/RUBRICA-PROGRAMA.md` (12 criterios, 20 pts) + verificación directa del código actual (post fast-forward de `main` en los 9 repos, post merge de `feat/report-update`) mediante 4 investigaciones paralelas sobre: el motor del agente (`08-deep-agent`), backend/frontend, infraestructura/despliegue, y el contenido íntegro de las 10 secciones del informe LaTeX. Esta pre-evaluación reemplaza a `1ra-proyeccion-evaluacion.md` (2026-08-05) como fuente de verdad vigente, pero no la borra: sirve para medir qué avanzó en estos 3 días.

## Cómo leer este documento

Igual que la pre-evaluación anterior, cada hallazgo distingue **lo que dice/muestra el informe** de **lo que existe realmente en el código verificable**. Esta vez apareció una tercera categoría que no existía el 05/08 y que es el hallazgo más importante de todo este documento: **lo que existe en `dev` pero no en `main`**. Un evaluador que clona el repositorio (el flujo estándar de entrega, "repositorio comprimido o enlace a GitHub") va a ver `main` por defecto, salvo que el equipo indique explícitamente otra rama. Todo lo que hoy vive solo en `dev` es, a efectos prácticos de la nota, **invisible**.

---

## 0. Hallazgo transversal más urgente: `main` está desincronizado de `dev`, y en `08-deep-agent` la brecha es severa

Este hallazgo no existía como tal en la pre-evaluación del 05/08 (en ese momento se evaluó explícitamente la rama `feat/report-update`, no se comparó `main` contra `dev` de los otros 8 repos). Al revisar hoy `main` de los 9 repos se encontró que **4 repos tienen contenido real en `dev` que no está en `main`**, medido con diff de contenido (dos puntos, tip a tip, no ancestría — el mismo método que reveló el falso positivo de `feat/report-update` el 05/08):

| Repo | Diff de contenido `main` vs `origin/dev` | Severidad |
|---|---|---|
| `03-backend` | 2 archivos (changelog/manifest de versión, cosmético) | Ninguna — sincronizado |
| `02-infrastructure` | 1 archivo, 21 líneas (`terraform.tfvars` de dev) | Ninguna — sincronizado |
| `04-frontend` | **44 archivos, 2150 líneas** (chat, reportes, filtros, sidebar admin, regiones) | **Moderada** |
| `08-deep-agent` | **137 archivos, ~19 900 líneas** | **Crítica** |

### El caso `08-deep-agent` es el que más nota puede costar hoy

`main` de `08-deep-agent` sigue en el commit `82bf13b` (2026-08-04, "sprint 5 — correcciones críticas B1-B10", que fue *solo* saneamiento de bugs, no funcionalidad nueva). Desde entonces `dev` avanzó **45 commits**, incluyendo — el mismo 2026-08-08 a las 16:47, hoy — el commit `8010742` **"feat(tools): dar al agente los datos reales de ponte en carrera (#71)"**, que conecta por primera vez el catálogo del agente a `features.csv` (6 208 combinaciones, 554 carreras, costo/ingreso/admisión/duración reales). Existe un PR abierto (`#67`, `chore/sync-dev-into-main`) pero está **desactualizado desde el 06/08** — le faltan justo los últimos 7 commits, incluido el #71.

Verificado con diff de contenido directo `main` vs `dev`:

- **Catálogo de carreras:** `main` tiene **10** carreras piloto (`data/careers/*.md`); `dev` tiene **20**. El propio informe (`08-results.tex:58`) dice *"catálogo piloto de 19 carreras"* — **ese número ya no es correcto en ninguna de las dos ramas** (10 en `main`, 20 en `dev`).
- **Dataset de evaluación:** `main` tiene **9** casos en `evals/dataset.jsonl`; `dev` tiene **29**. El informe (`08-results.tex:26`) dice *"framework de evaluación... con 30 casos"* — correcto solo si se lee `dev`, falso si se lee `main` (9, no 30).
- **`Dockerfile`:** **no existe en `main`**, sí en `dev` (`feat(docker): add multi-stage Dockerfile`, Sprint 10). El Criterio 5 pide explícitamente "Docker y docker-compose.yml operativos" — en `main`, el agente no tiene Docker.
- **Persistencia:** `main` no tiene *checkpointer*/*store* (`src/api/app.py` no los declara — cada request arranca sin memoria); `dev` sí implementa perfil persistente en Postgres (`feat(persistence): implementar el perfil postgres con schema agent`).
- **Integración de datos reales (el hallazgo más delicado):** la Sección 8 del informe (`08-results.tex:71-100`, párrafo *"Actualización: integración del catálogo con datos completos"*) afirma, con dos capturas reales (`fig-evidencia-caso3-explicacion.png`, `fig-evidencia-caso3-medicina.png`), que el agente **ya** recomienda carrera-universidad con costo/ingreso/admisión/duración reales para el caso "Medicina en Arequipa", y dice textualmente que esto **"cierra en buena parte la brecha del Criterio 4"**. Esas capturas son reales — corresponden al commit `8010742` de hoy — pero **ese código vive únicamente en `dev`**. Si el evaluador revisa `main` (lo esperable), no va a encontrar ni el campo de costo/ingreso en el `TypedDict Career`, ni ningún `features.csv` en el repo, ni la función que combina esos criterios. El informe, leído contra `main`, estaría describiendo una capacidad que el repositorio no respalda — exactamente el riesgo que la pre-evaluación anterior identificó como el más peligroso ("el evaluador puede desmentir revisando el repositorio"), y que hasta el 05/08 se había evitado con disciplina.

**Esto no es deuda técnica nueva por resolver: es trabajo ya hecho que solo falta fusionar.** Es, con diferencia, la acción de mayor retorno de las próximas horas — más que escribir texto nuevo, más que grabar el video. Actualizar el PR #67 (o abrir uno nuevo `dev → main`) y resolver los conflictos de fusión en `08-deep-agent` sube de golpe el nivel real de los Criterios 4, 5 y 8, y además hace que el informe deje de tener afirmaciones no verificables contra `main`.

En `04-frontend` la brecha es menor pero también real: `dev` tiene arreglos ya mergeados como *"que el banner cite la fuente del dato y no una escrita a mano"* (#23) y *"esconder el panel de administración a quien no es admin"* (#25) que no están en `main`. Vale la pena sincronizar también, pero no es bloqueante como `08-deep-agent`.

**Acción recomendada, en este orden:** (1) sincronizar `dev → main` en `08-deep-agent` esta noche — es la más urgente y la de mayor impacto; (2) sincronizar `dev → main` en `04-frontend`; (3) corregir en el informe las dos cifras ahora incorrectas ("19 carreras" → el número real tras sincronizar; "30 casos" → 29, o el número real tras sincronizar).

---

## Resumen ejecutivo

**Proyección si se entrega tal cual (main sin sincronizar, sin video): ~12-13 / 20.** Prácticamente sin cambio respecto al 05/08 en puntaje agregado, pero con una composición más riesgosa: el informe mejoró mucho en redacción y evidencia (Sección 8 en particular), pero parte de esa evidencia ya no es verificable contra el código que un evaluador realmente vería en `main`, lo que puede leerse como inconsistencia en vez de honestidad.

**Proyección si se sincroniza `dev → main` en `08-deep-agent` (y frontend) esta noche, sin video: ~14-15 / 20.** Es la mejora de mayor retorno por hora invertida de toda la lista: no requiere escribir código nuevo, solo resolver un merge ya preparado.

**Proyección si además se graba el video de exposición: ~16-17 / 20**, en línea con el techo que ya proyectaba la evaluación del 05/08.

El techo de "Destacado" generalizado (~19-20) seguiría requiriendo el ranking multicriterio completo (5 criterios ponderados, no solo mostrar los datos junto al resultado de afinidad) y métricas reales de producción del agente en vivo (latencia, costo, puntaje LLM-as-judge) — trabajo real de código, no alcanzable en 16 horas, y no se recomienda intentarlo: el retorno de sincronizar ramas y grabar el video es mayor y el riesgo de romper algo a horas de la entrega es menor.

## Tabla de estado por criterio

| # | Criterio | Pts máx. | Nivel hoy (main) | Nivel si se sincroniza dev→main | Bloqueo principal |
|---|---|---|---|---|---|
| 1 | Descripción del caso de uso | 1 | Logrado/Destacado | = | — |
| 2 | Selección de modelo y datos | 1 | Logrado/Destacado | = | Sin cambios desde 05/08 (dataset intacto) |
| 3 | Ingeniería de prompts y adaptación | 2 | Logrado | Logrado/Destacado | pgvector formalmente descartado (ADR-008) y justificado, no solo "plan" — falta reflejarlo así en el texto |
| 4 | **Implementación de la aplicación** | 3 | **En proceso** | **Logrado** | En `main`: 1 de 5 criterios, catálogo de 10, sin persistencia. En `dev`: catálogo real conectado, aún sin ranking ponderado completo |
| 5 | Orquestación y despliegue | 2 | Logrado | Logrado/Destacado | Prod aplicado y sincronizado (Terraform limpio), pero Dockerfile del agente no está en `main`; autoscaling y WAF/ACM siguen pendientes; costos sin documentar |
| 6 | Monitoreo y mantenimiento | 2 | Logrado | = | Infraestructura real (LangSmith) sigue sin una sola métrica de producción medida; único dato real es el 30/30 de evals en modo mock (no es métrica de producción) |
| 7 | Evaluación de la aplicación | 2 | Logrado | = | Métricas reales del motor offline (0.941 vs 0.502 en accesibilidad, comparación de enfoques) sí existen; falta puntaje real de LLM-as-judge en vivo, latencia, costo |
| 8 | **Resultados y demostración** | 2 | **Logrado (con riesgo)** | **Logrado/Destacado** | ≥4 casos reales, URL de demo, 9 figuras nuevas — pero la evidencia más fuerte depende de código que hoy solo está en `dev` |
| 9 | Conclusiones | 1 | Logrado/Destacado | = | — |
| 10 | Recomendaciones | 1 | Logrado/Destacado | = | — |
| 11 | Referencias bibliográficas | 1 | Destacado | = | 8 referencias, todas citadas, sin huérfanas |
| 12 | Link de exposición (video) | 2 | **No logrado** | = | Sigue sin existir; es logística de equipo, no de código |

---

## 1. Qué cambió respecto a la pre-evaluación del 05/08 (progreso real, no solo redacción)

### 1.1 Sección 8 (Resultados) se fortaleció sustancialmente

Antes: sin capturas, ejemplo "Cusco" redactado a mano, `\includegraphics` comentado. Hoy: **9 figuras reales incluidas y sin comentar** (frontend desplegado, ranking de afinidad real con explicabilidad, guardrail rechazando prompt injection, entrevista de assessment real, evals mock 30/30, SonarCloud Quality Gate Passed con 91% de cobertura, CI checks reales), **≥4 casos reales documentados** (supera el mínimo de 3 que pide "Logrado"), y una **URL de demo real**: `https://d3sx4v4l1enpvk.cloudfront.net`. El ejemplo "Cusco" se mantiene pero ahora está correctamente rotulado como diseño objetivo, no como ejecución real — ya no hay afirmación falsa ahí. Esto por sí solo movería el Criterio 8 de "En proceso" a "Logrado/Destacado" — **si** el código detrás de las capturas más fuertes (el caso Medicina/Arequipa) estuviera en `main`, ver hallazgo 0.

### 1.2 Métricas reales del motor offline (Criterio 7)

Antes: solo "prospectiva". Hoy: comparación real entre enfoques (solapamiento Top-5: 1/5 con pesos iguales, 3/5 solo-ingreso) y un índice de accesibilidad de costo medido (0.941 vs 0.502), con figura real (`fig-evidencia-motor-offline.png`). Es una mejora concreta, aunque sigue siendo evaluación del motor determinístico offline, no del agente conversacional en vivo — el LLM-as-judge sigue sin puntaje real.

### 1.3 Evidencia de CI/calidad real (Criterio 5)

Nuevo: capturas reales de ejecuciones de GitHub Actions y de SonarCloud (Quality Gate Passed, 91% cobertura, 1.7% duplicación, A en seguridad). Bien encaminado, aunque sigue sin costos documentados (`05-orchestration.tex:194` tiene un TODO explícito sin resolver) ni URL de demo mencionada en la propia Sección 5 (está en la 8, lo cual es una inconsistencia menor de organización, no de contenido).

### 1.4 Portada

`[Nombre del Docente]` ya no aparece — el equipo optó por **eliminar el campo** en vez de completarlo (commit del 05/08). Resuelto, aunque el issue `10-portada-docente.md` no refleja esta decisión (checkboxes sin marcar); conviene cerrarlo con una nota, no dejarlo así para la revisión de QA final.

### 1.5 RAG / pgvector (Criterio 3)

Antes se documentaba como "plan, no implementación". Hoy es una **decisión de arquitectura explícita y justificada** (ADR-008, "pgvector descartado" porque con ≤20 carreras y 1 perfil por usuario la búsqueda por palabra clave es suficiente). Esto es en realidad una mejora para la rúbrica: el descriptor de "Destacado" del Criterio 3 acepta integración de datos externos "implementada **o justificada**" — una decisión de no implementar con justificación técnica documentada cumple ese estándar mejor que un "está en el roadmap" vago. Vale la pena que el informe lo redacte así explícitamente en vez de solo mencionarlo como pendiente.

---

## 2. Lo que sigue sin resolver, igual que el 05/08

- **Video de exposición (Criterio 12, 2 pts):** sigue en cero absoluto. No depende de nada técnico, es logística de equipo (5 integrantes, máx. 15 min). Con ~16 horas restantes, es la tarea que menos margen tiene y debería empezar a coordinarse en paralelo a todo lo demás, no después.
- **Costos reales de AWS (Criterio 5):** TODO explícito en `05-orchestration.tex:194`, sin cifras.
- **Métricas de producción en vivo del agente (Criterios 6 y 7):** latencia, costo por conversación y puntaje LLM-as-judge siguen sin medirse; solo existen resultados del motor offline y de evals en modo mock.
- **Autoscaling ECS y gaps de seguridad de red (WAF, ACM):** siguen exactamente como el 05/08 — pendientes, documentados con `checkov:skip`, no bloqueantes para una demo académica.
- **Backend sin contexto `matching`:** confirmado sin cambios — el backend serverless sigue siendo solo `identity`; toda la integración de datos reales pasa por el agente directamente, saltándose el backend (decisión ya documentada como ADR-012, no es un descuido).

---

## 3. Priorización sugerida para las ~16 horas restantes

1. **Ahora mismo (30-60 min, más alto retorno de todo el documento):** sincronizar `dev → main` en `08-deep-agent` (actualizar/re-abrir el PR #67, resolver conflictos) y, si alcanza el tiempo, en `04-frontend`. Sin esto, parte de la evidencia más fuerte del informe (Sección 8) no es verificable contra lo que un evaluador va a clonar.
2. **Inmediatamente después:** corregir en `08-results.tex` los dos números que ya no coinciden con el código ("19 carreras" y "30 casos") con las cifras reales post-sincronización.
3. **En paralelo (otro integrante, esta noche):** coordinar y grabar el video de exposición (Criterio 12) — es la tarea con menos margen porque depende de que los 5 integrantes se conecten, no de código. No hace falta esperar a que todo lo demás esté cerrado; puede grabarse mostrando el estado ya sincronizado del sistema.
4. **Si sobra tiempo:** completar el TODO de costos reales en la Sección 5 (AWS Budgets ya está desplegado, es cuestión de consultar el dashboard); actualizar `DOCS/issues/issues-v1/` (varios issues siguen fechados 05/08 y no reflejan el avance real, lo que puede confundir al equipo en el QA final).
5. **No recomendado con el tiempo disponible:** intentar cerrar el ranking multicriterio completo (5 criterios ponderados) o instrumentar métricas de producción en vivo — es trabajo real de código de varias horas con alto riesgo de introducir regresiones a horas de la entrega, y el retorno marginal es menor que sincronizar ramas y asegurar el video.

## 4. Riesgo principal

El riesgo ya no es que falte evidencia (como el 05/08) — el equipo la generó, y es buena. El riesgo ahora es de **naturaleza distinta pero igual de serio: que la evidencia más fuerte del informe no sea verificable contra el código que el evaluador realmente va a revisar**, porque vive en `dev` y no en `main` de `08-deep-agent`. Es un riesgo barato de cerrar (un merge, no código nuevo) y con el mayor impacto individual de toda esta lista sobre el Criterio de mayor peso de la rúbrica (Criterio 4, 3 pts). Cerrarlo esta noche es, con diferencia, la acción de más alto retorno antes de la entrega del domingo.
