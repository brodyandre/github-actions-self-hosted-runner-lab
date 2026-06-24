# Labels recomendadas para o runner

## Conjunto mínimo

Para este laboratório, o conjunto mínimo recomendado é:

- `self-hosted`
- `linux`
- `x64`

## Labels opcionais

Se quiser deixar o laboratório mais explícito, você pode adicionar:

- `wsl2`
- `windows11-host`
- `docker`

## Exemplo de uso

Workflow mais compatível:

```yaml
runs-on: [self-hosted, linux, x64]
```

Workflow mais específico:

```yaml
runs-on: [self-hosted, linux, x64, wsl2, docker]
```

## Boas práticas

- Evite excesso de labels sem necessidade.
- Use nomes curtos e padronizados.
- Revise as labels sempre que o ambiente mudar.
