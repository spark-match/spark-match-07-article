# Pre-evaluación 3 — Proyección de nota (Spark Match / CareerMatch Perú)

**Fecha de esta evaluación:** 2026-08-08, ~21:15 (hora Perú)
**Ramas evaluadas:** `main` en 8 de los 9 repos, **`dev` en `spark-match-08-deep-agent`** — por indicación explícita: el PR de sincronización (`#67`, `chore/sync-dev-into-main → main`) está pendiente de aprobación por el encargado, así que esta pre-evaluación asume ese merge como el estado que `main` tendrá pronto y evalúa contra `dev` directamente.
**Entrega final:** domingo 2026-08-09, 13:00 hrs — **quedan ~16 horas**.
**Reemplaza a:** `2da-proyeccion-evaluacion.md` (2026-08-08, ~20:55) únicamente en lo relativo a `08-deep-agent`; el resto de hallazgos de esa versión sigue vigente y no se repite aquí salvo que haya cambiado.

## ⚠️ Antes de leer los números: el PR #67 tal como está HOY no cierra la brecha

Esto es importante y no era evidente al pedir "aprobar el PR de sync": verifiqué el estado real del PR `#67` contra el `dev` actual y **la rama del PR (`chore/sync-dev-into-main`) está desactualizada — le faltan los últimos 8 commits de `dev`**, incluido exactamente el que más importa: `8010742` *"feat(tools): dar al agente los datos reales de ponte en carrera (#71)"* (el que conecta el catálogo a datos reales) y el nuevo subagente de matching (`96a42a9`). GitHub lo marca como `MERGEABLE` (no hay conflictos), pero **mergeable no es lo mismo que actualizado**: si el encargado aprueba y fusiona el PR *tal cual está ahora*, `main` seguiría sin la integración de datos reales — el mismo problema que esta pre-evaluación busca resolver seguiría abierto, solo que de forma menos visible.

**Acción concreta necesaria antes de aprobar:** actualizar la rama `chore/sync-dev-into-main` con el `dev` actual (`git merge origin/dev` o reabrir el PR desde `dev` directo) para que el merge incluya los 8 commits pendientes. Es un paso de 5 minutos, pero sin él la aprobación del PR no logra lo que se busca.

El resto de este documento evalúa el escenario **una vez que ese merge sí incluya el `dev` completo** (commit `ed64bae`, el HEAD actual), que es lo que el equipo espera lograr esta noche.

---

## Resumen ejecutivo (actualizado)

**Proyección si `main` termina reflejando el `dev` actual completo (post-merge correcto) + sin video: ~14-15 / 20.** Confirma la proyección de la pre-evaluación anterior (Escenario B), ahora verificada directamente contra el contenido real de `dev`, no estimada.

**+ video de exposición: ~16-17 / 20.**

## Qué cambia en el Criterio 4 (el de mayor peso, 3 pts) al evaluar `dev`

Sobre `main` (commit `82bf13b`, el que se evaluó ayer): 1 de 5 criterios de scoring, catálogo manual de 10 carreras, sin Docker, sin persistencia — **En proceso**.

Sobre `dev` (commit `ed64bae`, HEAD actual), verificado directamente en el código:

- **Nueva herramienta `search_programs`** (`src/tools/programs/handler.py`, `data/programs/programs.csv`, 6 208 filas — el mismo dataset de `features.csv`, confirmado por conteo de filas) que permite al agente buscar programas reales (carrera + institución + ubicación + tipo) con **costo anual, ingreso mensual, tasa de admisión y duración reales**, con filtro explícito por presupuesto máximo (`max_annual_cost`) y marcado honesto de qué campos son medidos vs. imputados (`estimated`). Esto es lo que respalda las capturas del caso "Medicina/Arequipa" en la Sección 8 del informe — con `dev`, esas capturas **sí son verificables contra el código**.
- **Nuevo subagente `matching`** (`src/agent/subagents/matching.py`) que combina `search_careers` + `calculate_affinity` (RIASEC) + `search_programs` (datos reales) en una sola conversación delegada por el coordinador.
- **Con una precisión importante que el informe debe mantener honesta:** el propio código documenta que `search_programs` es **"recuperación, no scoring"** (comentario literal en `handler.py:1-6`: *"Filtra y ordena; no calcula afinidad ni inventa un ranking... meterla aquí duplicaría la definición de 'encaja' en dos sitios"*). Es decir: hoy el agente puede **mostrar** afinidad RIASEC y datos reales de costo/ingreso/admisión/duración **uno al lado del otro** para las mismas carreras, y el LLM razona sobre ambos en su respuesta — pero **no existe todavía una función que combine los 5 criterios en un único score ponderado** (no hay `peso_afinidad`, `peso_ingreso`, etc. en ningún prompt ni handler de `dev`, confirmado por búsqueda en el código). El diseño de ranking multicriterio ponderado de la Sección 4 del informe sigue siendo, con toda propiedad, "diseño objetivo" — el informe ya lo dice así y **debe seguir diciéndolo así** aunque se sincronice `dev`, para no pasar de "honesto" a "impreciso" en la dirección contraria.
- Otros hallazgos confirmados en `dev`: catálogo de afinidad RIASEC ahora en **20 carreras** (no 19, no 10 — el número que debe quedar en el informe tras sincronizar), **29 casos** en `evals/dataset.jsonl` (no 30, la cifra del informe debe decir 29), `Dockerfile` multi-stage presente (cierra el hueco de "Docker operativo" del Criterio 5), y persistencia de perfil en Postgres implementada (`memory_middleware.py`).

**Nivel resultante para el Criterio 4 sobre `dev`: Logrado sólido, cerca de Destacado pero sin llegar** — hay integración real y verificable entre LLM y datos reales de mercado (retrieval funcional, no mockup), pero falta exactamente lo que el descriptor "Destacado" pide de forma más estricta: un motor de scoring que combine los 5 criterios en un ranking único, y una base de datos real (hoy `programs.csv` se carga en memoria desde archivo, no desde RDS PostgreSQL como describe el diseño original). Subir de "Logrado" a "Destacado" en este criterio específico seguiría requiriendo la función de combinación ponderada — trabajo real de código que, con ~16 horas y el resto de tareas pendientes, no se recomienda intentar esta noche (ver priorización de la pre-evaluación anterior, sigue vigente).

## Tabla de estado actualizada (solo filas que cambian respecto a `2da-proyeccion-evaluacion.md`)

| # | Criterio | Pts máx. | Nivel sobre `main` de ayer | Nivel sobre `dev` (hoy, verificado) |
|---|---|---|---|---|
| 4 | Implementación de la aplicación | 3 | En proceso | **Logrado (alto), no llega a Destacado** |
| 5 | Orquestación y despliegue | 2 | Logrado (sin Docker en el agente) | **Logrado/Destacado** (Docker del agente ya presente; autoscaling y costos AWS siguen pendientes igual que antes) |
| 8 | Resultados y demostración | 2 | Logrado con riesgo de no ser verificable | **Logrado/Destacado, evidencia verificable** |

El resto de criterios (1, 2, 3, 6, 7, 9, 10, 11, 12) no cambia respecto a `2da-proyeccion-evaluacion.md` — esos repos no tuvieron cambio de rama.

## Dos correcciones textuales pendientes en el informe (antes exactas, ahora desactualizadas de nuevo)

Si se sincroniza `dev → main`, dos cifras que el informe cita deben actualizarse una vez más para seguir siendo exactas:

- `08-results.tex:58` — "catálogo piloto de 19 carreras" → son **20** en `dev`.
- `08-results.tex:26` — "framework de evaluación... con 30 casos" → son **29** en `evals/dataset.jsonl` de `dev`.

Y conviene añadir una frase corta reconociendo la nueva herramienta `search_programs` explícitamente como *recuperación sobre datos reales, no como el motor de scoring ponderado* — así el propio informe se adelanta a la pregunta que un evaluador atento haría al ver `handler.py`, en vez de dejar que la ambigüedad de la Sección 8 actual ("cierra en buena parte la brecha del Criterio 4") se preste a una lectura más optimista de lo que el código sostiene.

## Riesgo principal (actualizado)

El riesgo de raíz (evidencia no verificable contra `main`) se resuelve si el merge se hace bien. El riesgo que queda, más chico pero real, es de **precisión**: la frase actual del informe ("esto cierra en buena parte la brecha del Criterio 4") es optimista respecto a lo que el código realmente hace (retrieval real, no scoring ponderado real). No es una mentira — el propio párrafo ya aclara que "la integración es reciente y aún en estabilización" — pero conviene ajustarla para que describa con precisión qué se ganó (datos reales accesibles al agente) sin sugerir que el motor de 5 criterios ya combina esos datos en un ranking, que es específicamente lo que la rúbrica del Criterio 4 pide para el nivel más alto.
