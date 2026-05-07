# Test Audit

Verifica se os testes implementados cobrem o que é obrigatório.

---

## Testes unitários — casos de uso

| # | Verificação | Status |
|---|---|---|
| 1 | Existe arquivo .spec.ts para o caso de uso | |
| 2 | Caminho feliz testado | |
| 3 | Feature inativa testada → lança ForbiddenException | |
| 4 | Papel insuficiente testado → lança ForbiddenException | |
| 5 | Estado inválido testado → lança erro 422 | |
| 6 | Casos de borda do domínio testados | |

---

## Testes de integração — endpoints

| # | Verificação | Status |
|---|---|---|
| 1 | Teste sem token → 401 | |
| 2 | Teste com token inválido → 401 | |
| 3 | Teste com papel insuficiente → 403 | |
| 4 | Teste com feature inativa → 403 | |
| 5 | Teste de isolamento: ID de outro tenant → 404 | |
| 6 | Teste de isolamento: listagem não retorna outro tenant | |
| 7 | Teste de validação: campo obrigatório ausente → 422 | |
| 8 | Caminho feliz completo testado | |

---

## Testes de segurança

| # | Verificação | Status |
|---|---|---|
| 1 | Teste verifica que empresa_id não pode vir do body | |
| 2 | Teste verifica que resposta não expõe dados de outro tenant | |
| 3 | Teste verifica que operação destrutiva em outro tenant → 404 | |
| 4 | Teste verifica que senha não aparece em nenhuma resposta | |

---

## Cobertura por módulo

Para cada módulo auditado, registre:

| Módulo | Unitário | Integração | Segurança | Observação |
|---|---|---|---|---|
| [módulo] | ✅/⚠️/❌ | ✅/⚠️/❌ | ✅/⚠️/❌ | |

---

## O que fazer quando teste está ausente

Se um teste obrigatório está ausente, registre como:

```
❌ Ausente — [tipo de teste] para [módulo/endpoint]
Risco: [o que pode falhar sem este teste]
Ação: adicionar antes do próximo deploy em staging
```

Testes de isolamento de tenant ausentes são sempre 🔴 Bloqueador.
