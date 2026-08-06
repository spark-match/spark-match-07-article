# 5. Rúbrica de evaluación — Entrega final (20 puntos)

La siguiente rúbrica define los descriptores de desempeño para cada uno de los 12 criterios del TFP. Se utilizan cuatro niveles: **Destacado** (100% del puntaje), **Logrado** (75%), **En proceso** (50%) y **No logrado** (0-25%). Esta rúbrica es la referencia para la evaluación de la entrega final del **09 de agosto de 2026**.

---

## Criterio 1 — Descripción del caso de uso (1 pt)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Contexto detallado del negocio o industria, problema claramente cuantificado, justificación explícita de IA Generativa y MLOps, objetivo de negocio y técnico diferenciados, fuentes académicas o de datos que respaldan la relevancia. |
| **Logrado (75%)** | Contexto y problema descritos con claridad, justificación del uso de IA Generativa presente, objetivos definidos aunque sin diferenciar claramente el técnico del de negocio, al menos 1 fuente relevante. |
| **En proceso (50%)** | Descripción general del contexto sin cuantificar el problema, justificación del uso de IA vaga o genérica, objetivos poco específicos o confundidos entre sí. |
| **No logrado (<25%)** | Descripción ausente, superficial o no relacionada con el enunciado. Sin justificación ni objetivos definidos. |

**Puntaje máximo: 1 pt**

---

## Criterio 2 — Selección de modelo y datos (1 pt)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Modelo generativo/fundacional seleccionado con justificación comparativa (tabla de alternativas). Dataset identificado con fuente, estructura y volumetría documentadas. Preprocesamiento y embeddings descritos con lógica clara y código adjunto. |
| **Logrado (75%)** | Modelo seleccionado con justificación básica. Dataset con fuente identificada y estructura descrita. Preprocesamiento mencionado aunque sin detalle de embeddings. |
| **En proceso (50%)** | Modelo mencionado sin justificación comparativa. Dataset identificado pero sin descripción de estructura o preprocesamiento. |
| **No logrado (<25%)** | Modelo no seleccionado o mencionado sin ninguna justificación. Dataset ausente o sin ningún detalle. |

**Puntaje máximo: 1 pt**

---

## Criterio 3 — Ingeniería de prompts y adaptación (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Estrategia de prompting documentada (zero-shot, few-shot, chain-of-thought o RAG) con ejemplos reales de prompts y resultados. Ajustes finos o adapters evaluados. Integración de datos externos (base vectorial u otro) implementada o justificada. |
| **Logrado (75%)** | Estrategia de prompting definida y documentada con al menos un ejemplo de prompt. Ajuste fino o uso de adapters mencionado con justificación. Base vectorial planificada. |
| **En proceso (50%)** | Prompting mencionado sin documentar la estrategia ni ejemplos concretos. Sin evidencia de ajuste fino ni integración de datos externos. |
| **No logrado (<25%)** | Sin estrategia de prompting documentada, sin ejemplos y sin consideración de ajuste fino ni datos externos. |

**Puntaje máximo: 2 pts**

---

## Criterio 4 — Implementación de la aplicación (3 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Flujo de la solución documentado con diagrama y código funcional. Integración real entre LLM, API, base de datos e interfaz de usuario. Arquitectura modular y escalable verificable en el repositorio con pruebas de funcionamiento. |
| **Logrado (75%)** | Flujo documentado y la mayoría de componentes integrados con código funcional. Interfaz básica operativa. Modularidad visible en la estructura del repositorio. |
| **En proceso (50%)** | Diagrama de arquitectura presente pero implementación parcial: algunos componentes sin integrar o solo como esqueleto con TODOs. Sin interfaz funcional. |
| **No logrado (<25%)** | Sin implementación funcional, sin flujo documentado con código o solo existe el diseño sin ningún componente ejecutable. |

**Puntaje máximo: 3 pts**

---

## Criterio 5 — Orquestación y despliegue (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | API (FastAPI u otro) funcional con endpoints documentados. Docker y docker-compose.yml operativos. Pipeline CI/CD con GitHub Actions configurado y probado. Despliegue en Kubernetes, servicio cloud o servidor local con enlace funcional. |
| **Logrado (75%)** | API funcional y Dockerfile operativo. CI/CD configurado aunque no completamente probado. Despliegue en algún servicio (no necesariamente Kubernetes). |
| **En proceso (50%)** | API como esqueleto con endpoints definidos. Dockerfile presente pero sin prueba de funcionamiento. Sin CI/CD ni despliegue real. |
| **No logrado (<25%)** | Sin API funcional, sin Docker operativo, sin CI/CD y sin ninguna evidencia de despliegue. |

**Puntaje máximo: 2 pts**

---

## Criterio 6 — Monitoreo y mantenimiento (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Estrategia de monitoreo implementada (MLflow, LangSmith, Prometheus u otro) con métricas reales de desempeño en producción. Gestión de drift documentada con alertas configuradas. Logging funcional con ejemplos. |
| **Logrado (75%)** | Herramienta de monitoreo configurada y al menos una métrica de desempeño registrada. Logging básico implementado. Drift mencionado con plan de acción. |
| **En proceso (50%)** | Monitoreo mencionado como herramienta planificada pero sin implementación. Sin métricas, logging ni gestión de drift reales. |
| **No logrado (<25%)** | Sin ninguna estrategia de monitoreo, sin métricas, sin logging y sin consideración de drift. |

**Puntaje máximo: 2 pts**

---

## Criterio 7 — Evaluación de la aplicación (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Métricas apropiadas al tipo de sistema implementadas (Recall@K, BLEU, ROUGE, F1, satisfacción de usuario, etc.). Casos de prueba documentados con resultados reales. Comparación de al menos dos enfoques. Limitaciones detectadas y documentadas. |
| **Logrado (75%)** | Al menos una métrica técnica implementada con resultados reales. Algunos casos de prueba documentados. Limitaciones identificadas. |
| **En proceso (50%)** | Métricas mencionadas conceptualmente pero sin implementación ni resultados. Sin casos de prueba reales. |
| **No logrado (<25%)** | Sin métricas definidas, sin casos de prueba y sin evaluación del sistema. |

**Puntaje máximo: 2 pts**

---

## Criterio 8 — Resultados y demostración (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Ejemplos reales de respuestas del modelo documentados. Capturas funcionales de la API (Postman, Swagger o similar). Video demostrativo o enlace a demo en la nube que muestra el sistema end-to-end en operación. |
| **Logrado (75%)** | Al menos 3 ejemplos de respuestas del modelo. Capturas de la API o interfaz funcional. Video corto o enlace parcialmente funcional. |
| **En proceso (50%)** | Solo mockup visual o respuestas simuladas. Sin evidencia funcional real del sistema en ejecución. |
| **No logrado (<25%)** | Sin outputs reales, sin capturas funcionales y sin ninguna evidencia demostrativa del sistema. |

**Puntaje máximo: 2 pts**

---

## Criterio 9 — Conclusiones (1 pt)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Reflexión crítica sobre logros, dificultades y aprendizajes específicos del proyecto. Evaluación del impacto real o potencial en el negocio o industria con datos o evidencia que lo respalde. |
| **Logrado (75%)** | Conclusiones claras sobre los principales logros y dificultades. Alusión al impacto en el negocio aunque sin cuantificarlo. |
| **En proceso (50%)** | Conclusiones genéricas o resúmenes del trabajo sin reflexión crítica sobre dificultades ni impacto. |
| **No logrado (<25%)** | Sin conclusiones o con conclusiones que no guardan relación con el proyecto desarrollado. |

**Puntaje máximo: 1 pt**

---

## Criterio 10 — Recomendaciones (1 pt)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Acciones futuras específicas y priorizadas. Plan de escalabilidad con hoja de ruta. Mejoras concretas en modelo, despliegue o monitoreo. Potenciales nuevas aplicaciones del sistema documentadas. |
| **Logrado (75%)** | Al menos dos recomendaciones específicas y fundamentadas. Mención de escalabilidad o mejoras futuras. |
| **En proceso (50%)** | Recomendaciones genéricas o aplicables a cualquier proyecto de IA, sin especificidad al caso desarrollado. |
| **No logrado (<25%)** | Sin sección de recomendaciones o con contenido que no aporta información accionable. |

**Puntaje máximo: 1 pt**

---

## Criterio 11 — Referencias bibliográficas (1 pt)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Mínimo 5 referencias en formato APA correcto, actualizadas (preferentemente 2018 o posterior), directamente relacionadas con el tema del proyecto y citadas en el cuerpo del documento. |
| **Logrado (75%)** | Mínimo 5 referencias en formato APA con errores menores. La mayoría citadas en el cuerpo del documento. |
| **En proceso (50%)** | Menos de 5 referencias, o formato APA con errores sistemáticos, o referencias no citadas en el texto. |
| **No logrado (<25%)** | Sin referencias o con formato incorrecto que impide verificar las fuentes. |

**Puntaje máximo: 1 pt**

---

## Criterio 12 — Link de exposición (video) (2 pts)

| Nivel | Descriptor |
|---|---|
| **Destacado (100%)** | Video de máximo 15 minutos donde todos los integrantes exponen siguiendo la estructura del informe. Audio y video claros. Demostración funcional del sistema incluida en la exposición. |
| **Logrado (75%)** | Video de máximo 15 minutos con participación de todos los integrantes. Exposición ordenada aunque sin demostración funcional completa. |
| **En proceso (50%)** | Video presente pero con duración excedida, participación incompleta de integrantes o sin seguir la estructura del informe. |
| **No logrado (<25%)** | Sin video, enlace roto o video que no corresponde al proyecto evaluado. |

**Puntaje máximo: 2 pts**