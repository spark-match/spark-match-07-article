# Guion aproximado — Video de exposición (Sección 12)

Basado en la distribución ya definida en `sections/12-exposicion.tex` (Tabla
"Distribución de la exposición entre los integrantes del equipo") y en los
requisitos de `DOCS/TFP-GUIDELINES.md` (punto 7, Criterio 12 de
`DOCS/RUBRICA-PROGRAMA.md`):

- **Duración máxima: 15 minutos** (duro; superarla baja el criterio a "En
  proceso" aunque el resto esté perfecto).
- **Los 5 integrantes deben participar** con tiempo visible en pantalla.
- Debe incluir **demostración funcional del sistema**, no solo diapositivas.
- Audio y video claros (probar micrófono/luz antes de grabar la toma final).

**Meta de grabación: ~13:30–14:00**, dejando ~1 minuto de colchón para no
arriesgarse a pasarse de los 15:00 al editar/unir los segmentos de cada
integrante.

Todos los datos y cifras de este guion están tomados directamente del informe
(`sections/01` a `10`) — no inventar cifras nuevas frente a cámara que no
estén en el PDF.

---

## Estructura y tiempos (14:00 objetivo / 15:00 tope)

| # | Tiempo | Duración | Integrante | Bloque |
|---|--------|----------|------------|--------|
| 1 | 00:00–00:40 | 0:40 | David Barreto | Apertura + Introducción y problema |
| 2 | 00:40–02:40 | 2:00 | Nikolai Asencios | Modelo, datos y pipeline |
| 3 | 02:40–06:40 | 4:00 | Angel Hincho | Arquitectura, prompts, stack y orquestación/despliegue |
| 4 | 06:40–08:40 | 2:00 | Andy Huamani | UI/UX y frontend |
| 5 | 08:40–12:40 | 4:00 | Fabiola Tapara | Demo funcional en vivo + resultados y evaluación |
| 6 | 12:40–14:00 | 1:20 | David (cierre) | Conclusiones y recomendaciones |

Criterio de reparto: 15:00 / 5 ≈ 3:00 de base por persona, pero se reasigna
tiempo hacia los dos bloques con más peso real: Angel cubre 3 secciones
completas (Prompts + Implementación + Orquestación = 7 de los 20 puntos de la
rúbrica) y Fabiola cubre la demo en vivo que el Criterio 12 exige de forma
explícita. Andy (solo frontend, un subconjunto del Criterio 4 que Angel ya
menciona de pasada) y Nikolai (Criterio 2, 1 punto) se quedan en 2:00; David
reparte sus 2:00 entre apertura y cierre para no dejar la introducción y las
conclusiones sin dueño.

---

## 1. David Barreto — Apertura + Introducción y problema (0:40, Sección 1)

- Saludo breve del equipo (nombres y roles no hace falta, ya sale la tabla en
  el informe) y nombre del proyecto: **Spark Match (CareerMatch Perú)**.
- El problema: la información para elegir carrera está dispersa (ingresos,
  costos, admisión, ubicación) y las evaluaciones vocacionales tradicionales
  no la conectan con eso.
- Una cifra de impacto (elegir 1, no las tres, para no perder tiempo): **solo
  30.9% de los jóvenes de 15-29 años transita a educación superior**, con
  deserción universitaria de **15.8%**.
- Objetivo: asistente conversacional (LLM) + motor de scoring transparente
  que recomiende carrera–universidad con datos oficiales.
- *En pantalla:* portada del informe o diapositiva de título; opcional, la
  Figura de recorrido del usuario (`fig-user-journey_v2.png`).

## 2. Nikolai Asencios — Modelo, datos y pipeline (2:00, Sección 2)

- Por qué **AWS Bedrock + Claude**: gestionado, sin GPU local, buen español,
  integrado nativamente con el resto de AWS.
- Mencionar el **enrutador por intención** (Haiku para turnos simples, Sonnet
  para el resto) como optimización de costo/latencia.
- Dataset: portal oficial **Ponte en Carrera** (MINEDU) → `features.csv` con
  **6,208 combinaciones carrera–institución**, **554 carreras únicas**, **25
  departamentos**.
- Pipeline de datos versionado con **DVC (4 etapas)**: ingesta → limpieza →
  features → etiquetado RIASEC (vía LLM).
- Ser honesto en cámara sobre la fuente: el portal fue decomisionado por el
  MINEDU, así que la etapa de ingesta está congelada sobre el último snapshot
  válido (no es un detalle que reste puntos, pero conviene decirlo porque el
  informe ya lo documenta).
- *En pantalla:* Figura del pipeline de datos (`fig-pipeline-datos_v2.png`) o
  la captura de `qa_check_features.py` (Figura `fig-evidencia-qa-datos`).

## 3. Angel Hincho — Arquitectura, prompts, stack, orquestación y monitoreo (4:00, Secciones 3–6)

Es el bloque más largo porque cubre 4 secciones (9 de los 20 puntos de la
rúbrica), así que conviene ir directo a lo visual y no leer texto.

- Arquitectura del agente: **Deep Agent** con `deepagents`, un coordinador que
  delega en **3 subagentes**: `assessment` (entrevista RIASEC escalonada),
  `matching` (afinidad + datos reales) y `planning` (plan de acción).
- Prompts versionados como archivos `.md`, con *guardrails* (anti-jailbreak,
  contenido inseguro, redacción de PII).
- Stack: backend serverless en **TypeScript/AWS Lambda**, agente en
  **Python/FastAPI sobre ECS Fargate** (Docker), frontend en Angular.
- Despliegue: **Terraform** (IaC), **CI/CD con GitHub Actions**
  (tests + SonarCloud + CodeQL + checkov/tflint), ambientes `dev`/`prod`.
- Con el tiempo extra: observabilidad y MLOps (Sección 6) — trazas de
  **LangSmith**, versionado de prompts/datos (**DVC**, 4 etapas) y la suite
  de **evals corriendo en cada pull request** (no hace falta detallar
  números aquí, eso lo retoma Fabiola en la demo).
- *En pantalla (elegir 3-4, no las 6):* diagrama de arquitectura lógica
  (`fig-arquitectura-logica_v2.png`), diagrama de despliegue AWS
  (`fig-arquitectura-despliegue-aws_v2.png`), captura de GitHub Actions en
  verde (`fig-evidencia-ci-checks.png`), el panel de SonarCloud
  (`fig-evidencia-sonar-backend.png`, 91% cobertura) y/o el panel de
  administración MLOps (`fig-evidencia-mlops-versionado.png`).

## 4. Andy Huamani — UI/UX y frontend (2:00, parte de la Sección 4)

- Frontend en **Angular 21**, organizado por *features*: auth, chat,
  assessment, filters, results, reports, profile.
- Mostrar el flujo real de pantallas: inicio → filtros (gestión, tipo de
  institución, presupuesto) → chat → resultados/reporte.
- Resaltar que el diseño precarga contexto (filtros) antes de la conversación
  para que el agente no tenga que preguntar todo desde cero.
- *En pantalla:* navegar la app desplegada en vivo si el ambiente `dev` está
  arriba (mismo enlace citado en la Sección 8 del informe), o en su defecto
  la Figura de filtros (`fig-evidencia-filtros.png`) y la de inicio
  (`fig-evidencia-frontend-home.png`).

## 5. Fabiola Tapara — Demo funcional en vivo + resultados y evaluación (4:00, Secciones 7–8)

Este es el bloque que la rúbrica pide explícitamente ("demostración funcional
del sistema incluida en la exposición"), así que **debe ser pantalla en vivo
de la app**, no solo capturas. Con 4:00 no alcanza para todo el detalle del
guion original — priorizar la demo en vivo (primeros 3 puntos) y comprimir la
evaluación al mínimo (último punto, una sola frase con las cifras clave).

- Conversación real en el ambiente `dev`: completar (o mostrar ya completada)
  la entrevista RIASEC escalonada y pedir recomendaciones.
- Mostrar el ranking por afinidad y, si el tiempo alcanza, la consulta con
  `search_programs` (ejemplo: Medicina en Arequipa) que trae costo, ingreso,
  admisión y duración **reales** del portal MINEDU.
- **Ser preciso sobre el alcance** (igual que el informe, para no
  contradecirlo en cámara): la afinidad RIASEC es el único criterio que hoy
  se combina en un puntaje; los otros cuatro ya se consultan con datos reales,
  pero la función que los combina en un solo ranking ponderado es el
  principal trabajo pendiente. Una frase basta, no hace falta extenderse.
- Cierre rápido de evaluación en una sola frase: suite de **evals (30/30
  casos)** en CI y prueba de consistencia del motor offline (costo vs.
  ingreso) — sin entrar al detalle de LangSmith, que Angel ya mencionó.
- *En pantalla:* la app en vivo (prioridad), y si se corta la conexión,
  Figuras `fig-evidencia-ranking-icr.png` y `fig-evidencia-caso3-explicacion.png`
  como respaldo grabado de antemano.

## 6. Cierre — Conclusiones y recomendaciones (1:20, Secciones 9–10)

Puede cerrarlo David solo (para no fragmentar más el video) o repartirse en
frases de 10-15s cada uno; lo importante es que quede claro sin alargarse:

- Logro principal: agente conversacional + pipeline de datos + MLOps (DVC,
  LangSmith, evals, CI/CD) funcionando end-to-end, con el motor de scoring de
  5 criterios diseñado y el primero (afinidad) ya integrado.
- Aprendizaje/dificultad breve (elegir una): coordinar 5 repos y ramas, o
  integrar el LLM con el resto de la arquitectura AWS.
- Trabajo futuro en una frase: componente RAG, migración a **Mi Carrera**, y
  completar la integración del motor de scoring con los 4 criterios
  restantes.
- Agradecimiento y cierre.

---

## Checklist antes de grabar

- [ ] Cada integrante ensaya su bloque una vez con cronómetro antes de la
      toma final (el tiempo real de habla suele ser mayor que el estimado
      leyendo).
- [ ] Fabiola confirma que el ambiente `dev` responde **antes** de grabar
      (si el agente/ECS estuvo dormido, la primera respuesta puede tardar).
- [ ] Grabar el bloque de demo (5) con una captura de respaldo por si el
      streaming SSE falla en vivo.
- [ ] Revisar audio/iluminación de cada segmento antes de unir el video final.
- [ ] Sumar los tiempos reales del video final y confirmar que no supera
      **15:00** antes de subirlo.
- [ ] Pegar el enlace final del video en la Sección 12 del informe
      (`sections/12-exposicion.tex`, recuadro "ENLACE DEL VIDEO") y
      recompilar; si no da tiempo, pegar el link directo en el PDF exportado.
