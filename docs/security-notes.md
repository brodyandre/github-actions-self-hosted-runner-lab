# Notas de segurança

Estas orientações ajudam a manter o laboratório simples, profissional e seguro.

## Princípios básicos

- Nunca versione tokens, credenciais ou arquivos internos do runner.
- Não grave o token do runner em scripts, `.env`, arquivos Markdown ou qualquer arquivo do repositório.
- Use apenas os comandos oficiais fornecidos pela interface do GitHub.
- Restrinja o uso do runner ao repositório correto.
- Não imprima segredos, tokens ou `env` completo em logs.

## Token do runner

O token exibido ao criar um `self-hosted runner` é temporário.

Boas práticas:

- copie o token apenas da interface do GitHub;
- use o token somente no momento da configuração;
- não reutilize o token em automações locais;
- não compartilhe capturas de tela com o token visível.

## Uso controlado do self-hosted runner

Para este laboratório, o uso recomendado é controlado e manual.

- Prefira workflows com `workflow_dispatch` para jobs `self-hosted`.
- Evite disparar jobs `self-hosted` automaticamente em excesso.
- Ligue o runner apenas quando houver teste real a executar.
- Desligue ou pare o runner quando ele não estiver em uso.

## Repositórios públicos

Em repositórios públicos, o cuidado deve ser maior.

- Evite expor um runner pessoal a execuções não planejadas.
- Não aceite desenho de workflow que aumente a superfície de risco sem necessidade.
- Revise com atenção jobs que usam Docker, shell e acesso local ao host.
- Prefira começar com workflows manuais para reduzir risco operacional.

## O que este repositório já protege

- `.gitignore` cobre arquivos comuns do runner, `_work`, logs e `.env`.
- `safe-diagnostics.sh` imprime apenas um conjunto reduzido de informações seguras.
- O setup recomendado mantém o runner fora da pasta versionada.
- Os workflows `self-hosted` deste laboratório são manuais.

## Recomendações adicionais

- Criar um usuário dedicado para o runner no WSL2, se o laboratório evoluir.
- Habilitar apenas as ferramentas realmente necessárias.
- Revisar labels, workflows e permissões periodicamente.
- Evitar usar esse runner como ambiente genérico para outros projetos sem controle.
