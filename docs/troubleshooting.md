# Troubleshooting

## Runner offline

- Verifique se o processo `./run.sh` está ativo no WSL2.
- Confirme se o runner foi registrado no repositório correto.
- Revise se as labels do workflow combinam com as labels do runner.

## Workflow preso em fila

- Confirme se existe um runner online apto para a label solicitada.
- Revise se o workflow usa `runs-on` compatível com o host.

## Falha de Node.js

- Verifique se `node` está instalado no runner.
- Rode `./scripts/safe-diagnostics.sh` para conferir versões básicas.

## Falha de Docker

- Verifique se o Docker está instalado e acessível no WSL2.
- Confirme se o usuário do runner tem permissão para usar o Docker.

## Logs e evidências

Use a pasta `docs/troubleshooting/` para salvar saídas, capturas e notas de análise.
