# Spark Match: Copiloto de Orientación Vocacional con IA Generativa

Trabajo de Fin de Programa del **II Programa de Especialización en IA Generativa y Machine Learning Ops** de la **Universidad Nacional de Ingeniería (UNI)**.

Artículo académico que documenta el diseño, implementación, despliegue y evaluación de **Spark Match**, un sistema híbrido que combina un agente conversacional basado en LLMs (harness `deepagents` + AWS Bedrock) con un motor de scoring determinista para recomendar combinaciones *Carrera - Universidad* a estudiantes preuniversitarios peruanos.

---

## Stack Técnico

| Capa | Tecnología |
|:---|:---|
| IA Generativa | AWS Bedrock (Claude), Deep Agents (harness `deepagents`), langmem |
| Agente y scoring | Python (harness `deepagents`, Pandas, NumPy) |
| Backend | TypeScript serverless (AWS Lambda, EventBridge, AWS SAM, DDD) |
| Frontend | Angular 21 + Angular Material |
| Datos | Ponte en Carrera (features.csv), Selenium, Pandas, RDS PostgreSQL |
| MLOps | LangSmith, DVC, GitHub Actions |
| DevOps | Terraform (dev/prod), AWS, checkov, tflint, AWS Budgets |
| Documentación | LaTeX (artículo) |

---

## Ecosistema de Repositorios

Este artículo forma parte del ecosistema **`spark-match`**:

| Componente | Repositorio | Descripción |
|:---|:---|:---|
| DevOps / CI/CD | [`spark-match-01-devops`](https://github.com/spark-match/spark-match-01-devops) | GitHub Actions reutilizables, Apidog tests |
| Infraestructura | [`spark-match-02-infrastructure`](https://github.com/spark-match/spark-match-02-infrastructure) | Terraform para AWS (VPC, Lambda, EventBridge, ECS Fargate, RDS PostgreSQL, S3) |
| Backend | [`spark-match-03-backend`](https://github.com/spark-match/spark-match-03-backend) | Serverless TypeScript (Lambda + EventBridge + SAM) |
| Frontend | [`spark-match-04-frontend`](https://github.com/spark-match/spark-match-04-frontend) | Angular SPA conversacional |
| Pipeline de Datos | [`spark-match-05-data-pipeline`](https://github.com/spark-match/spark-match-05-data-pipeline) | ETL + scraping con Selenium + etiquetado RIASEC |
| Entrenamiento | [`spark-match-06-model-training`](https://github.com/spark-match/spark-match-06-model-training) | Experimentos y seguimiento con Weights & Biases |
| Artículo | [`spark-match-07-article`](https://github.com/spark-match/spark-match-07-article) | Este repositorio -- LaTeX con CI/CD |
| Agente conversacional | [`spark-match-08-deep-agent`](https://github.com/spark-match/spark-match-08-deep-agent) | Deep Agent (harness `deepagents`) + langmem + evals |

---

## Estructura del Repositorio

```
spark-match-07-article/
|-- main.tex                        # Documento principal
|-- references.bib                  # Referencias BibTeX (formato APA, min. 5)
|-- config/
|   |-- preamble.tex                # Paquetes y configuracion global
|-- sections/
|   |-- 01-use-case.tex             # Descripcion del caso de uso
|   |-- 02-model-data.tex           # Seleccion de modelo y datos
|   |-- 03-prompts.tex              # Ingenieria de prompts y RAG
|   |-- 04-implementation.tex       # Implementacion de la aplicacion
|   |-- 05-orchestration.tex        # Orquestacion y despliegue
|   |-- 06-monitoring.tex           # Monitoreo y mantenimiento
|   |-- 07-evaluation.tex           # Evaluacion de la aplicacion
|   |-- 08-results.tex              # Resultados y demostracion
|   |-- 09-conclusions.tex          # Conclusiones
|   |-- 10-recommendations.tex      # Recomendaciones
|-- figures/                        # PNG que main.tex incluye
|   |-- mermaid/                    # Fuentes .mmd de los diagramas + autocrop.py
|-- DOCS/
|   |-- TFP-GUIDELINES.md           # Requisitos del TFP
|   |-- RUBRICA-PROGRAMA.md         # Rubrica de evaluacion
|   |-- pre-evaluaciones/           # Proyecciones de nota
|   |-- issues/issues-v1/           # Seguimiento de trabajo pendiente
|-- compile.ps1                     # Compilador PowerShell
|-- compile.bat                     # Compilador CMD
|-- scripts/
|   |-- build.sh                    # Compilador Linux/macOS
|   |-- clean.sh                    # Limpieza de archivos auxiliares
|   |-- watch.sh                    # Recompilacion automatica
|-- .latexmkrc                      # Configuracion de latexmk
|-- .gitattributes                  # Normalizacion de line endings
|-- .github/
|   |-- CODEOWNERS                  # Revisores requeridos por path
|   |-- workflows/ci.yml            # Compila el PDF en cada pull request
|   |-- workflows/cd.yml            # Tag + GitHub Release al mergear
```

Los PNG de `figures/` **se generan** desde los `.mmd` de `figures/mermaid/`. Al
cambiar un diagrama hay que editar el `.mmd`, no el PNG: ver
`figures/mermaid/README.md`.

---

## Compilación del Artículo

### Requisitos

- **Windows:** [MiKTeX](https://miktex.org/) con `pdflatex` y `bibtex`
- **Linux/macOS:** [TeX Live](https://tug.org/texlive/) (`texlive-full` o equivalente)
- **Paquetes LaTeX:** `babel-spanish`, `amsmath`, `tikz`, `listings`, `algorithms`, `booktabs`, `tcolorbox`, `hyperref`, `natbib`

### Windows -- PowerShell

```powershell
.\compile.ps1
```

### Windows -- CMD

```cmd
compile.bat
```

### Linux / macOS

```bash
chmod +x scripts/*.sh
./scripts/build.sh
```

### Modo watch (recompilación automática)

```bash
./scripts/watch.sh
```

### Resultado

El PDF generado se ubica en `main.pdf` (excluido del repositorio vía `.gitignore`).

---

## CI/CD (GitHub Actions)

El pipeline está dividido en dos workflows independientes bajo `.github/workflows/`:

| Workflow | Trigger | Acción |
|:---|:---|:---|
| **CI** (`ci.yml`) | Pull Request `opened` / `synchronize` / `reopened` hacia `main` | Compila el PDF y lo publica como artifact `spark-match-paper-pr-<N>` para que los revisores descarguen la previsualización. No crea tags ni releases. |
| **CD** (`cd.yml`) | Pull Request `closed` con `merged == true` hacia `main` | Compila el PDF, hace auto-bump de la versión patch desde el último tag, crea el nuevo tag `vX.Y.Z` y publica un GitHub Release con el PDF adjunto. |

### Versionado automático

El CD lee el tag más reciente (`git describe --tags --abbrev=0`) e incrementa el componente **patch**:

- Sin tags previos → `v0.0.1`
- Último tag `v0.2.4` → `v0.2.5`
- Para un bump **major** o **minor** (ej. `v1.0.0`) crea el tag manualmente antes del merge:

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Flujo de trabajo recomendado

1. Crear una rama feature: `git checkout -b feat/seccion-04`
2. Hacer commits y push: `git push origin feat/seccion-04`
3. Abrir Pull Request hacia `main` → **CI** compila y sube el PDF como artifact
4. Revisar el PDF descargado, pedir cambios o aprobar
5. Al hacer merge → **CD** crea el release `v0.0.X` con el PDF final

---

## Rubrica del TFP (UNI)

El documento cubre las 12 secciones de la rúbrica del Trabajo de Fin de Programa (20 puntos):

1. Descripción del caso de uso (1 pt) -- `01-use-case.tex`
2. Selección de modelo y datos (1 pt) -- `02-model-data.tex`
3. Ingeniería de prompts y adaptación (2 pt) -- `03-prompts.tex`
4. Implementación de la aplicación (3 pt) -- `04-implementation.tex`
5. Orquestación y despliegue (2 pt) -- `05-orchestration.tex`
6. Monitoreo y mantenimiento (2 pt) -- `06-monitoring.tex`
7. Evaluación de la aplicación (2 pt) -- `07-evaluation.tex`
8. Resultados y demostración (2 pt) -- `08-results.tex`
9. Conclusiones (1 pt) -- `09-conclusions.tex`
10. Recomendaciones (1 pt) -- `10-recommendations.tex`
11. Referencias bibliográficas APA (1 pt) -- `references.bib`
12. Link de exposición (2 pt) -- sección *Resultados*

---

## Fechas clave

- **Avance:** domingo 14/06/2026 hasta las 23:00 horas
- **Entrega final:** domingo 09/08/2026 a las 13:00 horas

---

## Autores

- Fabiola G. Tapara Quispe
- Angel E. Hincho Jove
- Andy B. Huamani Tacoma
- Nikolai A. Asencios García
- David Barreto Lara

**Programa:** II Programa de Especialización en IA Generativa y Machine Learning Ops
**Institución:** Universidad Nacional de Ingeniería (UNI) -- Facultad de Ingeniería Económica, Estadística y Ciencias Sociales

---

## Licencia

Este proyecto está licenciado bajo los términos de la [Licencia MIT](https://opensource.org/licenses/MIT).

Copyright (c) 2026 Spark Match Team.