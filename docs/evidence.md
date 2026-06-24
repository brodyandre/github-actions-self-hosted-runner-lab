# Evidências do laboratório

Use este documento para registrar os resultados do laboratório de forma organizada.

## Checklist sugerido

- Badge do workflow GitHub-hosted visível no README.
- Badge do workflow self-hosted visível no README.
- Runner self-hosted cadastrado no GitHub.
- Runner self-hosted online no WSL2.
- Workflow GitHub-hosted executado com sucesso.
- Artifact `github-hosted-report` gerado e disponível para download.
- Workflow self-hosted executado com sucesso.
- Artifact `self-hosted-report` gerado e disponível para download.
- Workflow de diagnóstico executado com sucesso.
- Artifact `diagnostics-report` gerado e disponível para download.
- Build Docker executado no self-hosted runner.
- Artifact `docker-build-report` gerado e disponível para download.

## Checklist do workflow GitHub-hosted

- Workflow `github-hosted-runner` disparado por `push`, `pull_request` ou `workflow_dispatch`.
- Runner exibido como `ubuntu-latest`.
- Instalação do Node.js 20 concluída com sucesso.
- Instalação do projeto executada com `npm ci` ou `npm install`.
- Testes executados com `npm test`.
- Diagnóstico executado com `npm run diagnostics`.
- Arquivo `artifacts/github-hosted-report.txt` gerado no job.
- Artifact enviado com sucesso para o GitHub Actions.

## Checklist do workflow self-hosted

- Workflow `self-hosted-runner` disparado manualmente por `workflow_dispatch`.
- Runner exibido como `self-hosted` e `Online`.
- Labels compatíveis com `self-hosted`, `linux`, `x64` e `wsl2`.
- Instalação do Node.js 20 concluída com sucesso.
- Instalação do projeto executada com `npm install`.
- Testes executados com `npm test`.
- Diagnóstico seguro executado com `./scripts/safe-diagnostics.sh`.
- Arquivo `artifacts/self-hosted-report.txt` gerado no job.
- Artifact enviado com sucesso para o GitHub Actions.

## Checklist do workflow de diagnóstico

- Workflow `self-hosted-diagnostics` disparado manualmente por `workflow_dispatch`.
- Runner exibido como `self-hosted` e `Online`.
- Labels compatíveis com `self-hosted`, `linux`, `x64` e `wsl2`.
- Script `./scripts/safe-diagnostics.sh` executado com sucesso.
- Nenhum `env` completo foi impresso nos logs.
- Nenhum token ou secret foi impresso nos logs.
- Arquivo `artifacts/diagnostics-report.txt` gerado no job.
- Artifact `diagnostics-report` enviado com sucesso para o GitHub Actions.

## Checklist do workflow Docker

- Workflow `docker-self-hosted` disparado manualmente por `workflow_dispatch`.
- Runner exibido como `self-hosted` e `Online`.
- Labels compatíveis com `self-hosted`, `linux`, `x64` e `wsl2`.
- Docker disponível no host do runner.
- Imagem `self-hosted-runner-node-lab:local` criada com sucesso.
- Container iniciado com sucesso na porta `3000`.
- Endpoint `GET /health` validado com `curl`.
- Container removido ao final da execução.
- Arquivo `artifacts/docker-build-report.txt` gerado no job.
- Artifact `docker-build-report` enviado com sucesso para o GitHub Actions.

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
