# Setup do self-hosted runner no WSL2

Este guia documenta uma configuração segura e controlada de `self-hosted runner` para este laboratório usando `WSL2` no `Windows 11`.

## Objetivo

Permitir a execução manual de jobs em um ambiente controlado, sem versionar tokens, sem gravar credenciais no repositório e sem automatizar o cadastro do runner.

## Pré-requisitos

- Repositório criado no GitHub.
- `WSL2` funcional no Windows 11.
- Distribuição Linux ativa no WSL2.
- `git` instalado no ambiente Linux.
- `curl` ou `wget` disponível para baixar o pacote oficial do runner.
- `Docker` instalado, se você quiser testar o workflow de build.

## Fluxo recomendado

1. Crie ou publique o repositório no GitHub.
2. Acesse `Settings > Actions > Runners`.
3. Clique em `New self-hosted runner`.
4. Selecione `Linux` e `x64` para uso no WSL2.
5. Copie somente os comandos oficiais exibidos pela interface do GitHub.
6. No WSL2, use um diretório fora deste repositório para armazenar o runner.
7. Durante a configuração, informe labels compatíveis com este laboratório.
8. Execute `./run.sh` para deixar o runner escutando jobs.
9. Valide o status `Online` na interface do GitHub.

## Passo a passo

### 1. Criar o repositório no GitHub

Publique este projeto no GitHub antes de cadastrar o runner. Isso garante que o runner será associado ao repositório correto.

### 2. Abrir a área de runners

No GitHub, abra:

`Settings > Actions > Runners`

Essa é a área em que o GitHub gera os comandos oficiais de instalação, configuração e execução.

### 3. Criar um novo runner

Clique em `New self-hosted runner`.

### 4. Selecionar Linux x64

Para uso no WSL2, selecione:

- Sistema operacional: `Linux`
- Arquitetura: `x64`

### 5. Copiar os comandos oficiais do GitHub

Copie os comandos diretamente da interface do GitHub. Não substitua os comandos oficiais por scripts próprios dentro deste repositório.

Importante:

- O token mostrado nessa tela é temporário.
- Esse token deve ser copiado apenas da interface do GitHub.
- Não salve esse token em arquivos versionados.
- Não cole esse token em scripts deste projeto.

### 6. Criar diretório do runner fora do repositório

No WSL2, crie um diretório dedicado fora da pasta deste projeto:

```bash
mkdir -p ~/actions-runner-devops-lab
cd ~/actions-runner-devops-lab
```

Isso reduz o risco de versionar arquivos internos do runner por engano.

### 7. Executar os comandos oficiais

Ainda no WSL2:

1. Execute os comandos oficiais de download e extração fornecidos pelo GitHub.
2. Execute o comando oficial de configuração.
3. Informe um nome simples para o runner.
4. Adicione as labels recomendadas deste laboratório.

Labels recomendadas:

- `self-hosted`
- `linux`
- `x64`
- `wsl2`
- `devops-lab`

### 8. Iniciar o runner

Após a configuração, execute:

```bash
./run.sh
```

Esse comando mantém o runner escutando jobs enquanto a sessão estiver ativa.

### 9. Validar o status Online

Volte para o GitHub e confirme se o runner aparece como:

`Online`

Se estiver offline, revise o processo `./run.sh`, o diretório usado e as labels configuradas.

## Recomendação de uso

Para este laboratório, prefira workflows `self-hosted` com `workflow_dispatch`. Isso reduz execução automática desnecessária e ajuda a manter o uso do runner sob controle.

Esse padrão é especialmente importante quando:

- o runner está em uma máquina pessoal;
- o ambiente tem Docker local;
- o runner fica ativo apenas em janelas curtas de teste;
- o repositório é público.

## Cuidados importantes

- Não instale o runner dentro da pasta deste projeto.
- Não versione o diretório do runner.
- Não armazene tokens em `.env`, scripts ou arquivos Markdown.
- Não compartilhe prints que exibam token, nome de máquina sensível ou caminhos privados.
- Em repositórios públicos, tenha cuidado redobrado com jobs `self-hosted`.

## Validação inicial do laboratório

Depois que o runner ficar `Online`:

1. Execute o workflow `self-hosted-check`.
2. Execute o workflow `safe-diagnostics`.
3. Se Docker estiver disponível, execute `docker-self-hosted`.

## Referências internas

- [Notas de segurança](security-notes.md)
- [Labels recomendadas](runner/labels.md)
- [Troubleshooting](troubleshooting.md)
