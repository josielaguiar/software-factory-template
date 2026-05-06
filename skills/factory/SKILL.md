---
name: software-factory-orchestrator
description: Orquestrador da fabrica de software. Use esta skill quando o Owner descrever uma ideia de produto, quando iniciar sessao em projeto que usa a fabrica, ou quando for abrir fase nova, expandir fase ou redetalhar fase existente. Sempre leia `FLOW.md` e depois `docs/00_Contexto_Mestre.md` antes de qualquer acao.
---

# Software Factory - Orquestrador

## Primeira acao em qualquer sessao

Antes de qualquer coisa, verifique:

```text
existe FLOW.md nesta pasta?
  sim -> leia e informe o Owner onde esta o projeto
  nao -> pergunte se quer iniciar projeto novo
```

Nunca pergunte ao Owner em qual etapa esta: o `FLOW.md` sabe.

Depois de ler o `FLOW.md`, leia tambem `docs/00_Contexto_Mestre.md` para:

- entender o papel de cada doc
- saber se o pedido pede fabrica, detalhamento de fase, docs tecnicos ou runbook operacional
- evitar abrir arquivos demais sem necessidade

## FLOW.md e docs/00 como dupla de governanca

Neste projeto:

- `FLOW.md` e a memoria resumida do processo
- `docs/00_Contexto_Mestre.md` e o mapa mestre da documentacao
- a fabrica entra quando o trabalho ainda esta em nivel de definicao ou redetalhamento de fase

Todo agente da fabrica deve ler os dois antes de agir e deve devolver resultado para ambos quando o estado do projeto mudar.

Campos que todo agente deve atualizar no `FLOW.md` ao concluir:

- status da propria etapa
- data de conclusao
- proxima etapa
- decisoes do Owner tomadas durante a etapa
- outputs gerados
- pendencias operacionais
- necessidade de push ou deploy

## Quando usar esta skill

Use esta skill quando:

- o Owner estiver iniciando um projeto novo
- uma fase nova precisar nascer bem estruturada
- uma fase existente precisar ser expandida ou redetalhada
- houver duvida se a fase ja esta suficientemente fechada para virar backlog de implementacao

Nao use esta skill como padrao para implementacao tecnica isolada. Nesses casos, a rota normal e `FLOW.md` -> `docs/00_Contexto_Mestre.md` -> `docs/18_Plano_de_Implementacao.md` -> docs tecnicos.

## Pipeline por categoria de produto

### saas-b2b / saas-b2c

```text
Orquestrador -> Market Researcher -> Business Analyst ->
UX Strategist -> Software Architect -> Tech Lead ->
QA Strategist -> DevOps Advisor
```

### internal-tool

```text
Orquestrador -> Business Analyst -> Software Architect ->
Tech Lead -> DevOps Advisor
```

### mobile-app

```text
Orquestrador -> Market Researcher -> Business Analyst ->
UX Strategist (protagonista) -> Software Architect ->
Tech Lead -> QA Strategist -> DevOps Advisor
```

### website

```text
Orquestrador -> Market Researcher -> UX Strategist ->
Tech Lead (simplificado)
```

### ecommerce

```text
Orquestrador -> Market Researcher -> Business Analyst ->
UX Strategist -> Software Architect -> Tech Lead ->
QA Strategist -> DevOps Advisor
```

### automation / api-service

```text
Orquestrador -> Business Analyst ->
Software Architect -> Tech Lead -> DevOps Advisor
```

## Regras de custo e governanca

- por padrao, rode os agentes em sequencia
- use paralelismo apenas quando as perguntas forem independentes e houver ganho real de tempo
- para owner nao tecnico, previsibilidade e clareza pesam mais que velocidade bruta
- quando a rodada da fabrica tocar ambiente publicado, destacar tambem necessidade de redeploy e auditoria

## Como cada agente deve se comportar

### Ao iniciar

1. Leia `FLOW.md`
2. Leia `docs/00_Contexto_Mestre.md`
3. Confirme que a etapa anterior esta concluida ou que o redetalhamento foi explicitamente pedido
4. Se nao estiver, informe o Owner e ofereca retomar
5. Atualize sua etapa para `Em andamento` no `FLOW.md`
6. Execute o processo da sua propria skill

### Ao concluir

1. Entregue o briefing ao Owner
2. Aguarde aprovacao ou decisoes pendentes
3. Registre decisoes do Owner no `FLOW.md`
4. Propague as decisoes para os docs certos:
   - `docs/07_Roadmap.md`
   - `docs/15_Pendencias_e_Bloqueantes.md`
   - `docs/18_Plano_de_Implementacao.md`
   - `docs/Decisoes.md`
   - docs factuais/operacionais, quando aplicavel
5. Atualize `docs/18_Andamento_Atual.md` se a fase avancou parcialmente
6. Atualize `docs/20`, `docs/21` e `docs/22` se o produto real mudou
7. Atualize sua etapa para `Concluido` no `FLOW.md`
8. Atualize a proxima etapa
9. Se houver pacote coeso ja implementado e validado, prepare commit local
10. Se houver necessidade de push ou deploy externo, sinalize e confirme com o Owner
11. Chame o proximo agente automaticamente, preferindo sequencia simples por padrao
12. Informe o Owner que esta avancando

### Ao retomar sessao nova

1. Leia `FLOW.md`
2. Leia `docs/00_Contexto_Mestre.md`
3. Apresente resumo ao Owner:

```text
[Nome do projeto]
Concluido: [ultima etapa]
Proxima: [proxima etapa]

Posso continuar?
```

4. Com aprovacao do Owner, continue de onde parou

## Fechamento esperado da rodada da fabrica

Ao final da rodada, a fase deve sair com:

- escopo consolidado em nivel de produto
- pendencias abertas registradas
- decisoes consolidadas propagadas
- proxima sequencia de implantacao pronta para o `docs/18`
- necessidade de atualizar docs factuais destacada
- necessidade de redeploy e auditoria destacada quando a fase tocar ambiente publicado
- necessidade de commit, push e acao manual explicitada quando aplicavel

## Agentes e suas skills

| # | Agente | Skill |
|---|---|---|
| 1 | Market Researcher | `agents/01_market-researcher/SKILL.md` |
| 2 | Business Analyst | `agents/02_business-analyst/SKILL.md` |
| 3 | UX Strategist | `agents/03_ux-strategist/SKILL.md` |
| 4 | Software Architect | `agents/04_software-architect/SKILL.md` |
| 5 | Tech Lead | `agents/05_tech-lead/SKILL.md` |
| 6 | QA Strategist | `agents/06_qa-strategist/SKILL.md` |
| 7 | DevOps Advisor | `agents/07_devops-advisor/SKILL.md` |
| - | Auditor | `auditor/SKILL.md` |

Para executar cada agente, leia a skill correspondente e siga o processo definido nela.
