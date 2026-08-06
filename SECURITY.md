# Security Policy

## Scope

This repository holds an academic paper: LaTeX sources, BibTeX references,
Mermaid diagram sources and the scripts that compile them to a PDF. It ships no
runtime, no service and no library, and nothing here is deployed anywhere.

That makes the attack surface small but not empty. What is worth reporting:

- **A secret committed by accident.** API keys, AWS credentials or tokens
  pasted into a script, a `.tex` file or a figure. This is the realistic risk
  in a repository like this one, and it is the reason this policy exists.
- **A problem in `.github/workflows/`.** Both workflows run on pull requests
  from the same repository and hold `contents: read`, but a change that widens
  permissions or introduces script injection is a real finding.
- **Sensitive data in the paper itself.** Personal data of study participants,
  internal infrastructure details, or credentials appearing in a screenshot or
  a figure.

## Reporting a Vulnerability

This repository is **public**. An issue, a pull request or a commit message is
visible to everyone the moment you publish it, so none of those is a private
channel.

Report privately via:

- **Email**: <ahincho@unsa.edu.pe>
- **GitHub**: mention [@ahincho](https://github.com/ahincho) and ask for a
  private channel. Send the details only once that channel exists. A mention is
  public, so it must not contain the finding itself.

GitHub Security Advisories would be the better first channel, but private
vulnerability reporting is currently **disabled** on this repository, so
`/security/advisories/new` does not accept submissions. See below.

## Current posture, and what is missing

Verified 2026-08-06:

| Setting | State | Free for public repos? |
|---|---|---|
| Private vulnerability reporting | **disabled** | yes |
| Secret scanning | **disabled** | yes |
| Push protection | **disabled** | yes |
| Ruleset `spark-match-default-branch-protection` | active on `main` | — |
| Classic branch protection | removed 2026-08-06 | — |

The first three are free for public repositories and are already enabled on
`spark-match-01-devops`. They are not enabled here. Push protection in
particular is what stops a credential from reaching the remote at all, which is
the exact risk this repository has.

Enabling them:

```bash
gh api -X PUT repos/spark-match/spark-match-07-article/private-vulnerability-reporting

gh api -X PATCH repos/spark-match/spark-match-07-article \
  -F 'security_and_analysis[secret_scanning][status]=enabled' \
  -F 'security_and_analysis[secret_scanning_push_protection][status]=enabled'
```

This section is written as a checklist rather than a claim so it cannot quietly
become false. If you enable them, update the table.

## If a secret does get committed

Rotating it is the first step and the only one that actually matters. Removing
the commit does **not** undo the exposure: the object stays reachable through
the fork network and through any clone, and GitHub does not garbage-collect it
on request for a public repository.

1. **Rotate the credential immediately.** Assume it is compromised.
2. Report it through one of the private channels above.
3. Only then discuss whether rewriting history is worth it.

## Response Timeline

| Phase | Target |
|---|---|
| Acknowledgement | within 7 days |
| Assessment | within 14 days |
| Fix or mitigation | depends on the finding |

These are aspirational, and deliberately looser than the ones in
`spark-match-01-devops`: this is a coursework repository maintained by students
alongside their programme, not a service with an on-call rotation. Promising 48
hours here would be a promise nobody is in a position to keep.

## Out-of-Scope

- **Typos, wrong citations or factual errors in the paper.** Open a normal
  issue; they are not security findings.
- **Vulnerabilities in the reusable workflows** (`reusable-latex-build.yml`,
  `reusable-latex-release.yml`). Those live in `spark-match-01-devops`; report
  them under that repository's `SECURITY.md`.
- **Bugs in upstream tooling** (LaTeX distributions, latexmk, biber, Mermaid).
  Report them upstream.
