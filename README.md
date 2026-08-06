# Spark Match: An AI Copilot for Career Guidance

Final project (*Trabajo de Fin de Programa*) of the **II Programa de Especializacion en IA Generativa y Machine Learning Ops** at the **Universidad Nacional de Ingenieria (UNI)**, Lima, Peru.

This repository holds the academic paper: LaTeX sources, BibTeX references, Mermaid diagram sources and the toolchain that compiles them into a PDF. **The paper itself is written in Spanish**, since that is the language of the programme it is submitted to. This README and the community documents are in English to match the rest of the `spark-match` organisation.

The paper documents the design, implementation, deployment and evaluation of **Spark Match**, a hybrid system that pairs an LLM-based conversational agent (`deepagents` harness on AWS Bedrock) with a deterministic scoring engine, to recommend *degree programme + university* combinations to Peruvian secondary-school students.

---

## What this repository is not

It ships no runtime, no service and no library. Nothing here is deployed. The only build output is `main.pdf`, published as a GitHub Release on every merge.

The platform the paper describes lives in the other repositories listed below. A finding about the agent, the API or the infrastructure belongs there, not here.

---

## Repository ecosystem

| Component | Repository | Description |
|:---|:---|:---|
| DevOps / CI/CD | [`spark-match-01-devops`](https://github.com/spark-match/spark-match-01-devops) | Reusable GitHub Actions workflows, governance tooling |
| Infrastructure | [`spark-match-02-infrastructure`](https://github.com/spark-match/spark-match-02-infrastructure) | Terraform for AWS (VPC, Lambda, EventBridge, ECS Fargate, RDS PostgreSQL, S3) |
| Backend | [`spark-match-03-backend`](https://github.com/spark-match/spark-match-03-backend) | Serverless TypeScript (Lambda + EventBridge + SAM) |
| Frontend | [`spark-match-04-frontend`](https://github.com/spark-match/spark-match-04-frontend) | Angular conversational SPA |
| Data pipeline | [`spark-match-05-data-pipeline`](https://github.com/spark-match/spark-match-05-data-pipeline) | ETL, Selenium scraping, RIASEC labelling |
| Model training | [`spark-match-06-model-training`](https://github.com/spark-match/spark-match-06-model-training) | Experiments and tracking with Weights & Biases |
| Paper | [`spark-match-07-article`](https://github.com/spark-match/spark-match-07-article) | This repository -- LaTeX with CI/CD |
| Conversational agent | [`spark-match-08-deep-agent`](https://github.com/spark-match/spark-match-08-deep-agent) | Deep Agent (`deepagents` harness) + langmem + evals |

The stack described in the paper: AWS Bedrock (Claude) and the `deepagents` harness with langmem for the agent; Python with Pandas and NumPy for scoring; serverless TypeScript on AWS Lambda, EventBridge and SAM for the backend; Angular 21 with Angular Material for the frontend; Ponte en Carrera (MINEDU) as the data source, ingested with Selenium and Pandas into RDS PostgreSQL; LangSmith, DVC and GitHub Actions for MLOps; Terraform with checkov, tflint and AWS Budgets for infrastructure.

---

## Repository layout

```
spark-match-07-article/
|-- main.tex                          Title page, abstract, resource table, \input of every section
|-- references.bib                    BibTeX references, apalike style (8 entries)
|-- config/
|   |-- preamble.tex                  Packages and global configuration
|-- sections/                         Every file is \input from main.tex, in this order
|   |-- 01-use-case.tex               Use case description
|   |-- 02-model-data.tex             Model and data selection
|   |-- 03-prompts.tex                Prompt engineering and RAG
|   |-- 04-implementation.tex         Application implementation
|   |-- 05-orchestration.tex          Orchestration and deployment
|   |-- 06-monitoring.tex             Monitoring and maintenance
|   |-- 07-evaluation.tex             Application evaluation
|   |-- 08-results.tex                Results and demo
|   |-- 09-conclusions.tex            Conclusions
|   |-- 10-recommendations.tex        Recommendations
|-- figures/                          The 7 PNGs main.tex includes
|   |-- mermaid/                      The 7 .mmd sources, autocrop.py, and their README
|-- DOCS/
|   |-- TFP-GUIDELINES.md             Programme requirements for the final project
|   |-- RUBRICA-PROGRAMA.md           Grading rubric
|   |-- pre-evaluaciones/             Grade projections
|   |-- issues/issues-v1/             Outstanding work, 00-INDEX.md plus 12 items
|-- scripts/
|   |-- build.sh                      Linux/macOS build (latexmk, falls back to pdflatex)
|   |-- clean.sh                      Remove LaTeX auxiliary files
|   |-- watch.sh                      Rebuild on change (latexmk -pvc)
|-- compile.ps1                       Windows build, PowerShell
|-- compile.bat                       Windows build, CMD
|-- .latexmkrc                        latexmk configuration: pdf_mode, synctex, bibtex
|-- .gitattributes                    Line-ending normalisation
|-- .gitignore                        Excludes main.pdf and LaTeX auxiliary files
|-- .github/
|   |-- CODEOWNERS                    Required reviewers per path
|   |-- workflows/ci.yml              Compiles the PDF on pull requests that touch the paper
|   |-- workflows/cd.yml              Tag and GitHub Release on merge
|-- LICENSE                           CC BY-SA 4.0, full legal code
|-- README.md                         This file
|-- CONTRIBUTING.md                   How to propose a change
|-- CODE_OF_CONDUCT.md                Contributor Covenant 2.1
|-- SECURITY.md                       What to report and through which private channel
```

The PNGs under `figures/` are **generated** from the `.mmd` sources in `figures/mermaid/`. To change a diagram, edit the `.mmd` and regenerate; editing the PNG directly is lost on the next regeneration. See [`figures/mermaid/README.md`](figures/mermaid/README.md).

---

## Building the paper

### Requirements

- **Windows:** [MiKTeX](https://miktex.org/) with `pdflatex` and `bibtex`
- **Linux/macOS:** [TeX Live](https://tug.org/texlive/) (`texlive-full` or equivalent)
- **LaTeX packages:** `babel-spanish`, `amsmath`, `tikz`, `listings`, `algorithms`, `booktabs`, `tcolorbox`, `hyperref`, `natbib`

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
chmod +x scripts/*.sh && ./scripts/build.sh
```

### Watch mode

```bash
./scripts/watch.sh
```

### Output

`main.pdf`, at the repository root. It is excluded by `.gitignore`: the PDF is a build output, and the published copies are the GitHub Release assets.

---

## CI/CD

Two independent workflows under `.github/workflows/`. Both are thin callers of reusable workflows that live in [`spark-match-01-devops`](https://github.com/spark-match/spark-match-01-devops), so the build logic is versioned once for the whole organisation.

| Workflow | Trigger | What it does |
|:---|:---|:---|
| **CI** (`ci.yml`) | Pull request `opened` / `synchronize` / `reopened` against `main`, **filtered by path** | Compiles the PDF and uploads it as artifact `spark-match-paper-pr-<N>`, retained 14 days, so reviewers read the rendered paper instead of the diff. Creates no tags and no releases. |
| **CD** (`cd.yml`) | Pull request `closed` with `merged == true` against `main` | Compiles the PDF from the merge commit, bumps the patch version, creates tag `vX.Y.Z` and publishes a GitHub Release with the PDF attached. |

### The CI path filter, and why no check is required

CI only runs when a pull request touches `**.tex`, `**.bib`, `figures/**` or `.github/workflows/**`. A pull request that only edits Markdown -- this README, `CONTRIBUTING.md`, anything under `DOCS/` -- produces **no CI run at all**, by design: there is nothing new to compile.

This is why the governance manifest in `spark-match-01-devops` lists **no required status checks** for this repository. A required check that a path filter can skip never reports, and GitHub blocks the pull request forever on *"Expected -- waiting for status to be reported"*. Merge protection comes from the ruleset instead: one approving review, code-owner review required, linear history, squash-only merges.

### Automatic versioning

CD reads the highest existing tag and increments the **patch** component. For a **major** or **minor** bump, create the tag by hand before merging:

```bash
git tag v1.0.0 && git push origin v1.0.0
```

Two things worth knowing, both found on 2026-08-06:

- The release is compiled from the **merge commit of its own pull request**, not from whatever `main` points at when the runner starts. Two merges in quick succession no longer produce two releases containing the same tree.
- If the computed tag already exists, the job now **fails** instead of replacing the release attached to it. It used to overwrite the published PDF in silence, with every job green. Tags `v0.0.6` and `v0.0.7` sit on the same commit as a leftover of that bug, and the asset under `v0.0.7` does not correspond to the source at that tag. Releases from `v0.0.8` onward are sound.

### Workflow

1. Branch: `git checkout -b feat/seccion-04`
2. Commit and push
3. Open a pull request against `main`. If it touches the paper, CI compiles it and attaches the PDF
4. A code owner reviews the rendered PDF, not the LaTeX diff
5. On merge, CD publishes the release

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the full process.

---

## Programme rubric

The paper covers the 12 sections of the final-project rubric, worth 20 points:

| # | Section | Points | File |
|:--|:---|:--|:---|
| 1 | Use case description | 1 | `sections/01-use-case.tex` |
| 2 | Model and data selection | 1 | `sections/02-model-data.tex` |
| 3 | Prompt engineering and adaptation | 2 | `sections/03-prompts.tex` |
| 4 | Application implementation | 3 | `sections/04-implementation.tex` |
| 5 | Orchestration and deployment | 2 | `sections/05-orchestration.tex` |
| 6 | Monitoring and maintenance | 2 | `sections/06-monitoring.tex` |
| 7 | Application evaluation | 2 | `sections/07-evaluation.tex` |
| 8 | Results and demo | 2 | `sections/08-results.tex` |
| 9 | Conclusions | 1 | `sections/09-conclusions.tex` |
| 10 | Recommendations | 1 | `sections/10-recommendations.tex` |
| 11 | APA bibliography | 1 | `references.bib` |
| 12 | Presentation link | 2 | Results section |

Requirements and grading criteria are transcribed in [`DOCS/TFP-GUIDELINES.md`](DOCS/TFP-GUIDELINES.md) and [`DOCS/RUBRICA-PROGRAMA.md`](DOCS/RUBRICA-PROGRAMA.md). Outstanding work is tracked in [`DOCS/issues/issues-v1/00-INDEX.md`](DOCS/issues/issues-v1/00-INDEX.md).

---

## Key dates

| Milestone | Date |
|:---|:---|
| Progress submission | Sunday 14 June 2026, 23:00 |
| Final submission | Sunday 9 August 2026, 13:00 |

---

## Authors

- Fabiola G. Tapara Quispe
- Angel E. Hincho Jove
- Andy B. Huamani Tacoma
- Nikolai A. Asencios Garcia
- David Barreto Lara

**Programme:** II Programa de Especializacion en IA Generativa y Machine Learning Ops
**Institution:** Universidad Nacional de Ingenieria (UNI) -- Facultad de Ingenieria Economica, Estadistica y Ciencias Sociales

Maintained by `@spark-match/article-authors`. Contact: <ahincho@unsa.edu.pe> or [@ahincho](https://github.com/ahincho).

---

## License

Copyright (c) 2026 Spark Match Team.

This work is licensed under [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/) (CC BY-SA 4.0). The full legal code is in [`LICENSE`](LICENSE).

You may copy, redistribute and adapt the material, including commercially, under two conditions:

- **Attribution** -- credit the authors, link the license, and state whether you made changes.
- **ShareAlike** -- if you adapt the material, distribute your version under this same license.

The other `spark-match` repositories use **GPL-3.0**, which is a software license. It does not fit here: its terms speak of object code, linking and *installation information*, concepts with no meaning for prose and figures. The FSF itself recommends Creative Commons for works that are not software. CC BY-SA provides the same copyleft, written for content.

Authors and institution appear on the paper's title page (`\begin{titlepage}` in `main.tex`) and above in this README.
