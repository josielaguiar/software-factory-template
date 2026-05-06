---
name: template-installer
description: Instala ou sincroniza o repositório `josielaguiar/software-factory-template` em um projeto novo ou existente. Use quando o usuário pedir para aplicar o modelo base, estruturar documentação e skills em um projeto pela primeira vez, atualizar o template em projetos já adotados, ou preparar a base operacional de um repositório antes do trabalho normal começar.
---

# Template Installer

Instalar e sincronizar o `software-factory-template` a partir do GitHub, com suporte a:

- projeto novo;
- projeto existente;
- sincronizacao de skills e guias compartilhados.

## Fluxo

1. Determinar o alvo:
   - usar o diretório atual se o usuário não informar outro;
   - usar o caminho informado se ele existir ou puder ser criado.
2. Determinar o modo:
   - `new` quando a pasta estiver vazia ou o usuário disser que é projeto novo;
   - `existing` quando já houver código ou arquivos do projeto;
   - `sync` quando o projeto já usa o template e o pedido for atualizar a fábrica.
3. Ler `references/modes.md` se houver dúvida sobre a escolha do modo.
4. Executar `scripts/bootstrap_from_github.py`.
5. Resumir:
   - modo usado;
   - destino;
   - quantos arquivos foram criados, atualizados e ignorados;
   - próximo passo recomendado.

## Regras operacionais

- Preservar arquivos existentes por padrão.
- Só sobrescrever com `--force` quando o usuário pedir claramente ou quando o risco estiver alinhado.
- Em `sync`, não sobrescrever `FLOW.md` nem docs factuais do projeto por padrão.
- Se o usuário não especificar o modo, inferir pelo estado da pasta e dizer qual modo foi assumido.
- Depois de `existing`, orientar explicitamente o preenchimento de `docs/20`, `docs/21` e `docs/22`.
- Não abrir discussão longa sobre GitHub se o repositório padrão já servir. O padrão é `josielaguiar/software-factory-template`.

## Script

Usar:

```bash
python scripts/bootstrap_from_github.py --target <caminho> --mode <new|existing|sync>
```

Opções úteis:

- `--repo josielaguiar/software-factory-template`
- `--ref main`
- `--source-path <pasta-local>` para validar ou usar um checkout local do template
- `--force`
- `--include-guides` para sincronizar também `AGENTS.md` e `CLAUDE.md`
- `--init-git`
- `--remote-url <url>`

## Resposta esperada

Ao concluir, responder de forma curta, por exemplo:

```text
Template aplicado em modo existing em C:\Projeto\repo.
Criados: X
Atualizados: Y
Ignorados: Z

Proximo passo: preencher docs/20, docs/21 e docs/22 com o estado real do produto.
```
