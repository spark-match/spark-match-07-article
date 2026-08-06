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

- **GitHub Security Advisories** (preferred):
  <https://github.com/spark-match/spark-match-07-article/security/advisories/new>.
  Private vulnerability reporting is enabled, so the report stays visible only
  to you and the maintainers until a fix ships.
- **Email**: <ahincho@unsa.edu.pe>
- **GitHub**: mention [@ahincho](https://github.com/ahincho) and ask for a
  private channel. Send the details only once that channel exists. A mention is
  public, so it must not contain the finding itself.

## Current posture

Verified 2026-08-06:

| Setting | State |
|---|---|
| Private vulnerability reporting | enabled |
| Secret scanning | enabled |
| Push protection | enabled |
| Ruleset `spark-match-default-branch-protection` | active on `main` |
| Classic branch protection | removed |

Push protection is the one that matters most here: it blocks a credential from
reaching the remote at all, which is the concrete risk this repository has.

All three were **disabled** until 2026-08-06, despite being free for public
repositories and already enabled on `spark-match-01-devops`. They were turned
on the same day this policy was written.

This table is a checklist rather than a claim, so that turning any of them off
makes the document visibly wrong instead of quietly wrong. Verify with:

```bash
gh api repos/spark-match/spark-match-07-article \
  --jq '.security_and_analysis'
gh api repos/spark-match/spark-match-07-article/private-vulnerability-reporting \
  --jq '.enabled'
```

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
