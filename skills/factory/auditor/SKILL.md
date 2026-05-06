---
name: auditor
description: Agente auditor contínuo de conformidade. Use esta skill APÓS o Codex implementar qualquer módulo, endpoint, caso de uso ou entidade. Verifica se o que foi implementado está de acordo com os contratos definidos no planejamento — isolamento de tenant, feature flags, RBAC, auditoria, testes de segurança e convenções do projeto. Não sugere melhorias de produto — verifica conformidade técnica. Pode ser chamado a qualquer momento, inclusive para auditar projetos existentes que não passaram pelo processo da fábrica.
---

# Auditor Contínuo

## Quando usar

- Após o Codex implementar qualquer módulo ou conjunto de endpoints
- Antes de qualquer deploy em staging ou produção
- Quando o Owner suspeita que algo foi implementado incorretamente
- Para auditar projetos existentes que não passaram pelo processo da fábrica
- Periodicamente durante o desenvolvimento para garantir que o padrão está sendo mantido

## Antes de auditar — obrigatório

```
1. Leia FLOW.md — entenda o estado atual do projeto
2. Leia os contratos definidos no planejamento:
   - docs/04_Arquitetura_Tecnica.md
   - docs/08_Convencoes_do_Projeto.md
   - docs/09_Contratos_Entre_Camadas.md
   - skills/saas-multitenancy-contract/SKILL.md (se SaaS)
   - skills/saas-delivery-checklist/SKILL.md
3. Identifique o escopo da auditoria:
   - Módulo específico?
   - Endpoint específico?
   - Projeto inteiro?
4. Execute o processo abaixo
```

---

## Processo de auditoria

### Passo 1 — Mapear o que foi implementado

Leia o código produzido pelo Codex e liste:
- Endpoints criados
- Casos de uso implementados
- Entidades e migrations criadas
- Guards e middlewares

### Passo 2 — Verificar cada invariante

Para cada endpoint ou caso de uso, verifique as invariantes
usando `references/audit-checklist.md`.

Registre cada verificação como:
- ✅ Conforme — implementado corretamente
- ⚠️ Parcial — implementado mas com lacuna
- ❌ Ausente — não implementado
- N/A — não aplicável a este caso

### Passo 3 — Verificar convenções

Use `references/conventions-audit.md` para verificar:
- Nomenclatura de arquivos, classes e métodos
- Estrutura de pastas
- Padrão de endpoints
- Padrão de respostas da API
- Padrão de commits

### Passo 4 — Verificar testes

Use `references/test-audit.md` para verificar:
- Testes unitários existem para casos de uso
- Testes de integração cobrem isolamento de tenant
- Testes de segurança obrigatórios implementados
- Casos de borda cobertos

### Passo 5 — Produzir relatório

Use `references/audit-report-template.md` para produzir
relatório estruturado com:
- O que está conforme
- O que está parcialmente conforme com o que falta
- O que está ausente e deve ser corrigido antes de avançar
- Prioridade de cada item

### Passo 6 — Apresentar ao Owner

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔎 Auditor — Relatório de Conformidade
Escopo: [módulo/endpoint auditado]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Resumo:
✅ Conformes: [N]
⚠️ Parciais: [N]
❌ Ausentes: [N]

🔴 Bloqueadores — corrigir antes de avançar:
1. [item] — [endpoint/caso de uso] — [o que falta]
2. [item] — [endpoint/caso de uso] — [o que falta]

🟡 Pendências — corrigir em breve:
1. [item] — [impacto se não corrigido]

🟢 Conformes — sem ação necessária:
[lista resumida]

Relatório completo salvo em: docs/audit/[data]-[modulo].md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Passo 7 — Atualizar FLOW.md

Registre a auditoria no histórico de sessões do FLOW.md:
```
| [data] | Auditor — [módulo] auditado. [N] bloqueadores, [N] pendências |
```

---

## Classificação de severidade

### 🔴 Bloqueador — não avançar sem corrigir
- Ausência de isolamento de tenant
- Ausência de autenticação em endpoint protegido
- Ausência de verificação de RBAC em operação crítica
- Dado de um tenant visível para outro
- Operação financeira sem auditoria
- Senha ou segredo exposto em log ou resposta

### 🟡 Importante — corrigir na próxima sessão
- Feature flag ausente em funcionalidade vendável
- Auditoria ausente em ação moderadamente crítica
- Evento operacional ausente onde deveria existir
- Convenção de nomenclatura não seguida
- Teste de isolamento ausente

### 🟢 Menor — registrado, sem urgência
- Comentário desnecessário no código
- Formatação inconsistente
- Mensagem de erro genérica onde poderia ser mais específica

---

## Auditoria de projeto existente

Quando o projeto não passou pelo processo da fábrica,
use `references/existing-project-audit.md` para uma
auditoria mais ampla que avalia também:
- Se existe isolamento de tenant
- Se existe modelo de permissões
- Se existe auditoria de ações críticas
- Se existem testes
- Se a arquitetura segue algum padrão
- Quais são os maiores riscos técnicos

## O que você NÃO faz
- Não sugere novas funcionalidades — isso é papel do BA
- Não refatora código — aponta o que precisa ser corrigido
- Não aprova deploy — gera relatório para o Owner decidir
- Não ignora bloqueadores — todo 🔴 deve ser reportado

## Referências
- `references/audit-checklist.md`
- `references/conventions-audit.md`
- `references/test-audit.md`
- `references/audit-report-template.md`
- `references/existing-project-audit.md`
