# Issue 06 — Despliegue: URL de demo y costos reales

**Estado (2026-08-05): 🟡 Arquitectura de despliegue corregida y mucho más precisa; URL/costos reales siguen pendientes.**
Esta sección tenía dos errores factuales de arquitectura que ya se
corrigieron con evidencia directa de `modules/agent-service/main.tf` y del
`Dockerfile` de `spark-match-08-deep-agent`:
1. El agente **no** corre sobre Bedrock AgentCore Runtime — corre en **ECS
   Fargate** (ARM64/Graviton) detrás de un ALB, con CloudFront delante para
   TLS, por una razón documentada explícitamente en el propio Terraform:
   necesita conexión TCP directa a RDS (checkpointer de LangGraph) y
   streaming SSE de larga duración en `/ag-ui`, que ni AgentCore Runtime ni
   el timeout fijo de 30s de API Gateway HTTP API soportan bien.
2. El backend Lambda **no** se empaqueta como imagen de contenedor — usa
   `BuildMethod: esbuild` (ZIP, Node.js 24.x); Docker solo se usa para el
   agente.

También se agregaron dos figuras nuevas (arquitectura de despliegue y
pipeline de CI/CD, Issue 07) y se corrigió la subsección de escalabilidad:
el agente hoy tiene `desired_count` **fijo**, sin autoscaling configurado
(el campo de Terraform ya está preparado para cuando se agregue) — antes el
informe no distinguía esto.

Lo que **sigue pendiente**: el placeholder de costos/URL de demo. Ver
`DOCS/pre-evaluaciones/1ra-proyeccion-evaluacion.md` sección 1.4.

**Rama:** `feat/report-update`
**Criterio rúbrica:** #5 — Orquestación y despliegue — **2 pts, actualmente ~1.5 (Logrado), arquitectura ahora correcta pero sin URL/costos reales**
**Prioridad:** Media
**Depende de:** Issue 01
**Archivo afectado:** `sections/05-orchestration.tex`
**TODO existente:** línea 163 — *"completar costos mensuales reales y URL de demo tras el deploy"* (línea desplazada desde la 114 original, sigue vigente)

## Contexto

Rúbrica, nivel Destacado (100%): *"Despliegue en Kubernetes, servicio cloud o servidor local con enlace funcional."* El proyecto ya no usa Kubernetes por decisión documentada (serverless), lo cual es válido según la rúbrica ("u otro"). El CI/CD (SonarCloud, CodeQL, checkov, tflint, gitleaks) ya está confirmado real y corriendo automáticamente en cada PR — lo que falta es el enlace funcional del despliegue.

## Tareas

- [ ] Confirmar con Issue 01 si el ambiente `dev` de Terraform ya fue aplicado (`terraform apply`) y si el backend serverless tiene una URL de API Gateway activa.
- [ ] Si el despliegue ya existe: documentar la URL real (aunque sea del ambiente `dev`, no necesariamente `prod`) y probar al menos un endpoint (ej. con `curl` o Postman) para confirmar que responde.
- [ ] Obtener del AWS Cost Explorer / Budgets el costo real acumulado a la fecha (aunque sea parcial, de días de prueba) para reemplazar "[definir tras el despliegue]".
- [ ] Si NO hay despliegue real para la fecha de entrega, documentar explícitamente el estado (ej. "validado en ambiente local, despliegue a `dev` en curso") en vez de dejar el placeholder sin resolver — esto es mejor para la rúbrica que un placeholder vacío, porque al menos es honesto y specific.
- [ ] Eliminar el `% TODO (equipo)` de la línea 114 una vez completado.

## Verificación

- [ ] Ya no existe el texto "se documentarán tras el despliegue final" sin reemplazo.
- [ ] Si se agrega una URL, se verificó que responde (no es un link muerto).
- [ ] Los costos mostrados tienen una fuente (captura de AWS Budgets/Cost Explorer) o están claramente marcados como estimados si no hay datos reales todavía.
- [ ] Coherencia con Issue 04: si la demo del video usa la misma URL, deben coincidir.
