# Issue 05 — Monitoreo con métricas reales

**Rama:** `feat/report-update`
**Criterio rúbrica:** #6 — Monitoreo y mantenimiento — **2 pts, actualmente ~1.5 (Logrado/En proceso)**
**Prioridad:** Media
**Depende de:** Issue 01
**Archivo afectado:** `sections/06-monitoring.tex`
**TODO existente:** línea 58 — *"completar los valores medidos de estas métricas tras las pruebas"*

## Contexto

Rúbrica, nivel Destacado (100%): *"Estrategia de monitoreo implementada... con métricas reales de desempeño en producción. Gestión de drift documentada con alertas configuradas. Logging funcional con ejemplos."* El stack (LangSmith, W&B, AWS Budgets/CloudWatch) ya está bien definido y, según la sección 8, el trazado con LangSmith parece estar operando. Falta cerrar la brecha entre "herramienta configurada" y "métrica real registrada".

## Tareas

- [ ] Extraer de LangSmith al menos una métrica real: latencia promedio por conversación, tokens consumidos, tasa de éxito de invocaciones.
- [ ] Extraer de AWS Budgets/Cost Explorer el costo real acumulado del LLM y/o de la infraestructura (aunque sea de un período corto de pruebas).
- [ ] Si el "LLM-as-judge" para evaluación automática sigue pendiente de despliegue (confirmar con Issue 01), dejarlo explícito como limitación en vez de describirlo como si ya operara.
- [ ] Añadir al menos un ejemplo concreto de log estructurado o traza (captura o extracto de LangSmith) como evidencia de "logging funcional con ejemplos".
- [ ] Revisar si ya existen alertas configuradas en AWS Budgets (umbral de gasto); si es así, documentarlas con el valor real del umbral.
- [ ] Eliminar el `% TODO (equipo)` de la línea 58 una vez completado.

## Verificación

- [ ] Al menos una métrica de la sección "Métricas de desempeño" tiene un valor numérico real, no solo la lista de qué se piensa medir.
- [ ] Hay evidencia (captura o cifra) de al menos una corrida real en LangSmith o W&B.
- [ ] La gestión de drift sigue siendo honesta sobre su alcance actual (dataset congelado) — no se exagera diciendo que hay alertas de drift si no existen.
- [ ] Recompilar el PDF y verificar que no queden placeholders sin resolver en la sección.
