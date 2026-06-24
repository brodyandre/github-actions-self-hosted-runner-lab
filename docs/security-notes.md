# Notas de segurança

Estas orientações ajudam a manter o laboratório simples e seguro.

## Princípios básicos

- Nunca versione tokens, credenciais ou arquivos internos do runner.
- Evite executar o runner com permissões mais altas do que o necessário.
- Restrinja o uso do runner ao repositório ou organização correta.
- Não imprima segredos em logs de workflow.

## O que este repositório já protege

- `.gitignore` cobre arquivos comuns do runner, `_work`, logs e `.env`.
- O script `safe-diagnostics.sh` não exibe variáveis de ambiente.
- O setup recomendado mantém o runner fora da pasta versionada.

## Recomendações para evolução

- Criar um usuário dedicado para o runner no WSL2.
- Habilitar apenas as ferramentas realmente necessárias.
- Revisar periodicamente labels, workflows e permissões.
