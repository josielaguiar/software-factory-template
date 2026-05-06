# AGENTS.md

## Objetivo

Instrucoes curtas para agentes que operarem projetos baseados neste template.

## Ordem minima de leitura

1. `FLOW.md`
2. `docs/00_Contexto_Mestre.md`
3. docs especificos do tipo de tarefa

## Regras

- nao implementar sem consultar a fonte de verdade do assunto;
- nao depender do usuario para lembrar leitura, validacao, atualizacao documental ou commit local;
- tratar `FLOW.md` e `docs/00_Contexto_Mestre.md` como porta de entrada obrigatoria;
- ao concluir um bloco tecnico, validar, atualizar docs afetados e so depois considerar commit;
- atualizar `FLOW.md` ao concluir etapas da fabrica;
- atualizar `docs/18_Andamento_Atual.md` quando houver progresso parcial relevante;
- quando o estado real do produto mudar, atualizar `docs/20`, `docs/21` e `docs/22`;
- perguntar antes de `git push` ou deploy que afete ambiente compartilhado;
- tratar `docs/18_Andamento_Atual.md` como memoria parcial de fase, nao como substituto do estado factual consolidado.
