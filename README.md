<div align="center">
  <h1>GitHub Actions Self-Hosted Runner Lab</h1>
  <p>Laboratório em PT-BR para demonstrar GitHub Actions com GitHub-hosted runner e self-hosted runner no WSL2/Windows 11.</p>
  <p>
    <a href="https://github.com/brodyandre/github-actions-self-hosted-runner-lab/actions/workflows/github-hosted-runner.yml">
      <img alt="Workflow GitHub-hosted runner" src="https://github.com/brodyandre/github-actions-self-hosted-runner-lab/actions/workflows/github-hosted-runner.yml/badge.svg" />
    </a>
    <img alt="Self-hosted placeholder" src="https://img.shields.io/badge/Self--hosted-placeholder-lightgrey?logo=githubactions" />
    <img alt="Diagnostics placeholder" src="https://img.shields.io/badge/Diagnostics-placeholder-lightgrey?logo=githubactions" />
    <img alt="Docker placeholder" src="https://img.shields.io/badge/Docker-placeholder-lightgrey?logo=docker" />
  </p>
</div>

<a id="indice"></a>
## Índice

- [Visão geral](#visao-geral)
- [Objetivo](#objetivo)
- [Arquitetura do laboratório](#arquitetura-do-laboratorio)
- [Stack utilizada](#stack-utilizada)
- [Estrutura do projeto](#estrutura-do-projeto)
- [Como rodar localmente](#como-rodar-localmente)
- [Como executar testes](#como-executar-testes)
- [Como validar endpoints](#como-validar-endpoints)
- [GitHub-hosted runner](#github-hosted-runner)
- [Self-hosted runner](#self-hosted-runner)
- [Labels de runner](#labels-de-runner)
- [Diagnóstico seguro](#diagnostico-seguro)
- [Docker no self-hosted runner](#docker-no-self-hosted-runner)
- [Evidências visuais](#evidencias-visuais)
- [Troubleshooting](#troubleshooting)
- [Habilidades demonstradas](#habilidades-demonstradas)
- [Próximos passos](#proximos-passos)
- [Autor](#autor)

<a id="visao-geral"></a>
## Visão geral

Este repositório foi preparado como um laboratório simples, profissional e objetivo para comparar execuções de workflow em dois cenários: `GitHub-hosted runner` e `self-hosted runner` rodando em `WSL2` sobre `Windows 11`.

A proposta é mostrar uma base pequena e funcional, com aplicação Node.js sem dependências externas, workflows mínimos, documentação em PT-BR e espaço reservado para evidências visuais.

[⬆️ Retornar ao índice](#indice)

<a id="objetivo"></a>
## Objetivo

Demonstrar, de forma prática, os seguintes pontos:

- Execução de workflow em runner hospedado pelo GitHub.
- Execução de workflow em runner self-hosted no WSL2.
- Validação simples de projeto com scripts seguros.
- Execução de diagnóstico sem exposição de segredos.
- Preparação para build Docker no runner self-hosted.

[⬆️ Retornar ao índice](#indice)

<a id="arquitetura-do-laboratorio"></a>
## Arquitetura do laboratório

```text
GitHub Repository
├── Workflow 1: github-hosted-runner
│   └── Runner: ubuntu-latest
├── Workflow 2: self-hosted-check
│   └── Runner: self-hosted (WSL2 / Windows 11)
├── Workflow 3: safe-diagnostics
│   └── Runner: self-hosted (WSL2 / Windows 11)
└── Workflow 4: docker-self-hosted
    └── Runner: self-hosted com Docker habilitado

Aplicação demonstrada
└── Node.js HTTP Server
    ├── GET /
    ├── GET /health
    ├── GET /runner-info
    └── GET /build-info
```

[⬆️ Retornar ao índice](#indice)

<a id="stack-utilizada"></a>
## Stack utilizada

- `Node.js` para a aplicação de exemplo.
- `node:http` para a API HTTP nativa.
- `node:test` para testes automatizados.
- `GitHub Actions` para automação dos workflows.
- `Bash` para scripts de validação e diagnóstico seguro.
- `Docker` como etapa opcional no runner self-hosted.
- `WSL2` no `Windows 11` como ambiente recomendado para o runner self-hosted.

[⬆️ Retornar ao índice](#indice)

<a id="estrutura-do-projeto"></a>
## Estrutura do projeto

```text
.
├── .env.example
├── .github/
│   └── workflows/
│       ├── docker-self-hosted.yml
│       ├── github-hosted-runner.yml
│       ├── safe-diagnostics.yml
│       └── self-hosted-check.yml
├── .gitignore
├── .nvmrc
├── .vscode/
│   └── settings.json
├── Dockerfile
├── Makefile
├── README.md
├── app/
│   ├── config.js
│   └── server.js
├── docs/
│   ├── evidence.md
│   ├── evidence/
│   ├── images/
│   ├── runner/
│   │   └── labels.md
│   ├── security-notes.md
│   ├── setup-self-hosted-runner.md
│   ├── troubleshooting.md
│   └── troubleshooting/
├── package.json
├── test/
│   └── server.test.js
└── scripts/
    ├── check-project.sh
    ├── run-with-node20.sh
    └── safe-diagnostics.sh
    └── start-app.sh
```

[⬆️ Retornar ao índice](#indice)

<a id="como-rodar-localmente"></a>
## Como rodar localmente

Pré-requisito recomendado: `Node.js 20` ou superior.

1. Copie `.env.example` para `.env` se quiser customizar porta, host ou nome da aplicação.
2. Use `nvm use` se você tiver `nvm` instalado.
3. Execute `make install`.
4. Execute `make check` para validar estrutura, lint e testes.
5. Inicie a aplicação com `npm start` ou `make start`.
5. Acesse os endpoints locais.

A aplicação lê o arquivo `.env` automaticamente, sem dependências externas. Se o Node local estiver abaixo da versão esperada, os comandos `make install`, `make start` e `make test` usam Docker com `Node 20` como fallback.

Comandos úteis:

```bash
cp .env.example .env
nvm use
make install
make check
npm start
curl http://localhost:3000/
curl http://localhost:3000/health
curl http://localhost:3000/runner-info
curl http://localhost:3000/build-info
```

[⬆️ Retornar ao índice](#indice)

<a id="como-executar-testes"></a>
## Como executar testes

Os testes usam `node:test`, sem framework adicional.

Comandos:

```bash
npm test
make test
```

O script `make check` também executa:

- Verificação de estrutura.
- Lint por sintaxe com `node --check`.
- Testes automatizados da API.
- Fallback com Docker `node:20` quando o Node local estiver antigo.

[⬆️ Retornar ao índice](#indice)

<a id="como-validar-endpoints"></a>
## Como validar endpoints

Com a aplicação em execução, valide os endpoints abaixo:

```bash
curl http://localhost:3000/
curl http://localhost:3000/health
curl http://localhost:3000/runner-info
curl http://localhost:3000/build-info
```

Resumo esperado:

- `GET /`: retorna `appName` e `status`.
- `GET /health`: retorna `status: ok`.
- `GET /runner-info`: retorna informações seguras do ambiente do runner.
- `GET /build-info`: retorna nome da aplicação, versão e ambiente.

[⬆️ Retornar ao índice](#indice)

<a id="github-hosted-runner"></a>
## GitHub-hosted runner

O workflow [`github-hosted-runner.yml`](.github/workflows/github-hosted-runner.yml) demonstra a execução padrão do GitHub Actions em `ubuntu-latest`. Ele instala o projeto de forma compatível com ou sem `package-lock.json`, executa `npm test`, roda `npm run diagnostics`, gera um relatório em `artifacts/github-hosted-report.txt` e publica esse arquivo como artifact.

Diferença prática para o self-hosted runner:

- `GitHub-hosted`: ambiente efêmero, pronto para uso e mantido pelo GitHub.
- `Self-hosted`: ambiente controlado por você, útil quando precisa de acesso local, Docker específico ou ferramentas próprias.

Ponto preparado para print:

- `docs/images/github-hosted-workflow-success.png`

[⬆️ Retornar ao índice](#indice)

<a id="self-hosted-runner"></a>
## Self-hosted runner

O workflow [`self-hosted-check.yml`](.github/workflows/self-hosted-check.yml) foi preparado para execução manual em um runner com labels `self-hosted`, `linux` e `x64`, executando a mesma validação da aplicação com estrutura, lint e testes. A configuração recomendada está documentada em [docs/setup-self-hosted-runner.md](docs/setup-self-hosted-runner.md).

Para evitar divergência de versão entre máquinas, esse workflow também instala `Node 20` com `actions/setup-node`.

Resumo da comparação:

- `GitHub-hosted` é melhor para validação padrão, rapidez de setup e manutenção mínima.
- `Self-hosted` é melhor para cenários com dependências locais, controle de infraestrutura e integração com recursos do host.

Pontos preparados para print:

- `docs/images/runner-settings.png`
- `docs/images/self-hosted-runner-online.png`
- `docs/images/self-hosted-workflow-success.png`

[⬆️ Retornar ao índice](#indice)

<a id="labels-de-runner"></a>
## Labels de runner

As labels recomendadas para o laboratório estão descritas em [docs/runner/labels.md](docs/runner/labels.md). A ideia é manter labels simples, legíveis e alinhadas ao ambiente real do host.

Exemplo de uso em workflow:

```yaml
runs-on: [self-hosted, linux, x64]
```

[⬆️ Retornar ao índice](#indice)

<a id="diagnostico-seguro"></a>
## Diagnóstico seguro

O script [`scripts/safe-diagnostics.sh`](scripts/safe-diagnostics.sh) coleta apenas informações operacionais básicas, como versões, ambiente e disponibilidade de ferramentas, sem imprimir variáveis de ambiente, tokens ou segredos.

O workflow [`safe-diagnostics.yml`](.github/workflows/safe-diagnostics.yml) foi preparado para disparo manual no runner self-hosted.

Ponto preparado para print:

- `docs/images/diagnostics-workflow.png`

[⬆️ Retornar ao índice](#indice)

<a id="docker-no-self-hosted-runner"></a>
## Docker no self-hosted runner

O workflow [`docker-self-hosted.yml`](.github/workflows/docker-self-hosted.yml) valida o acesso ao Docker no runner self-hosted e executa um `docker build` usando o [`Dockerfile`](Dockerfile) deste projeto.

Esse fluxo ajuda a demonstrar uma vantagem prática do runner self-hosted: acesso controlado a recursos locais do host, como o Docker Engine.

Ponto preparado para print:

- `docs/images/docker-build-self-hosted.png`

[⬆️ Retornar ao índice](#indice)

<a id="evidencias-visuais"></a>
## Evidências visuais

Salve os prints nos caminhos abaixo para completar a apresentação do laboratório:

| Evidência | Caminho preparado |
| --- | --- |
| Badges do README | `docs/images/readme-badges.png` |
| Configuração do runner no GitHub | `docs/images/runner-settings.png` |
| Runner self-hosted online | `docs/images/self-hosted-runner-online.png` |
| Sucesso do workflow GitHub-hosted | `docs/images/github-hosted-workflow-success.png` |
| Sucesso do workflow self-hosted | `docs/images/self-hosted-workflow-success.png` |
| Workflow de diagnóstico | `docs/images/diagnostics-workflow.png` |
| Build Docker no self-hosted | `docs/images/docker-build-self-hosted.png` |

Mais detalhes em [docs/evidence.md](docs/evidence.md).

[⬆️ Retornar ao índice](#indice)

<a id="troubleshooting"></a>
## Troubleshooting

Os problemas mais comuns do laboratório estão consolidados em [docs/troubleshooting.md](docs/troubleshooting.md), com apoio da pasta `docs/troubleshooting/` para registrar saídas, logs e capturas futuras.

[⬆️ Retornar ao índice](#indice)

<a id="habilidades-demonstradas"></a>
## Habilidades demonstradas

- Criação de workflows simples e objetivos.
- Diferença prática entre `GitHub-hosted` e `self-hosted`.
- Organização de documentação técnica em PT-BR.
- Boas práticas de segurança para runners e scripts.
- Uso de `Node.js`, `Bash` e `Docker` em um laboratório enxuto.

[⬆️ Retornar ao índice](#indice)

<a id="proximos-passos"></a>
## Próximos passos

- Adicionar badges reais após a primeira execução dos workflows.
- Publicar evidências visuais na pasta `docs/images/`.
- Registrar saídas relevantes em `docs/evidence/`.
- Evoluir os workflows com cache, matrix ou ambientes protegidos.
- Configurar o runner como serviço persistente no WSL2, se fizer sentido para o laboratório.

[⬆️ Retornar ao índice](#indice)

<a id="autor"></a>
## Autor

**Luiz André de Souza**

- GitHub: https://github.com/brodyandre
- LinkedIn: https://www.linkedin.com/in/luiz-andre-souza-data-engineer/

[⬆️ Retornar ao índice](#indice)
