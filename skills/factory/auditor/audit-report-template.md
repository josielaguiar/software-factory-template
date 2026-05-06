# Relatório de Auditoria

Data: [data]
Escopo: [módulo ou endpoint auditado]
Auditor: Auditor Contínuo Agent

---

## Resumo executivo

| Categoria | Total | ✅ Conformes | ⚠️ Parciais | ❌ Ausentes | N/A |
|---|---|---|---|---|---|
| Isolamento de tenant | | | | | |
| Feature flags | | | | | |
| RBAC | | | | | |
| Transições de estado | | | | | |
| Auditoria | | | | | |
| Correlation ID / Eventos | | | | | |
| Dados sensíveis | | | | | |
| Convenções | | | | | |
| Testes | | | | | |
| **Total** | | | | | |

---

## 🔴 Bloqueadores — corrigir antes de avançar

Estes itens representam riscos sérios e não devem ir para produção.

### [Item 1]
- **Onde:** [endpoint ou caso de uso]
- **Problema:** [descrição do problema]
- **Risco:** [o que pode acontecer se não corrigido]
- **Como corrigir:** [instrução clara para o Codex]

### [Item 2]
[idem]

---

## 🟡 Pendências — corrigir em breve

Estes itens não bloqueiam o avanço mas devem ser resolvidos.

### [Item 1]
- **Onde:** [endpoint ou caso de uso]
- **Problema:** [descrição]
- **Impacto:** [o que acontece se não corrigido]
- **Quando corrigir:** [próxima sessão / próxima fase]

---

## 🟢 Conformes

Itens que estão implementados corretamente:

- [I1] Isolamento de tenant — todas as queries filtram por empresa_id ✅
- [I3] RBAC — verificação de papel implementada no caso de uso ✅
- [item] — [descrição do que está certo]

---

## Instrução para o Codex

Cole o bloco abaixo ao pedir ao Codex para corrigir os bloqueadores:

```
Leia o relatório de auditoria em docs/audit/[data]-[modulo].md.

Corrija os seguintes bloqueadores antes de qualquer outra tarefa:

1. [descrição do bloqueador 1]
   Arquivo: [caminho]
   O que fazer: [instrução]

2. [descrição do bloqueador 2]
   Arquivo: [caminho]
   O que fazer: [instrução]

Após corrigir, rode os testes e confirme que os cenários
de isolamento de tenant passam.
```

---

## Histórico de auditorias deste módulo

| Data | Bloqueadores | Pendências | Status |
|---|---|---|---|
| [data] | [N] | [N] | [resolvido/pendente] |
