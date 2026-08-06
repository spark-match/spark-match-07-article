# Contributing to `spark-match-07-article`

This repository holds the paper for the Trabajo de Fin de Programa: LaTeX
sources, references, diagram sources and the scripts that compile them.

If you are looking for the code the paper describes, it lives in the other
`spark-match/*` repositories. Nothing here is deployed.

## Code of conduct

Participation is governed by [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## Branch model

**`main` only.** There is no `dev` branch: it was deleted on 2026-08-06 after
sitting untouched since 2026-07-10, with no pull request ever targeting it.

Work on a branch off `main` and open a pull request:

```bash
git checkout main
git pull --ff-only
git checkout -b docs/seccion-04-implementacion
```

Branches are deleted on merge. Squash is the only merge method the ruleset
allows.

## Local setup

### Prerequisites

| Platform | Distribution |
|---|---|
| Windows | [MiKTeX](https://miktex.org/) with `pdflatex` and `bibtex` |
| Linux / macOS | [TeX Live](https://tug.org/texlive/) (`texlive-full` or equivalent) |

LaTeX packages used by `config/preamble.tex`: `babel-spanish`, `amsmath`,
`tikz`, `listings`, `algorithms`, `booktabs`, `tcolorbox`, `hyperref`,
`natbib`.

`latexmk` drives the build. `.latexmkrc` sets `pdflatex` with
`-interaction=nonstopmode` and `$bibtex_use = 2`, so the bibliography is
rebuilt when `references.bib` changes.

### Compiling

```bash
# Linux / macOS
./scripts/build.sh          # compile
./scripts/clean.sh          # remove auxiliary files
./scripts/watch.sh          # recompile on save
```

```powershell
# Windows
.\compile.ps1               # PowerShell
compile.bat                 # CMD
```

The output is `main.pdf` at the repository root. It is git-ignored on purpose:
the PDF is a build artifact, and the authoritative copy is the one attached to
each GitHub Release.

## Where things live

| Path | What |
|---|---|
| `main.tex` | Document skeleton; includes everything else |
| `config/preamble.tex` | Packages and global configuration |
| `sections/NN-*.tex` | One file per section, numbered in reading order |
| `references.bib` | BibTeX, APA format |
| `figures/*.png` | The images `main.tex` includes |
| `figures/mermaid/*.mmd` | **Sources** of those images |
| `DOCS/` | Programme guidelines, rubric, issue tracking |

### Editing a diagram

Edit the `.mmd`, re-render, and commit both. The seven `.mmd` files map
one-to-one onto the seven PNGs, and `figures/mermaid/README.md` documents which
section each one belongs to along with its suggested caption and label.

Editing a PNG directly is the one thing that quietly breaks this: the diagram
and its source drift apart, and the next person to touch it regenerates from
the `.mmd` and silently reverts your change.

## Style

- **Spanish, with real accents.** The README used to carry LaTeX accent
  notation (`Orientaci\'on`) inside Markdown, where it means nothing and
  renders literally. In `.tex` files use whatever the preamble supports; in
  `.md` files write UTF-8 directly.
- **One section per file.** Do not inline a new section into `main.tex`.
- **Citations are mandatory** for any external claim. The programme requires a
  minimum of five references in APA format.
- **Honesty about state.** `figures/mermaid/README.md` sets the standard the
  rest of the paper follows: diagrams reflect the verified state of the code,
  not the aspirational design, and mark explicitly what is not integrated yet.
  Keep it that way. A paper that claims a component works when it does not is
  worse than one that says it is pending.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with a scope
that says what you touched:

```
docs(article): reescribir la seccion 4 con la arquitectura ECS real
fix(ci): apuntar a los reusables renombrados de 01-devops
chore(figures): regenerar el diagrama de estados desde el .mmd
```

Unlike the other repositories in the organization, **this one does not run
commitlint**, so nothing enforces it. The history is mixed as a result. Follow
the convention anyway: the release notes are generated from these messages.

## Pull request workflow

1. Push the branch and open a pull request against `main`.
2. **CI compiles the PDF** and publishes it as an artifact named
   `spark-match-paper-pr-<N>`. Download it to review the rendered result rather
   than reading the diff.
3. Request review. `CODEOWNERS` requires `@spark-match/article-authors`, and
   `/README.md`, `/LICENSE` and `/DOCS/` additionally require
   `@spark-match/product-owners`.
4. **You cannot approve your own pull request**, even as a code owner. That is
   a GitHub rule, not a policy choice. Any of the other team members can.

On merge, **CD** compiles the PDF, bumps the patch version from the latest tag,
creates the tag and publishes a GitHub Release with the PDF attached. For a
minor or major bump, create the tag manually before merging.

### If you add a new path

`CODEOWNERS` uses explicit paths with no catch-all, and the invariant is that
**every path that exists is declared and nothing declared is missing**. Adding a
top-level file or directory means adding a line before the merge.

This is not bureaucracy: until 2026-08-06 the file declared `/decisions/`,
`/onboarding/` and `/postmortems/`, none of which exist here, while `/DOCS/`
required review from nobody.

## Reporting problems

- **Content**: an error, a wrong citation, a missing section. Open an issue.
- **Security**: see [`SECURITY.md`](SECURITY.md). Do not open a public issue.
- **Conduct**: see [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).
