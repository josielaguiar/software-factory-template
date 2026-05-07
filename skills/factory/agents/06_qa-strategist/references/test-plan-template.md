# 11 - Plano de Testes

Produzido por: QA Strategist Agent

---

## Estratégia geral

| Tipo de teste | Responsável | Quando executar |
|---|---|---|
| Unitário | Codex/Desenvolvedor | A cada implementação de caso de uso |
| Integração | Codex/Desenvolvedor | A cada endpoint implementado |
| Segurança | Automatizado + revisão | A cada PR / antes de deploy |
| Aceite do Owner | Owner | Ao final de cada fase |
| Regressão | Automatizado | A cada deploy em staging |

---

## Testes obrigatórios de segurança

Executar em todo endpoint antes de considerar implementado:

### Autenticação
- [ ] Sem token → 401
- [ ] Token expirado → 401
- [ ] Token malformado → 401
- [ ] Token de outro ambiente → 401

### Autorização
- [ ] Papel insuficiente → 403
- [ ] Feature inativa para o tenant → 403

### Isolamento de tenant
- [ ] Usuário do tenant A tentando acessar recurso do tenant B → 404
- [ ] Listagem não retorna dados de outro tenant
- [ ] Criação não permite especificar tenant diferente do autenticado

### Validação de entrada
- [ ] Campos obrigatórios ausentes → 422 com campo identificado
- [ ] Tipo inválido → 422
- [ ] Valor fora do range permitido → 422
- [ ] SQL injection em campos de texto → tratado pelo ORM
- [ ] Payload excessivamente grande → rejeitado

---

## Plano por módulo

### Módulo: [Nome]

**Nível de risco:** 🔴 Alto / 🟡 Médio / 🟢 Baixo

#### [Funcionalidade: Nome]

**Cenários de sucesso:**
| # | Cenário | Dado de entrada | Resultado esperado |
|---|---|---|---|
| 1 | [cenário feliz principal] | [entrada] | [saída esperada] |
| 2 | [variação do cenário feliz] | [entrada] | [saída esperada] |

**Cenários de erro:**
| # | Cenário | Dado de entrada | Resultado esperado |
|---|---|---|---|
| 1 | [erro de validação] | [entrada inválida] | 422 — [mensagem] |
| 2 | [estado inválido] | [estado incorreto] | 422 — [mensagem] |
| 3 | [sem permissão] | [usuário errado] | 403 |
| 4 | [outro tenant] | [id de outro tenant] | 404 |

**Casos de borda:**
| # | Caso | Comportamento esperado |
|---|---|---|
| 1 | [borda 1] | [comportamento] |
| 2 | [borda 2] | [comportamento] |

**Testes de regressão (executar sempre):**
- [ ] [cenário crítico que nunca pode quebrar]

---

### Módulo: [Próximo módulo]
[idem]

---

## Checklist de aceite por fase

### Fase 1 — [Nome]

O Owner executa manualmente antes de aprovar a fase:

**Fluxos principais:**
- [ ] [ação que o Owner executa] → [resultado que deve ver]
- [ ] [ação que o Owner executa] → [resultado que deve ver]

**Verificações de segurança (Owner testa):**
- [ ] Tentei acessar com usuário sem permissão → fui bloqueado
- [ ] Tentei editar registro de outra empresa → não consegui

**Verificações de dados:**
- [ ] Os valores calculados estão corretos
- [ ] O relatório bate com os lançamentos
- [ ] A exportação CSV tem os dados corretos

**Critério de aprovação:**
[ ] Todos os itens acima verificados sem erro crítico

---

## Regressão obrigatória a cada deploy

Execute antes de qualquer deploy em produção:

- [ ] Login funciona com credenciais válidas
- [ ] Login falha com credenciais inválidas
- [ ] Isolamento de tenant funcionando (teste automatizado passa)
- [ ] [fluxo crítico 1 do produto] funciona
- [ ] [fluxo crítico 2 do produto] funciona
- [ ] Nenhum erro 500 em endpoints principais

---

## Riscos de qualidade identificados

| Risco | Severidade | Probabilidade | Mitigação |
|---|---|---|---|
| [risco 1] | 🔴/🟡/🟢 | Alta/Média/Baixa | [como mitigar] |
| [risco 2] | 🔴/🟡/🟢 | Alta/Média/Baixa | [como mitigar] |
