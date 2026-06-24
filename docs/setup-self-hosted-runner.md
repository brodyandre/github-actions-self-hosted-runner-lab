# Setup do self-hosted runner

Este guia resume a configuração de um `self-hosted runner` para este laboratório usando `WSL2` no `Windows 11`.

## Pré-requisitos

- Repositório criado no GitHub.
- `WSL2` funcional no Windows 11.
- `git` instalado no ambiente Linux do WSL2.
- `curl` ou `wget` para baixar o pacote do runner.
- `Docker` instalado, caso queira executar o workflow de build.

## Passo a passo recomendado

1. Acesse `Settings > Actions > Runners` no repositório.
2. Clique em `New self-hosted runner`.
3. Selecione `Linux` e `x64`.
4. No WSL2, crie um diretório fora deste repositório, por exemplo:

```bash
mkdir -p ~/actions-runner-lab
cd ~/actions-runner-lab
```

5. Copie do GitHub os comandos de download e extração do runner.
6. Execute o comando de configuração informado pela interface do GitHub.
7. Durante a configuração, use um nome simples e labels compatíveis com este laboratório.
8. Inicie o runner com `./run.sh`.

## Boas práticas

- Não versione arquivos do runner.
- Não salve tokens em arquivos do repositório.
- Prefira manter o runner fora da pasta do projeto.
- Use labels consistentes para facilitar a leitura dos workflows.
- O workflow do laboratório instala `Node 20` com `actions/setup-node`, reduzindo dependência de versão pré-instalada no host.

## Validação inicial

Depois que o runner ficar online:

1. Execute o workflow `self-hosted-check`.
2. Execute o workflow `safe-diagnostics`.
3. Se Docker estiver disponível, execute `docker-self-hosted`.

## Referências internas

- [Notas de segurança](security-notes.md)
- [Labels recomendadas](runner/labels.md)
