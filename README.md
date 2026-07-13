# Spark Match: Copiloto de Orientaci\'on Vocacional con IA Generativa

Trabajo de Fin de Programa del **II Programa de Especializaci\'on en IA Generativa y Machine Learning Ops** de la **Universidad Nacional de Ingenier\'ia (UNI)**.

Art\'iculo acad\'emico que documenta el dise\~no, implementaci\'on, despliegue y evaluaci\'on de **Spark Match**, un sistema h\'ibrido que combina un agente conversacional basado en LLMs (LangGraph + AWS Bedrock) con un motor de scoring determinista para recomendar combinaciones *Carrera - Universidad* a estudiantes preuniversitarios peruanos.

---

## Stack T\'ecnico

| Capa | Tecnolog\'ia |
|:---|:---|
| IA Generativa | AWS Bedrock (Claude), LangGraph / Deep Agents, langmem |
| Agente y scoring | Python (LangGraph, Pandas, NumPy) |
| Backend | TypeScript serverless (AWS Lambda, EventBridge, AWS SAM, DDD) |
| Frontend | Angular 21 + Angular Material |
| Datos | Ponte en Carrera (features.csv), Selenium, Pandas, Aurora PostgreSQL |
| MLOps | LangSmith, Weights & Biases, GitHub Actions |
| DevOps | Terraform (dev/prod), AWS, checkov, tflint, AWS Budgets |
| Documentaci\'on | LaTeX (art\'iculo) |

---

## Ecosistema de Repositorios

Este art\'iculo forma parte del ecosistema **`spark-match`**:

| Componente | Repositorio | Descripci\'on |
|:---|:---|:---|
| DevOps / CI/CD | [`spark-match-01-devops`](https://github.com/spark-match/spark-match-01-devops) | GitHub Actions reutilizables, Apidog tests |
| Infraestructura | [`spark-match-02-infrastructure`](https://github.com/spark-match/spark-match-02-infrastructure) | Terraform para AWS (VPC, ECS, RDS, S3) |
| Backend | [`spark-match-03-backend`](https://github.com/spark-match/spark-match-03-backend) | Serverless TypeScript (Lambda + EventBridge + SAM) |
| Frontend | [`spark-match-04-frontend`](https://github.com/spark-match/spark-match-04-frontend) | Angular SPA conversacional |
| Pipeline de Datos | [`spark-match-05-data-pipeline`](https://github.com/spark-match/spark-match-05-data-pipeline) | ETL + scraping con Selenium + etiquetado RIASEC |
| Entrenamiento | [`spark-match-06-model-training`](https://github.com/spark-match/spark-match-06-model-training) | Experimentos y seguimiento con Weights & Biases |
| Art\'iculo | [`spark-match-07-article`](https://github.com/spark-match/spark-match-07-article) | Este repositorio -- LaTeX con CI/CD |
| Agente conversacional | [`spark-match-08-deep-agent`](https://github.com/spark-match/spark-match-08-deep-agent) | Deep Agent (LangGraph) + langmem + evals |

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
|-- figures/                        # Imagenes y diagramas del articulo
|-- compile.ps1                     # Compilador PowerShell
|-- compile.bat                     # Compilador CMD
|-- scripts/
|   |-- build.sh                    # Compilador Linux/macOS
|   |-- clean.sh                    # Limpieza de archivos auxiliares
|   |-- watch.sh                    # Recompilacion automatica
|-- .latexmkrc                      # Configuracion de latexmk
|-- .github/workflows/ci.yml        # Pipeline CI/CD
```

---

## Compilaci\'on del Art\'iculo

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

### Modo watch (recompilaci\'on autom\'atica)

```bash
./scripts/watch.sh
```

### Resultado

El PDF generado se ubica en `main.pdf` (excluido del repositorio v\'ia `.gitignore`).

---

## CI/CD (GitHub Actions)

El pipeline est\'a dividido en dos workflows independientes bajo `.github/workflows/`:

| Workflow | Trigger | Acci\'on |
|:---|:---|:---|
| **CI** (`ci.yml`) | Pull Request `opened` / `synchronize` / `reopened` hacia `main` | Compila el PDF y lo publica como artifact `spark-match-paper-pr-<N>` para que los revisores descarguen la previsualizaci\'on. No crea tags ni releases. |
| **CD** (`cd.yml`) | Pull Request `closed` con `merged == true` hacia `main` | Compila el PDF, hace auto-bump de la versi\'on patch desde el \'ultimo tag, crea el nuevo tag `vX.Y.Z` y publica un GitHub Release con el PDF adjunto. |

### Versionado autom\'atico

El CD lee el tag m\'as reciente (`git describe --tags --abbrev=0`) e incrementa el componente **patch**:

- Sin tags previos $\rightarrow$ `v0.0.1`
- \'Ultimo tag `v0.2.4` $\rightarrow$ `v0.2.5`
- Para un bump **major** o **minor** (ej. `v1.0.0`) crea el tag manualmente antes del merge:

```bash
git tag v1.0.0
git push origin v1.0.0
```

### Flujo de trabajo recomendado

1. Crear una rama feature: `git checkout -b feat/seccion-04`
2. Hacer commits y push: `git push origin feat/seccion-04`
3. Abrir Pull Request hacia `main` $\rightarrow$ **CI** compila y sube el PDF como artifact
4. Revisar el PDF descargado, pedir cambios o aprobar
5. Al hacer merge $\rightarrow$ **CD** crea el release `v0.0.X` con el PDF final

---

## Rubrica del TFP (UNI)

El documento cubre las 12 secciones de la r\'ubrica del Trabajo de Fin de Programa (20 puntos):

1. Descripci\'on del caso de uso (1 pt) -- `01-use-case.tex`
2. Selecci\'on de modelo y datos (1 pt) -- `02-model-data.tex`
3. Ingenier\'ia de prompts y adaptaci\'on (2 pt) -- `03-prompts.tex`
4. Implementaci\'on de la aplicaci\'on (3 pt) -- `04-implementation.tex`
5. Orquestaci\'on y despliegue (2 pt) -- `05-orchestration.tex`
6. Monitoreo y mantenimiento (2 pt) -- `06-monitoring.tex`
7. Evaluaci\'on de la aplicaci\'on (2 pt) -- `07-evaluation.tex`
8. Resultados y demostraci\'on (2 pt) -- `08-results.tex`
9. Conclusiones (1 pt) -- `09-conclusions.tex`
10. Recomendaciones (1 pt) -- `10-recommendations.tex`
11. Referencias bibliogr\'aficas APA (1 pt) -- `references.bib`
12. Link de exposici\'on (2 pt) -- secci\'on *Resultados*

---

## Fechas clave

- **Avance:** domingo 14/06/2026 hasta las 23:00 horas
- **Entrega final:** domingo 09/08/2026 a las 13:00 horas

---

## Autores

- Fabiola G. Tapara Quispe
- Angel E. Hincho Jove
- Andy B. Huamani Tacoma
- Nikolai A. Asencios Garc\'ia
- David Barreto Lara

**Programa:** II Programa de Especializaci\'on en IA Generativa y Machine Learning Ops
**Instituci\'on:** Universidad Nacional de Ingenier\'ia (UNI) -- Facultad de Ingenier\'ia Econ\'omica, Estad\'istica y Ciencias Sociales

---

## Licencia

Este proyecto est\'a licenciado bajo los t\'erminos de la [Licencia MIT](https://opensource.org/licenses/MIT).

Copyright (c) 2026 Spark Match Team.