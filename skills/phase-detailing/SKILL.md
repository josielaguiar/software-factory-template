---
name: phase-detailing
description: Detalha ou redetalha fases de produto em projetos conduzidos por owner nao tecnico. Use quando o pedido for abrir uma fase, expandir escopo, quebrar em subfases, reorganizar backlog de fase, definir obrigatoriedades de redeploy/auditoria ou consolidar o que a fase deve atualizar na documentacao.
---

# Phase Detailing

## Overview

Esta skill existe para transformar uma fase macro em um plano de fase bem governado, sem pular direto para execucao nem criar backlog improvisado. Ela trabalha integrada com `FLOW.md`, `docs/00_Contexto_Mestre.md` e `skills/factory`.

## Quando usar

Use esta skill quando o pedido for:

- detalhar uma fase nova
- expandir uma fase ja existente
- abrir subfases ou blocos de execucao
- reorganizar a sequencia de implantacao
- definir o que entra em redeploy, auditoria e atualizacao documental
- adaptar o planejamento para um owner nao tecnico com consumo eficiente de creditos

Nao use esta skill para implementacao tecnica isolada. Nesse caso, siga o fluxo normal de execucao a partir do `docs/18_Plano_de_Implementação.md`.

## Workflow

### 1. Confirmar o tipo de pedido

Classifique o pedido em uma destas situacoes:

- fase nova em nivel macro
- expansao relevante de fase
- redetalhamento de fase ja existente
- apenas sequencia de implantacao
- apenas redeploy/auditoria/documentacao final

### 2. Ler a base minima

Leia sempre nesta ordem:

1. `FLOW.md`
2. `docs/00_Contexto_Mestre.md`
3. `docs/07_Roadmap.md`
4. `docs/18_Plano_de_Implementação.md`
5. `docs/15_Pendencias_e_Bloqueantes.md`
6. `docs/Decisoes.md`

Depois, complete com docs especificos do tema.

### 3. Decidir se entra a factory

Use `skills/factory` antes de consolidar a fase quando:

- a fase ainda esta aberta em nivel macro
- houve expansao relevante de escopo
- ha duvida sobre separacao entre produto, UX, arquitetura, execucao e QA
- falta convergencia sobre o que a fase deve entregar

Padrao recomendado de agentes:

1. `Business Analyst`
2. `UX Strategist`
3. `Software Architect`
4. `Tech Lead`
5. `QA Strategist`

Regra de custo:

- por padrao, rode em sequencia
- use paralelismo apenas quando as perguntas forem independentes e o ganho justificar o custo de credito

### 4. Consolidar a fase

Ao detalhar a fase, garantir que ela responda:

- objetivo macro
- escopo funcional
- separacao entre produto, UX e arquitetura
- principais regras e invariantes
- dependencias externas
- riscos e pendencias abertas
- criterio de pronto

### 5. Quebrar em subfases obrigatorias

Toda fase ou bloco relevante deve prever, no minimo:

1. definicao e fechamento das regras
2. implementacao
3. atualizacao dos docs factuais/operacionais impactados
4. redeploy e validacao operacional, quando houver impacto em ambiente publicado
5. auditoria final do bloco

### 6. Explicitar a subfase de redeploy

Quando houver deploy real, registrar:

- o que o agente consegue fazer com seguranca
- o que depende do owner
- migrations, seed, riscos de dados e janelas de atencao
- validacoes pos-deploy

### 7. Explicitar a subfase de auditoria

Ao final da fase ou bloco importante, prever:

- `doc-consistency-review`
- checklist funcional ou QA estrategico correspondente
- atualizacao final de `FLOW.md` e dos docs afetados

## Onde registrar o resultado

Propague o detalhamento para os docs certos:

- `docs/07_Roadmap.md`
  - escopo macro da fase
- `docs/18_Plano_de_Implementação.md`
  - ordem de implantacao e subfases
- `docs/15_Pendencias_e_Bloqueantes.md`
  - riscos e abertos
- `docs/Decisoes.md`
  - decisoes consolidadas
- `docs/19` a `22`
  - quando a fase mudar o estado factual/operacional do produto publicado
- `FLOW.md`
  - quando o estado do processo mudar

## Premissas deste projeto

- owner nao tecnico: explique implicacoes e checkpoints sem presumir conhecimento tecnico
- previsibilidade vale mais que velocidade bruta
- docs e skills devem formar um ciclo: doc orienta skill, skill orienta leitura e o resultado volta para os docs
- evitar releitura ampla sem necessidade; use o minimo de contexto util para cada passo

## Saida esperada

Uma fase bem detalhada deve sair com:

- escopo fechado
- subfases claras
- ordem de implantacao definida ou preparada para o `docs/18`
- redeploy previsto quando aplicavel
- auditoria prevista
- docs corretos identificados para atualizacao
