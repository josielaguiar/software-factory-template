# Checklist de Entrega SaaS

Use este checklist para **toda entrega** de endpoint, caso de uso ou entidade. Declare explicitamente cada item antes de considerar a implementação concluída.

---

## Checklist por caso de uso

Antes de considerar qualquer caso de uso implementado, responda cada item:

### Isolamento de tenant
- [ ] O tenant_id vem do contexto de autenticação, não do body?
- [ ] Toda consulta ao banco filtra por tenant_id?
- [ ] Busca por ID inclui tenant_id no filtro?
- [ ] Nenhum recurso de outro tenant pode ser acessado por esta operação?

### Feature flag
- [ ] A feature correspondente está definida na tabela de features?
- [ ] O caso de uso verifica se a feature está ativa antes de executar?
- [ ] Feature inativa retorna 403 com mensagem clara?

### RBAC
- [ ] O papel mínimo necessário está documentado para esta operação?
- [ ] O papel é verificado contra o vínculo usuário-tenant, não apenas contra o token?
- [ ] Papel insuficiente retorna 403 antes de qualquer lógica de negócio?

### Transição de estado (se aplicável)
- [ ] O status muda por caso de uso nomeado, não por PATCH livre?
- [ ] Pré-condições são validadas antes da mudança de estado?
- [ ] Estado inválido retorna erro com mensagem descritiva?
- [ ] Tentativa de operação em estado incompatível é rejeitada?

### Auditoria (para ações críticas)
- [ ] A ação está na lista de ações críticas do projeto?
- [ ] Auditoria é registrada dentro da mesma transação?
- [ ] Registro inclui: ação, entidade, id da entidade, estado antes, estado depois, usuário, tenant, ip?
- [ ] Falha na auditoria impede a operação de ser concluída?

### Eventos operacionais
- [ ] O evento correspondente está definido na lista de eventos do projeto?
- [ ] Evento é emitido após o commit da transação?
- [ ] Evento inclui correlation_id?
- [ ] Falha no evento não reverte a operação principal?

### Testes
- [ ] Teste verifica que usuário de outro tenant não acessa o recurso?
- [ ] Teste verifica que feature inativa bloqueia a operação?
- [ ] Teste verifica que papel insuficiente bloqueia a operação?
- [ ] Teste verifica que estado inválido é rejeitado?
- [ ] Teste verifica o caminho feliz?

---

## Checklist por entidade nova

Ao criar uma nova entidade no banco:

### Schema
- [ ] Campo tenant_id presente e não nulo?
- [ ] Índice em (tenant_id, ...) para as consultas mais comuns?
- [ ] UUID para chave primária?
- [ ] Timestamps (created_at, updated_at) presentes?
- [ ] Campos de auditoria (created_by, updated_by) onde necessário?

### Migration
- [ ] Migration é reversível (down está implementado)?
- [ ] Migration não insere dados sensíveis em texto puro?
- [ ] Constraints de unicidade definidas (ex: único por tenant)?

### Repositório
- [ ] Todos os métodos de busca incluem tenant_id no filtro por padrão?
- [ ] Método de busca por ID inclui tenant_id?

---

## Como declarar na entrega

Ao entregar uma implementação, inclua um bloco como este:

```
## Conformidade SaaS

| Invariante | Status | Observação |
|---|---|---|
| I1 - Isolamento de tenant | ✅ | Filtro por empresa_id em todas as queries |
| I2 - Feature flag | ✅ | Verifica FIN_PAGAR_MANUAL antes de executar |
| I3 - RBAC | ✅ | Verifica papel Financeiro no vínculo |
| I4 - Transição de estado | ✅ | POST /contas/:id/pagar, não PATCH |
| I5 - Auditoria | ✅ | FIN_CONTA_MARCADA_PAGA dentro da transação |
| I6 - Correlation ID | ✅ | Middleware injeta no contexto |
| I7 - Dados sensíveis | N/A | Sem dados sensíveis neste caso de uso |
| I8 - Tenant do contexto | ✅ | empresa_id vem do JWT decodificado |
```

---

## Checklist de auditoria retroativa

Use para auditar implementações existentes:

```
Para cada endpoint/caso de uso existente:
1. Identifique o recurso e o tenant esperado
2. Verifique se o filtro de tenant está presente nas queries
3. Verifique se feature flag está sendo verificada
4. Verifique se RBAC está sendo verificado
5. Identifique transições de estado — são por caso de uso ou por PATCH livre?
6. Verifique se ações críticas têm auditoria
7. Registre o que está conforme, o que está faltando e o que precisa ser corrigido
```
