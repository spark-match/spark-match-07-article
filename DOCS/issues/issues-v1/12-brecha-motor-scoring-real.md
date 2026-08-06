# Issue 12 — Brecha crítica: el motor de scoring de 5 criterios no está integrado

**Criterio rúbrica:** 4 (Implementación de la aplicación, 3pt — el de mayor peso individual) y transversalmente 1, 2, 7, 8.
**Prioridad:** **Bloqueante — más urgente que 01.** Descubierto 2026-08-05 al revisar el código real de los repos (no solo la documentación) a pedido explícito del usuario ("revisa con mucho cuidado, puede que no se haya actualizado después de haber hecho cambios al codebase").
**Depende de:** nada. Bloquea la interpretación correcta de 01, 03, 04, 05.

## Contexto

El informe (Resumen, Secciones 1, 2, 4 y 8) describe un motor de recomendación
que combina **cinco criterios ponderados** (afinidad, ingreso, costo, admisión,
duración) sobre las **6,208 combinaciones carrera–universidad** de
`features.csv`. Al revisar el código real (no la documentación) de
`spark-match-08-deep-agent` y `spark-match-03-backend` en su rama `dev`
(commits del 2026-08-05), se confirmó que **eso no es lo que existe hoy**:

- `spark-match-08-deep-agent/src/tools/matching/handler.py` implementa
  `calculate_affinity_handler`, que calcula **únicamente similitud RIASEC**
  (1 de los 5 criterios) y ordena un Top-N solo por ese criterio.
- El catálogo que usa el agente (`spark-match-08-deep-agent/data/careers/*.md`,
  19 archivos) es **hecho a mano**: `id, name, riasec_profile, field, outlook`.
  No tiene universidad, ingreso, costo, admisión ni duración.
- `features.csv` (6,208 filas, verificado por conteo directo) existe en
  `spark-match-05-data-pipeline` con las 4 variables normalizadas
  (`income_norm`, `cost_norm`, `admission_norm`, `duration_norm`), pero **no
  está conectado a nada río abajo** — ni al agente, ni al backend.
- `spark-match-03-backend` solo implementa el contexto `identity`
  (login, registro, perfil, auditoría). No existe contexto de `matching` ni
  carga de `features.csv` en Aurora PostgreSQL.
- El propio `spark-match-00-knowledge-base/docs/SDD/4_reglas-negocio-agente.md`
  (2026-07-05) ya documentaba esto: *"de la fórmula, solo `afinidad` está
  implementado"*. Sigue siendo cierto un mes después.

**Ya se aplicó un fix de alcance 1 (reencuadre honesto)** en esta rama: el
Resumen, Sección 1, Sección 2, Sección 4 y Sección 8 del artículo ahora
distinguen explícitamente "diseño objetivo" vs. "estado actual implementado"
(afinidad únicamente, catálogo piloto de 19 carreras). Esto evita que el
informe afirme algo falso, pero **no cierra la brecha técnica** ni mejora el
puntaje de la Sección 4 más allá de lo honesto.

## Decisión pendiente (para el equipo, no para mí)

Quedan dos caminos, y el equipo debe elegir uno antes del 09/08:

1. **Cerrar la brecha de verdad**: implementar los 4 criterios faltantes y
   conectar el catálogo del agente con `features.csv` (o un subconjunto
   representativo). Esto es trabajo real en Python, principalmente en
   `spark-match-08-deep-agent/src/tools/matching/` y posiblemente
   `spark-match-05-data-pipeline`. Requiere decidir: ¿el agente lee
   `features.csv` directamente, o el backend lo carga a Aurora y expone un
   endpoint? Alto impacto en el puntaje de la Sección 4 (Destacado exige
   "código adjunto" y arquitectura coherente), pero es una tarea de código,
   no de redacción, y compite por tiempo con los demás issues.
2. **Aceptar el alcance actual y documentarlo con precisión** (ya hecho en
   esta rama). El informe queda honesto pero el nivel de Sección 4 probablemente
   quede en "Logrado" en vez de "Destacado", porque el prototipo demuestra el
   patrón (afinidad end-to-end) pero no el motor completo.

## Tareas (si el equipo elige el camino 1)

- [ ] Definir dónde vive la fuente de datos para el agente: ¿leer
      `features.csv` directamente en `catalog/loader.py`, o vía API del
      backend? (impacta el diagrama de la Figura `fig:architecture`)
- [ ] Implementar el cálculo de `ingreso_norm`, `costo_norm`, `admision_norm`,
      `duracion_norm` como parte del score combinado (ya están normalizados en
      `features.csv`; falta la función de combinación con pesos).
- [ ] Exponer los pesos dinámicos (`w_afinidad, w_ingreso, w_costo, w_admision,
      w_duracion`) desde el LLM hacia la nueva función de scoring (ver
      `docs/SDD/4_reglas-negocio-agente.md` en `00-knowledge-base` para el
      diseño ya especificado del bloque de preguntas B1-B5).
- [ ] Ampliar o reemplazar el catálogo piloto de 19 carreras por (un
      subconjunto representativo de) las 554 carreras únicas de
      `features.csv`.
- [ ] Actualizar el Resumen, Sección 1, Sección 2, Sección 4 y Sección 8 del
      artículo para reflejar la integración real una vez implementada
      (revertir el lenguaje de "diseño objetivo / trabajo en curso" añadido en
      este issue por lenguaje de hecho consumado, con evidencia).

## Tareas (si el equipo elige el camino 2 — ya aplicado)

- [x] Reencuadrar Resumen, Sección 1, Sección 2, Sección 4 y Sección 8 para
      distinguir diseño vs. estado actual, sin fabricar datos.
- [ ] Revisar que el Issue 03 (evaluación) y el Issue 04 (resultados/demo) NO
      pidan medir Recall@K ni generar capturas del ranking multicriterio
      completo, ya que ese flujo no existe — ajustar su alcance a lo que sí es
      medible (afinidad RIASEC end-to-end).
- [ ] Mencionar explícitamente esta limitación como línea de trabajo futuro en
      la Sección 10 (Recomendaciones), si aún no está cubierta.

## Verificación

- [ ] `grep -rn "calculate_affinity_handler\|w_ingreso\|w_costo\|w_admision\|w_duracion"` en
      `spark-match-08-deep-agent/src/` confirma qué criterios están realmente
      combinados (hoy: solo afinidad).
- [ ] El PDF compila sin errores (`latexmk -pdf -interaction=nonstopmode
      -halt-on-error main.tex`) tras cualquier edición de las secciones
      afectadas.
- [ ] Ningún párrafo del informe afirma en tiempo presente ("el sistema hace
      X") algo que no está verificado en el código de la rama `dev` de los
      repos correspondientes a la fecha de la verificación.
