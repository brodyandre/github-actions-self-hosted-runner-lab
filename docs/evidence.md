# Evidências do laboratório

Use este documento para registrar os resultados do laboratório de forma organizada.

## Checklist sugerido

- Badge do workflow GitHub-hosted visível no README.
- Runner self-hosted cadastrado no GitHub.
- Runner self-hosted online no WSL2.
- Workflow GitHub-hosted executado com sucesso.
- Artifact `github-hosted-report` gerado e disponível para download.
- Workflow self-hosted executado com sucesso.
- Workflow de diagnóstico executado com sucesso.
- Build Docker executado no self-hosted runner.

## Checklist do workflow GitHub-hosted

- Workflow `github-hosted-runner` disparado por `push`, `pull_request` ou `workflow_dispatch`.
- Runner exibido como `ubuntu-latest`.
- Instalação do Node.js 20 concluída com sucesso.
- Instalação do projeto executada com `npm ci` ou `npm install`.
- Testes executados com `npm test`.
- Diagnóstico executado com `npm run diagnostics`.
- Arquivo `artifacts/github-hosted-report.txt` gerado no job.
- Artifact enviado com sucesso para o GitHub Actions.

## Onde salvar os arquivos

- Prints: `docs/images/`
- Evidências complementares: `docs/evidence/`
- Logs e análises de falha: `docs/troubleshooting/`

## Nomes de prints preparados no README

- `docs/images/runner-settings.png`
- `docs/images/self-hosted-runner-online.png`
- `docs/images/github-hosted-workflow-success.png`
- `docs/images/self-hosted-workflow-success.png`
- `docs/images/diagnostics-workflow.png`
- `docs/images/docker-build-self-hosted.png`
- `docs/images/readme-badges.png`
