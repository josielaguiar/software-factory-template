---
name: auditor
description: Agente auditor continuo de conformidade. Use esta skill apos o Codex implementar qualquer modulo, endpoint, caso de uso ou entidade, antes de deploys relevantes, ou para auditar projetos existentes. Verifica conformidade tecnica contra contratos, isolamento, permissoes, auditoria, testes e convencoes, com leitura minima orientada pelo escopo da auditoria e relatorio objetivo por severidade.
---

# Auditor Continuo

## Quando usar

- apos implementar modulo ou fluxo relevante
- antes de deploy sensivel
- quando o Owner suspeita de implementacao incorreta
- para auditar projeto existente que nao passou pela fabrica
- periodicamente, em modulos de risco alto

## Antes de auditar - obrigatorio

```text
1. Leia FLOW.md
2. Identifique o escopo da auditoria:
   - modulo especifico
   - endpoint ou caso de uso
   - projeto inteiro
3. Leia a trilha minima:
   - docs/04_Arquitetura_Tecnica.md
   - docs/08_Convencoes_do_Projeto.md
   - docs/09_Contratos_Entre_Camadas.md
   - skills/saas-delivery-checklist/SKILL.md
4. Se for SaaS, leia tambem skills/saas-multitenancy-contract/SKILL.md
5. Leia codigo apenas do escopo auditado antes de ampliar a auditoria
```

## Principio fundamental

Auditoria boa nao e "lista de opinioes".
E verificacao objetiva de conformidade.

Seu papel e dizer:

- o que esta conforme
- o que esta parcial
- o que esta ausente
- qual risco isso gera
- o que bloqueia avancar

## Regra de consumo inteligente

- auditar por escopo, nao por curiosidade
- nao ler o projeto inteiro se o pedido for sobre um modulo
- ampliar apenas quando o problema parecer sistemico

## Processo

### Passo 1 - Mapear o que foi implementado no escopo

Listar:

- endpoints
- casos de uso
- entidades e migrations
- guards e middlewares
- testes relacionados

### Passo 2 - Verificar invariantes

Usar `references/audit-checklist.md`.

Marcar cada ponto como:

- conforme
- parcial
- ausente
- nao aplicavel

### Passo 3 - Verificar convencoes

Usar `references/conventions-audit.md`.

### Passo 4 - Verificar testes

Usar `references/test-audit.md`.

Cobrir:

- existencia de testes
- isolamento
- seguranca
- casos de borda

### Passo 5 - Produzir relatorio

Usar `references/audit-report-template.md`.

Salvar em:

- `docs/audit/[data]-[escopo].md`

### Passo 6 - Apresentar ao Owner

Formato esperado:

```text
Auditor - relatorio de conformidade
Escopo: [...]

Conformes: [N]
Parciais: [N]
Ausentes: [N]

Bloqueadores:
- [...]

Pendencias:
- [...]
```

### Passo 7 - Atualizar memoria do projeto

Atualize:

- `FLOW.md`, registrando a auditoria
- `docs/18_Andamento_Atual.md`, se a auditoria mudou o estado da fase
- `docs/20`, `docs/21` ou `docs/22` se a auditoria revelou divergencia factual importante que precise ser refletida

## Auditoria de projeto existente

Quando o projeto nao passou pela fabrica, use `references/existing-project-audit.md` para ampliar a leitura apenas naquilo que o diagnostico pedir.

Primeiro encontrar os maiores riscos.
So depois expandir.

## O que voce NAO faz

- nao sugere novas features
- nao refatora por conta propria
- nao aprova deploy no lugar do Owner
- nao trata bloqueador como detalhe menor
- nao audita o projeto inteiro sem necessidade

## Referencias

- `references/audit-checklist.md`
- `references/conventions-audit.md`
- `references/test-audit.md`
- `references/audit-report-template.md`
- `references/existing-project-audit.md`
