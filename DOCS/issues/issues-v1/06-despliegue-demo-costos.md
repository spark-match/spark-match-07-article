# Issue 06 — Despliegue: URL de demo y costos reales

**Rama:** `feat/report-update`
**Criterio rúbrica:** #5 — Orquestación y despliegue — **2 pts, actualmente ~1.5 (Logrado)**
**Prioridad:** Media
**Depende de:** Issue 01
**Archivo afectado:** `sections/05-orchestration.tex`
**TODO existente:** línea 114 — *"completar costos mensuales reales y URL de demo tras el deploy"*

## Contexto

Rúbrica, nivel Destacado (100%): *"Despliegue en Kubernetes, servicio cloud o servidor local con enlace funcional."* El proyecto ya no usa Kubernetes por decisión documentada (serverless), lo cual es válido según la rúbrica ("u otro"). El CI/CD (SonarCloud, CodeQL, checkov, tflint) ya está bien documentado y probablemente probado — lo que falta es el enlace funcional del despliegue.

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
