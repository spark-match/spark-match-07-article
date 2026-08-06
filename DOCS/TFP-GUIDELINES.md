# TRABAJO DE FIN DE PROGRAMA
**2026-01**

## 1. Objetivo

El presente documento define el Trabajo de Fin de Programa, el cual permite evaluar el logro del Programa de Especialización en IA Generativa y Machine Learning Ops. El objetivo es consolidar los conocimientos adquiridos a lo largo de la especialización mediante el desarrollo de un caso aplicado que integre modelos fundacionales, IA generativa, arquitecturas de agentes y prácticas de MLOps en un entorno real o simulado de negocio.

## 2. Logro del curso

### Competencia General

Diseña, implementa y lidera soluciones basadas en Inteligencia Artificial Generativa y Machine Learning Ops, aplicando modelos fundacionales, arquitecturas modernas y flujos de MLOps que transformen datos en valor estratégico para la toma de decisiones en distintos sectores de la industria.

### Competencias Específicas

- Aplica modelos generativos y fundacionales (LLMs, modelos multimodales, agentes) en la resolución de problemas reales.
- Despliega modelos de machine learning en entornos productivos utilizando herramientas de MLOps (DVC, MLflow, FastAPI, Docker, Kubernetes).
- Integra arquitecturas de agentes y flujos RAG para el desarrollo de aplicaciones conversacionales y automatización de procesos.
- Evalúa y monitorea el desempeño de modelos desplegados mediante pruebas, métricas y detección de drift.
- Comunica de forma clara y efectiva los resultados y el impacto de las soluciones propuestas en el negocio.

## 3. Enunciado

El Trabajo de Fin de Programa consiste en aplicar los conocimientos adquiridos durante la especialización para desarrollar una solución completa de IA Generativa y MLOps. El proyecto debe abordar un problema de negocio o un caso industrial, desde la definición del caso de uso, procesamiento de datos, modelización y despliegue, hasta la documentación y exposición final de resultados.

## 4. Estructura del Informe

### 1. Descripción del caso de uso (1 punto)

- Contexto y problemática del negocio o industria.
- Justificación del uso de IA Generativa y MLOps.
- Objetivo de negocio y objetivo técnico del proyecto.
- Fuentes que respalden la relevancia del caso.

### 2. Selección de modelo y datos (1 punto)

- Elección del modelo generativo/fundacional (ej. GPT, LLaMA, CLIP, Diffusion).
- Arquitectura y características principales.
- Dataset utilizado: abierto (Kaggle, HuggingFace, etc.), propio o sintético.
- Preprocesamiento de datos y embeddings (si aplica).

### 3. Ingeniería de prompts y adaptación (2 puntos)

- Estrategia de prompting (zero/few-shot, chain-of-thought, RAG).
- Ajustes finos: fine-tuning, LoRA, adapters.
- Integración de datos externos (ej. bases vectoriales).

### 4. Implementación de la aplicación (3 puntos)

- Descripción del flujo de la solución (ej. arquitectura de agentes con LangChain/LangGraph).
- Integración de componentes (API externa, bases de datos, interfaces de usuario).
- Diseño modular y escalable del sistema.

### 5. Orquestación y despliegue (2 puntos)

- Creación de API (FastAPI, Flask, etc.) para servir el modelo.
- Contenerización con Docker.
- Automatización con CI/CD (GitHub Actions).
- Despliegue en Kubernetes u otro servicio.

### 6. Monitoreo y mantenimiento (2 puntos)

- Estrategias de monitoreo (MLflow, LangSmith, Prometheus, etc.).
- Métricas de desempeño en producción.
- Gestión de drift, logging y alertas.

### 7. Evaluación de la aplicación (2 puntos)

- Métricas empleadas (BLEU, ROUGE, F1, precisión, recall, satisfacción de usuario, etc.).
- Casos de prueba, validación y comparación de enfoques.
- Limitaciones detectadas.

### 8. Resultados y demostración (2 puntos)

- Outputs principales: ejemplos de respuestas del modelo, capturas de API o visualizaciones.
- Evidencia funcional: enlace a demo en la nube o video corto mostrando la app corriendo en VS Code (terminal, navegador o Postman).

### 9. Conclusiones (1 punto)

- Reflexión sobre logros, dificultades y aprendizajes.
- Evaluación del impacto del proyecto en el negocio o industria.

### 10. Recomendaciones (1 punto)

- Acciones futuras y escalabilidad.
- Mejoras en modelos, despliegue o monitoreo.
- Potenciales nuevas aplicaciones.

### 11. Referencias bibliográficas (1 punto)

Mínimo 5 referencias redactadas según las normas APA: https://normasapa.org/referencias/

### 12. Link de exposición (2 puntos)

- Video de máximo 15 minutos.
- Todos los integrantes deben participar.

## 5. Acerca del grupo de trabajo

El Trabajo de Fin de Programa se deberá desarrollar en grupos de 3 a 5 integrantes.

## 6. Lenguaje de programación

Las tareas del Trabajo de Fin de Programa deben estar desarrolladas principalmente en Python, dado que es el lenguaje estándar para proyectos de IA Generativa y MLOps. Además, las herramientas desarrolladas en el programa.

Se recomienda el uso de librerías y frameworks como:

- **IA Generativa:** Transformers (HuggingFace), LangChain, LlamaIndex, Diffusers, OpenAI API.
- **MLOps:** MLflow, DVC, FastAPI, Docker, Kubernetes, GitHub Actions.
- **Machine Learning/Deep Learning:** PyTorch, TensorFlow, scikit-learn.

Opcionalmente, se pueden emplear notebooks (Jupyter/Colab) para la experimentación y pruebas.

## 7. Exposición

La exposición es parte de la evaluación del Trabajo de Fin de Programa, la cual deberá ser grabada y adjuntada mediante un link según la estructura del informe descrito en el punto 4.

La calificación de la exposición es individual y deberá durar en total por grupo máximo 15 minutos. Por lo tanto, todos los integrantes tienen que exponer.

## 8. Entregables vía plataforma CANVAS

Cada grupo deberá entregar los siguientes archivos, según el tipo de caso de uso:

- Caso de uso aplicado / desarrollo de agente en VS Code
- **TFP_XXX_YYY_ZZZ.docx** → Informe final del proyecto (Word o PDF).
- Repositorio comprimido (.zip) o enlace a GitHub con:
  - Código fuente (archivos .py, .yaml, .toml, etc.).
  - Archivos de despliegue (requirements.txt, Dockerfile, docker-compose.yml, README.md).
  - Carpeta `notebooks/` (si se usaron notebooks auxiliares).
  - Carpeta `data/` (si el dataset es propio o sintético).

**Nota:**

- Los caracteres XXX, YYY, ZZZ corresponden al primer apellido de los integrantes del grupo.
- En caso de tener un agente desplegado en la nube o servidor local, debe incluirse el link funcional en el informe y/o un video demostrativo en la exposición.