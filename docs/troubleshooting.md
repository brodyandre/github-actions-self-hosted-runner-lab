# Troubleshooting

## Runner não aparece como Online

- Verifique se `./run.sh` está ativo no WSL2.
- Confirme se o runner foi registrado no repositório correto.
- Revise se o cadastro foi feito com os comandos oficiais da interface do GitHub.
- Se necessário, refaça a configuração usando um novo token temporário gerado pelo GitHub.

## Runner offline após fechar o terminal

- O comando `./run.sh` depende da sessão ativa.
- Se a janela do terminal for fechada, o runner pode parar.
- Para este laboratório, isso é aceitável quando o uso for manual e controlado.

## Workflow self-hosted preso em fila

- Confirme se existe um runner `Online`.
- Verifique se o workflow usa labels compatíveis com o runner cadastrado.
- Revise se o job foi configurado para `workflow_dispatch` e disparado manualmente.

## Labels não correspondem

- Confirme se o runner foi registrado com:
  `self-hosted`, `linux`, `x64`, `wsl2`, `devops-lab`
- Se o workflow usar labels mais específicas do que o runner possui, o job ficará aguardando.

## Falha na configuração do runner

- Verifique se você está usando os comandos oficiais exibidos pelo GitHub.
- Confirme se o token usado foi copiado diretamente da interface.
- Lembre que o token do runner é temporário e pode expirar.

## Falha de Node.js

- Os workflows deste laboratório instalam `Node 20` com `actions/setup-node`.
- Ainda assim, vale validar se o host está saudável com `./scripts/safe-diagnostics.sh`.

## Falha de Docker

- Verifique se o Docker está instalado e acessível no WSL2.
- Confirme se o usuário do runner tem permissão para usar o Docker.
- Se o laboratório não precisar de Docker naquele momento, execute apenas os workflows de validação simples.

## Cuidados em repositórios públicos

- Evite manter o runner ativo sem necessidade.
- Prefira jobs manuais em `workflow_dispatch`.
- Revise com atenção qualquer mudança em workflows que executem shell, Docker ou acesso ao host.

## Logs e evidências

Use a pasta `docs/troubleshooting/` para salvar saídas, capturas e notas de análise.
