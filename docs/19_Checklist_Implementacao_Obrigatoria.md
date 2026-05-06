# 19 - Checklist de Implementacao Obrigatoria

## Objetivo

Evitar implementacoes parciais que funcionam em tela, mas nao respeitam:

- regras de negocio;
- escopo;
- permissao;
- rastreabilidade;
- criterio minimo de pronto.

## Checklist minimo

- regra de negocio identificada;
- fonte documental consultada;
- create/list/edit/deactivate quando houver cadastro;
- permissao e escopo considerados;
- validacao de erro tratada;
- build/teste executado;
- docs atualizados quando necessario.

## Fechamento obrigatorio de bloco

Antes de considerar um bloco pronto:

- validar o comportamento alterado;
- verificar se houve impacto em escopo, permissao, integracao, auditoria ou operacao;
- atualizar fonte de verdade e espelhos afetados;
- atualizar `docs/18_Andamento_Atual.md` se a fase avancou parcialmente;
- atualizar `docs/20`, `docs/21` e `docs/22` se o estado real mudou;
- atualizar `FLOW.md` com conclusao, pendencias e proxima acao;
- preparar commit local se houver pacote coeso.

## Fronteiras que pedem confirmacao

Mesmo com autonomia alta, o agente deve confirmar antes de:

- `git push`;
- deploy em ambiente compartilhado;
- operacao com risco de perda de dados;
- qualquer passo que exija acao manual do usuario fora do repositorio.
