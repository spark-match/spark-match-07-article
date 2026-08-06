# Pre-evaluación 1 — Proyección de nota (Spark Match / CareerMatch Perú)

**Fecha de esta evaluación:** 2026-08-05
**Rama evaluada:** `feat/report-update`
**Entrega final:** domingo 2026-08-09, 13:00 hrs — **quedan 4 días**
**Base:** `DOCS/RUBRICA-PROGRAMA.md` (12 criterios, 20 pts) + verificación directa del código en los 9 repos del ecosistema (no solo del informe ni de la documentación de diseño, que en varios puntos está desactualizada respecto al código real).

## Cómo leer este documento

Cada hallazgo distingue **lo que dice/muestra el informe** de **lo que existe realmente en el código**, porque esa brecha es precisamente el mayor riesgo de nota: la rúbrica premia evidencia verificable ("código adjunto", "resultados reales", "capturas funcionales"), no descripciones bien escritas de un diseño. Los hallazgos están agrupados en dos categorías:

- **Obligatorio**: sin esto, uno o más criterios quedan en "En proceso" (50%) o peor, o el informe corre el riesgo de afirmar algo que el evaluador puede desmentir revisando el repositorio.
- **Deseable**: sube el nivel de "Logrado" a "Destacado" en algún criterio, pero su ausencia no hunde la nota si el resto está honesto y sólido.

## Resumen ejecutivo

**Proyección actual: ~13 / 20 puntos** si la entrega fuera hoy tal cual está, **~16-17 / 20** si se cierran los puntos obligatorios de esta lista antes del 09/08. El techo de "Destacado" generalizado (~19-20) requeriría cerrar además la brecha de código del motor de scoring (Criterio 4), que es la de mayor esfuerzo y mayor impacto individual (3 pts, el criterio de más peso de toda la rúbrica).

El informe en sí ya está en buen estado: es honesto, no infla capacidades inexistentes (se hizo una limpieza extensa de afirmaciones que no correspondían al código real — Weights & Biases inexistente, despliegue en Bedrock AgentCore inexistente, extractor de preferencias inexistente, etc.) y compila sin errores. **El riesgo real no es de redacción, es de evidencia**: al equipo le falta ejecutar el sistema y capturar resultados reales, y le falta cerrar código pendiente en el motor de recomendación.

## Tabla de estado por criterio

| # | Criterio | Pts máx. | Nivel estimado hoy | Bloqueo principal |
|---|---|---|---|---|
| 1 | Descripción del caso de uso | 1 | Logrado/Destacado | — |
| 2 | Selección de modelo y datos | 1 | Logrado | — |
| 3 | Ingeniería de prompts y adaptación | 2 | Logrado | pgvector es plan, no implementación |
| 4 | **Implementación de la aplicación** | 3 | **En proceso/Logrado** | Motor de scoring: solo 1 de 5 criterios integrado |
| 5 | Orquestación y despliegue | 2 | Logrado | Falta URL de demo desplegada y verificada |
| 6 | Monitoreo y mantenimiento | 2 | Logrado | Sin métricas de producción medidas aún |
| 7 | Evaluación de la aplicación | 2 | Logrado/Destacado | Recall@K no implementado (depende del punto 4) |
| 8 | **Resultados y demostración** | 2 | **En proceso** | Sin capturas ni ejecución real capturada |
| 9 | Conclusiones | 1 | Logrado/Destacado | — |
| 10 | Recomendaciones | 1 | Logrado/Destacado | — |
| 11 | Referencias bibliográficas | 1 | Destacado | 8 referencias APA, todas citadas |
| 12 | Link de exposición (video) | 2 | **No logrado (aún no existe)** | Ver nota al final — obvio, no es el foco de este documento |

Los dos criterios en riesgo real son el **4** (mayor peso de toda la rúbrica) y el **8**, y ambos comparten la misma causa raíz: el sistema no se ha ejecutado de punta a punta con datos reales y no se ha capturado evidencia de esa ejecución.

---

## 1. Brechas obligatorias (imprescindibles antes del 09/08)

Ordenadas por impacto en la nota.

### 1.1 El motor de scoring de 5 criterios no está integrado (Criterio 4 — 3 pts, el de mayor peso)

**Qué dice el diseño del informe:** un ranking multicriterio (afinidad, ingreso, costo, admisión, duración) sobre las 6,208 combinaciones carrera–universidad de `features.csv`, con pesos dinámicos inferidos por el LLM.

**Qué existe hoy en el código** (`spark-match-08-deep-agent/src/tools/matching/handler.py`):
- Solo se calcula **afinidad RIASEC** (`calculate_affinity_handler`), 1 de los 5 criterios.
- Opera sobre un **catálogo piloto de 19 carreras** hecho a mano (`data/careers/*.md`: id, nombre, perfil RIASEC, campo), sin universidad, ingreso, costo ni admisión.
- `features.csv` (6,208 filas, verificado por conteo) **no está conectado a nada río abajo**: ni al agente, ni al backend.
- El backend serverless solo implementa el contexto `identity` (login, registro, auditoría); no existe contexto de `matching` ni carga de `features.csv` en la base de datos.

**Por qué es obligatorio, no deseable:** el descriptor "Destacado" del Criterio 4 exige "integración real entre LLM, API, base de datos e interfaz de usuario" con "código funcional" verificable en el repositorio. Con el alcance actual, el nivel realista es "En proceso" (*"implementación parcial: algunos componentes sin integrar"*) tirando a "Logrado" gracias a que el patrón afinidad-end-to-end sí funciona y está bien documentado. Es el criterio de mayor peso individual (3 pts) de los 20 totales — un salto de nivel aquí mueve más la nota que cualquier otro ajuste.

**Qué se necesita, concretamente (trabajo de código en Python, no de redacción):**
- Definir si el agente lee `features.csv` directamente o vía un endpoint del backend.
- Implementar la función de combinación ponderada sobre `ingreso_norm`, `costo_norm`, `admision_norm`, `duracion_norm` (ya existen normalizados en `features.csv`; falta la lógica de combinación con pesos).
- Exponer los pesos dinámicos desde el LLM hacia esa función (el diseño de las preguntas B1-B5 ya está especificado en `00-knowledge-base/docs/SDD/4_reglas-negocio-agente.md`).
- Ampliar el catálogo del agente más allá de las 19 carreras piloto (aunque sea a un subconjunto representativo, no las 554 completas).

**Si no alcanza el tiempo:** la alternativa ya aplicada en esta rama (documentar honestamente "diseño objetivo" vs. "estado actual") evita que el informe mienta, pero por sí sola no sube el nivel del criterio — solo evita que baje más. Es una decisión de equipo, no técnica: cerrar la brecha real compite por los mismos 4 días con el resto de esta lista.

### 1.2 Sin evidencia funcional real capturada (Criterio 8 — 2 pts)

**Qué existe hoy:** el ejemplo "canónico" de la Sección 8 (caso Cusco) es un ejemplo redactado a mano para ilustrar el diseño objetivo — el propio texto ya lo aclara así, precisamente porque el extractor de región/presupuesto/pesos que ese ejemplo requeriría no existe todavía en el agente. La figura de captura de la interfaz está comentada en el LaTeX con la leyenda "por incluir". No hay capturas de la API, ni trazas de LangSmith, ni pantallazos del sistema corriendo.

**Por qué es obligatorio:** el descriptor "En proceso" (50%) del Criterio 8 dice literalmente *"solo mockup visual o respuestas simuladas... sin evidencia funcional real"* — que es exactamente la situación actual. Para "Logrado" (75%) alcanza con: al menos 3 ejemplos reales de respuestas del modelo + capturas de la API o interfaz funcional + un video corto o enlace parcialmente funcional.

**Qué se necesita:**
- Ejecutar el agente contra un caso real (puede ser sobre el alcance actual — afinidad RIASEC sobre el catálogo piloto — no hace falta esperar a que el punto 1.1 esté resuelto) y capturar la conversación real, no redactarla.
- Captura de pantalla real del frontend (Angular) conversando con el agente.
- Reemplazar el `\includegraphics` comentado por la imagen real.
- Si no hay demo en la nube para la fecha límite, decirlo explícitamente en el texto ("ejecutado localmente, ver video") en vez de dejar el placeholder "enlace por definir tras el despliegue".

### 1.3 Métricas de operación reales no medidas (Criterios 6 y 7 — 4 pts combinados)

**Qué existe:** el marco de evaluación (LLM-as-judge, 29 casos, corre en cada PR) y de observabilidad (LangSmith) están realmente implementados y corriendo — eso es sólido y ya está bien documentado. Lo que falta son **resultados**, no infraestructura: `docs/benchmarks.md` marca explícitamente las cifras del Deep Agent como "prospectiva" (objetivo), no medida; las únicas cifras reales son de prototipos anteriores del proyecto.

**Qué se necesita:** correr `evals/runner.py --mode live` (o el equivalente en producción) y publicar al menos un conjunto real de resultados (tasa de acierto del código RIASEC, puntaje del LLM-as-judge, latencia, costo por conversación) en las Secciones 6 y 7. Esto no requiere el sistema desplegado en ECS — el propio código permite correrlo en local o CI invocando el agente en proceso.

### 1.4 Placeholders administrativos residuales

Pequeños pero de alto impacto visual/formal si se olvidan, y triviales de resolver:

- `main.tex:29` — `[Nombre del Docente]` sigue sin completar en la portada.
- TODOs de texto aún presentes en `04-implementation.tex` (diagramas más detallados), `06-monitoring.tex` (valores medidos), `07-evaluation.tex` (tabla comparativa Recall@K/latencia/costo), `08-results.tex` (capturas + enlace demo), `05-orchestration.tex` (costos + URL de demo).
- Confirmar el nombre de archivo de entrega `TFP_XXX_YYY_ZZZ` (primeros apellidos de los 5 integrantes) y que el repositorio a subir a CANVAS incluya `requirements.txt`/`Dockerfile`/`docker-compose.yml`/`README.md` en cada repo correspondiente, no solo en el artículo.

### 1.5 Video de exposición

Es un entregable obligatorio (2 pts, Criterio 12) y hoy no existe (`No logrado`). No se profundiza aquí porque su necesidad ya es evidente y no depende de ninguna decisión técnica — es logística de equipo (los 5 integrantes deben participar, máximo 15 minutos, mostrando el sistema funcionando). Su contenido sí depende de que los puntos 1.1–1.3 estén resueltos: conviene grabarlo **después** de tener evidencia funcional real, no antes, para no tener que regrabarlo.

---

## 2. Mejoras deseables (no bloqueantes, pero suben el nivel si hay tiempo)

Ordenadas de mayor a menor relación impacto/esfuerzo.

- **Migración de la fuente de datos (`Ponte en Carrera` → `Mi Carrera`, MTPE).** El portal actual devuelve HTTP 500 desde el 12/07/2026 (decomisionado); la etapa `ingest` del pipeline DVC quedó `frozen`. No bloquea la entrega (el dataset histórico ya está versionado y es reproducible), pero sin esto no se puede volver a actualizar `features.csv` a futuro. Vale la pena solo si sobra tiempo tras cerrar la sección 1.
- **Implementar RAG con pgvector.** Ya está planeado en el propio código (`search_careers` documenta la intención), pero hoy la búsqueda es por palabra clave. Subiría el Criterio 3 de "Logrado" a "Destacado", pero es trabajo de código adicional con menor peso (2 pts) que el motor de scoring.
- **Habilitar autoscaling en el servicio ECS Fargate del agente.** Hoy `desired_count` es fijo; el campo de Terraform ya está preparado (`lifecycle.ignore_changes`) para cuando se agregue. Mejora el Criterio 5, pero no es indispensable para un sistema de demostración académica con tráfico bajo.
- **Cerrar los gaps de seguridad de red documentados en el propio Terraform** (WAF delante del ALB/CloudFront, dominio propio con certificado ACM para TLS extremo a extremo). Mencionados como pendientes por el propio código (`checkov:skip`); no afectan directamente ningún criterio de la rúbrica de forma crítica.
- **Ampliar el catálogo del agente más allá de 19 carreras** hacia un subconjunto mayor de las 554 únicas de `features.csv`, incluso sin cerrar los 5 criterios de scoring — mejora la percepción de "sistema real" en la demo aunque el ranking siga siendo solo por afinidad.
- **Implementar Recall@K** sobre un conjunto de referencia una vez el ranking multicriterio exista — hoy no tiene sentido implementarlo porque no hay ranking completo que medir; depende de 1.1.
- **Mecanismo de feedback del usuario** para entrenar un modelo propio de aceptación (ya mencionado como recomendación futura en la Sección 10) — claramente fuera de alcance para esta entrega, es una línea de trabajo post-TFP.
- **Ajuste fino (LoRA) del subagente de assessment** — mencionado en Recomendaciones; requiere volumen de conversaciones reales que hoy no existe, por lo tanto no es realista para esta entrega.

---

## 3. Priorización sugerida para los 4 días restantes

Dado que el criterio 4 compite por el mismo tiempo que el resto, la secuencia con mejor retorno esperado es:

1. **Día 1-2:** cerrar 1.2 (evidencia funcional real) y 1.3 (métricas reales) sobre el alcance **actual** del sistema (solo afinidad RIASEC) — no requiere esperar a nada y ya sube directamente los Criterios 6, 7 y 8.
2. **Día 1-2 (en paralelo, otro integrante):** decidir en equipo el alcance de 1.1 — si se cierra la brecha real de código o se documenta el alcance actual como definitivo. Si se cierra, es la tarea de mayor esfuerzo de toda la lista y debe empezar cuanto antes.
3. **Día 3:** placeholders administrativos (1.4) — trivial, no dejar para el final.
4. **Día 3-4:** grabar el video (1.5) una vez exista evidencia real que mostrar.
5. **Si sobra tiempo:** mejoras deseables de la sección 2, priorizando pgvector o autoscaling ECS sobre las demás por su relación esfuerzo/impacto en la rúbrica.

## 4. Riesgo principal

El mayor riesgo no es que el informe "mienta" — ya se hizo un trabajo deliberado de honestidad (reencuadrar diseño vs. estado real en varias secciones) que protege contra eso. El riesgo real es que **el Criterio 4, al ser el de mayor peso (3 de 20 puntos), quede en "En proceso" por evidencia insuficiente de integración**, y que el Criterio 8 quede bajo por falta de capturas, arrastrando la nota total varios puntos por debajo del potencial del proyecto, que a nivel de diseño y arquitectura es sólido.
