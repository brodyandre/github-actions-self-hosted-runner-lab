# Labels recomendadas para o runner

## Labels recomendadas para este laboratório

Use o conjunto abaixo ao configurar o runner:

- `self-hosted`
- `linux`
- `x64`
- `wsl2`
- `devops-lab`

## Motivo das labels

- `self-hosted`: identifica que o job será executado fora do ambiente hospedado pelo GitHub.
- `linux`: deixa explícito o sistema operacional usado no WSL2.
- `x64`: indica a arquitetura do ambiente.
- `wsl2`: diferencia esse runner de outras máquinas Linux.
- `devops-lab`: cria um identificador simples para este laboratório.

## Exemplo de uso em workflow

Mais compatível:

```yaml
runs-on: [self-hosted, linux, x64]
```

Mais específico para este laboratório:

```yaml
runs-on: [self-hosted, linux, x64, wsl2, devops-lab]
```

## Recomendação prática

Para começar, você pode usar o workflow com as labels básicas e depois evoluir para o conjunto completo quando o ambiente estiver estável.

## Boas práticas

- Use labels curtas, claras e padronizadas.
- Evite labels demais sem ganho real de organização.
- Revise as labels se o host, o sistema ou o objetivo do runner mudar.
