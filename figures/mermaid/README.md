# Diagramas Mermaid — Spark Match TFP

Diagramas fuente (`.mmd`) para renderizar y convertir a imagen (PNG/SVG) e
insertar en el informe. Cada archivo trae, en sus comentarios `%%` iniciales,
la sección del informe donde va, el nombre de archivo sugerido para la
imagen renderizada, el `\caption` y el `\label` sugeridos.

Todos los diagramas reflejan el **estado real verificado del código** a
2026-08-05 (no el diseño aspiracional): donde el sistema todavía no integra
algo, el diagrama lo marca explícitamente (color rojo / línea punteada /
nota), siguiendo el mismo criterio de honestidad que el resto del informe.

| # | Archivo | Tipo | Sección destino | Qué resuelve |
|---|---|---|---|---|
| 01 | `01-secuencia-conversacion.mmd` | `sequenceDiagram` | 4 — Implementación | Flujo temporal detallado usuario→agente→respuesta, distinto del diagrama de arquitectura TikZ ya existente (`fig:architecture`). Pedido explícito del issue 07. |
| 02 | `02-pipeline-datos.mmd` | `flowchart` | 2 — Selección de modelo y datos | Visualiza las 4 etapas del pipeline DVC y la etapa `ingest` congelada (portal MINEDU caído desde 12/07/2026). |
| 03 | `03-arquitectura-despliegue-aws.mmd` | `flowchart` | 5 — Orquestación y despliegue | Hoy esa sección no tiene ningún diagrama; muestra ECS Fargate/ALB/CloudFront/ECR del agente vs. Lambda/EventBridge del backend, compartiendo RDS. |
| 04 | `04-estados-agente.mmd` | `stateDiagram-v2` | 4 — Implementación | Máquina de estados del coordinador y los 3 subagentes (assessment/matching/planning). Pedido explícito del issue 07 ("diagrama de estados"). |
| 05 | `05-cicd-pipeline.mmd` | `flowchart` | 5 — Orquestación y despliegue (o 6 — Monitoreo) | Quality gates en cada PR (SonarCloud, CodeQL, checkov/tflint, evals mock) + despliegue a ECS con rollback automático. |
| 06 | `06-user-journey.mmd` | `journey` | 1 — Caso de uso (o 8 — Resultados) | Recorrido del estudiante extremo a extremo. Pedido explícito del issue 07 ("user journey"). |
| 07 | `07-arquitectura-logica.mmd` | `flowchart` | 4 — Implementación | Reemplaza el TikZ original (`fig:architecture`), que dibujaba UI→Backend→Agent como cadena lineal — contradecía el ADR-012 ("frontend llama a ambos directamente, no hay proxy") y el propio texto de la sección. |

## Cómo renderizar

Cualquiera de estas opciones funciona (todas toman el `.mmd` y producen PNG/SVG):

```bash
# CLI oficial (mermaid-cli)
npx @mermaid-js/mermaid-cli -i 01-secuencia-conversacion.mmd -o fig-secuencia-conversacion.png -s 3

# o pegando el contenido en https://mermaid.live y exportando como PNG/SVG
```

Recomendado: exportar a **PNG a escala 3x** (o SVG si el flujo de compilación
lo soporta) para que se vea nítido en el PDF impreso/exportado.

## Cómo se insertarán en el LaTeX

Una vez tenga las imágenes, cada una se inserta con el patrón ya usado en el
resto del informe:

```latex
\begin{figure}[H]
    \centering
    \includegraphics[width=0.9\linewidth]{fig-secuencia-conversacion.png}
    \caption{Secuencia de una conversación típica, desde el mensaje del
    estudiante hasta la respuesta con recomendaciones explicadas.}
    \label{fig:conversation-sequence}
\end{figure}
```

Las imágenes renderizadas deben colocarse en `figures/` (no dentro de
`figures/mermaid/`, que queda como carpeta de fuentes editables), porque
`\graphicspath{{figures/}}` en `config/preamble.tex` solo apunta ahí.
