---
name: saas-delivery-checklist
description: Checklist de entrega e template de user story para projetos SaaS. Use esta skill SEMPRE que for escrever, detalhar ou implementar uma user story, tarefa técnica ou entrega de funcionalidade em um projeto SaaS. Também use para auditar implementações existentes contra critérios de qualidade SaaS. Se o agente está prestes a implementar algo sem critérios técnicos explícitos, esta skill deve ser carregada primeiro. Aplica-se especialmente quando há risco de decisões silenciosas sobre isolamento, permissões, auditoria ou estado.
---

# SaaS Delivery Checklist

Esta skill resolve um problema específico: agentes de IA são competentes tecnicamente, mas tomam **decisões silenciosas** sobre isolamento de tenant, permissões, auditoria e transições de estado. Esta skill torna essas decisões explícitas e verificáveis.

---

## Problema que esta skill resolve

Quando um agente recebe "cria o endpoint de baixa de título", ele cria algo funcional. Mas "funcional" não é o mesmo que "correto para SaaS". As decisões que ficam implícitas:

- O tenant_id está sendo verificado?
- A feature está sendo checada?
- O status muda por PATCH livre ou por caso de uso?
- A auditoria está dentro da transação?
- O que acontece se a conta já estiver cancelada?

Esta skill exige que o agente declare essas decisões antes e depois de implementar.

---

## Template de user story com critérios técnicos

Use este template para **toda tarefa de implementação**. Preencha antes de escrever código.

```markdown
## User Story

**Como** [papel do usuário]
**Quero** [ação que o usuário executa]
**Para** [objetivo ou resultado esperado]

## Contexto de negócio
[O que o usuário vê na tela. O que ele espera que aconteça. Casos de erro do ponto de vista do usuário.]

## Critérios de aceite funcionais
- [ ] [comportamento observável 1]
- [ ] [comportamento observável 2]
- [ ] [comportamento de erro esperado]

## Critérios técnicos obrigatórios (SaaS)

### Isolamento
- Tenant: `[campo]` vem de `[fonte — JWT/contexto/sessão]`
- Queries filtram por: `[campo de tenant]`

### Feature flag
- Feature verificada: `[FEATURE_CODE]`
- Comportamento se inativa: `403 - [mensagem]`

### RBAC
- Papel mínimo: `[PAPEL]`
- Verificado em: `[guard/caso de uso]`
- Comportamento se insuficiente: `403 - [mensagem]`

### Transição de estado (se aplicável)
- Estado atual válido para executar: `[estados permitidos]`
- Estado resultante: `[estado após a operação]`
- Caso de uso nomeado: `[NomeDoUseCase]`
- Comportamento se estado inválido: `[erro retornado]`

### Auditoria
- Ação auditada: `[CODIGO_AUDITORIA]`
- Campos em `antes`: `[campos]`
- Campos em `depois`: `[campos]`
- Momento: dentro da transação

### Evento operacional
- Evento emitido: `[TIPO_EVENTO]`
- Momento: após o commit
- Inclui correlation_id: sim

## Pré-condições
[O que precisa existir antes desta operação funcionar]

## Pós-condições
[O que deve ser verdade após a operação concluir com sucesso]

## Testes obrigatórios
- [ ] Caminho feliz
- [ ] Usuário de outro tenant tentando acessar → 403
- [ ] Feature inativa → 403
- [ ] Papel insuficiente → 403
- [ ] Estado inválido → [erro esperado]
- [ ] [Outros casos de borda do domínio]
```

---

## Fluxo obrigatório antes de implementar

Antes de escrever qualquer linha de código, o agente deve:

1. **Preencher o template** para a tarefa atual
2. **Declarar as decisões** que tomaria silenciosamente:
   - "O tenant_id virá de X porque Y"
   - "A feature verificada é X porque é essa operação"
   - "O papel mínimo é X porque esta operação afeta dados financeiros"
3. **Apontar riscos** se algum critério não puder ser atendido agora
4. **Só então implementar**

---

## Fluxo obrigatório após implementar

Ao entregar a implementação, incluir o bloco de conformidade:

```markdown
## Conformidade SaaS — [Nome da Tarefa]

| Critério | Status | Como foi atendido |
|---|---|---|
| Isolamento de tenant | ✅/⚠️/❌ | [descrição] |
| Feature flag | ✅/⚠️/❌ | [descrição] |
| RBAC | ✅/⚠️/❌ | [descrição] |
| Transição de estado | ✅/N/A/❌ | [descrição] |
| Auditoria | ✅/⚠️/❌ | [descrição] |
| Evento operacional | ✅/⚠️/❌ | [descrição] |
| Testes de isolamento | ✅/⚠️/❌ | [descrição] |

### Decisões tomadas
[Liste decisões não óbvias que foram tomadas durante a implementação]

### Pendências conhecidas
[O que ficou fora do escopo desta entrega e precisa ser feito depois]
```

Legenda:
- ✅ Atendido completamente
- ⚠️ Atendido parcialmente — pendência registrada
- ❌ Não atendido — justificativa obrigatória
- N/A Não aplicável a este caso de uso

---

## Como usar para auditar implementações existentes

Quando o usuário pede para auditar código já existente:

1. Para cada endpoint ou caso de uso identificado:
   - Verifique cada critério do checklist
   - Documente o que está conforme, o que está faltando, o que está errado
2. Gere um relatório no formato:

```markdown
## Relatório de Auditoria SaaS — [Módulo]

### Conforme
- [endpoint/caso de uso]: [critérios atendidos]

### Com pendências
- [endpoint/caso de uso]: falta [critério] — [como corrigir]

### Não conforme
- [endpoint/caso de uso]: [critério ausente] — [risco] — [correção necessária]

### Resumo
- Total auditado: X
- Conformes: X
- Com pendências: X  
- Não conformes: X
```

---

## Exemplo preenchido

```markdown
## User Story — Baixa parcial de conta financeira

**Como** Financeiro da empresa
**Quero** registrar um pagamento parcial de um título
**Para** que o saldo restante fique em aberto e o histórico seja auditável

## Contexto de negócio
Josiel abre a lista de contas a pagar, seleciona um título de R$ 1.000,
clica em "Registrar pagamento", informa que pagou R$ 600 via PIX pela
conta Bradesco, e salva. O sistema deve manter R$ 400 em aberto.

## Critérios de aceite funcionais
- [ ] Usuário informa valor_pago, data, forma_pagamento e conta_bancaria
- [ ] Sistema valida que valor_pago é menor que valor total
- [ ] Sistema mantém saldo restante em aberto com status 'parcial'
- [ ] Conta já paga ou cancelada não pode ser baixada parcialmente
- [ ] Confirmação exibe saldo restante antes de salvar

## Critérios técnicos obrigatórios

### Isolamento
- Tenant: `empresa_id` vem do JWT decodificado
- Queries filtram por: `empresa_id`

### Feature flag
- Feature verificada: `FIN_PAGAR_MANUAL`
- Comportamento se inativa: `403 - Funcionalidade não disponível no plano atual`

### RBAC
- Papel mínimo: `Financeiro`
- Verificado em: caso de uso BaixarParcialmente
- Comportamento se insuficiente: `403 - Permissão insuficiente`

### Transição de estado
- Estado atual válido: `aberto`, `vencido`
- Estado resultante: `parcial`
- Caso de uso nomeado: `BaixarParcialmente`
- Comportamento se estado inválido: `422 - Conta não pode ser baixada no estado atual`

### Auditoria
- Ação auditada: `FIN_CONTA_BAIXA_PARCIAL`
- Campos em `antes`: `{ status, valor_pago, data_pagamento }`
- Campos em `depois`: `{ status: 'parcial', valor_pago, data_pagamento, forma_pagamento, conta_bancaria_id }`
- Momento: dentro da transação

### Evento operacional
- Evento emitido: `FIN_CONTA_MARCADA_PAGA`
- Momento: após o commit
- Inclui correlation_id: sim

## Testes obrigatórios
- [ ] Caminho feliz — parcial registrado, saldo correto
- [ ] Usuário de outro tenant → 403
- [ ] Feature FIN_PAGAR_MANUAL inativa → 403
- [ ] Papel Colaborador tentando baixar → 403
- [ ] Conta com status 'pago' → 422
- [ ] Conta com status 'cancelado' → 422
- [ ] valor_pago maior que valor total → 422
- [ ] valor_pago igual a valor total → deve redirecionar para BaixarTotal
```
