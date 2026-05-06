# Padrões de Auditoria SaaS

---

## O que auditar

### Ações sempre auditadas
- Criação de qualquer entidade financeira
- Alteração de qualquer entidade financeira
- Toda transição de status de entidade crítica
- Download de documento sensível
- Alteração de permissão ou papel de usuário
- Alteração de vínculo entre entidades (ex: cliente-contabilidade)
- Cancelamento de qualquer operação
- Importação de dados externos (extratos, XMLs)
- Confirmação ou desfazimento de conciliação
- Alteração de configuração crítica

### Ações que não precisam de auditoria
- Leituras simples (GET sem efeito colateral)
- Operações de listagem e filtro
- Login bem-sucedido (vai para log de acesso, não auditoria)

---

## Estrutura do registro de auditoria

```typescript
interface AuditRecord {
  id: string              // UUID
  tenant_id: string       // Tenant da operação (pode ser null para operações de plataforma)
  usuario_id: string      // Usuário que executou
  acao: string            // Ex: 'FIN_CONTA_MARCADA_PAGA', 'PERM_PAPEL_ALTERADO'
  entidade: string        // Nome da entidade: 'ContaFinanceira', 'MembroEmpresa'
  entidade_id: string     // ID do registro afetado
  antes: object | null    // Estado antes da operação (null para criações)
  depois: object | null   // Estado após a operação (null para exclusões)
  ip: string              // IP da requisição
  user_agent: string      // User-agent do cliente
  correlation_id: string  // ID da operação completa
  created_at: Date
}
```

---

## Quando registrar

**Dentro da transação do banco**, antes do commit:

```typescript
// CERTO — auditoria e operação são atômicas
await dataSource.transaction(async (manager) => {
  const antes = await manager.findOne(ContaFinanceira, { where: { id } })
  
  // Executar a operação
  await manager.save(ContaFinanceira, { ...antes, status: 'pago' })
  
  // Registrar auditoria na mesma transação
  await manager.save(Auditoria, {
    tenant_id: tenantId,
    usuario_id: userId,
    acao: 'FIN_CONTA_MARCADA_PAGA',
    entidade: 'ContaFinanceira',
    entidade_id: id,
    antes: { status: antes.status },
    depois: { status: 'pago', data_pagamento: new Date() },
    correlation_id: correlationId,
  })
})

// ERRADO — auditoria fora da transação
await contaRepo.save(conta)
await auditoriaRepo.save(auditoria) // se isso falhar, operação fica sem rastro
```

---

## O que incluir em `antes` e `depois`

Não copie o objeto inteiro — registre apenas os campos que mudaram, mais o estado de status:

```typescript
// Para uma baixa parcial
antes: {
  status: 'aberto',
  valor_pago: null,
  data_pagamento: null,
}
depois: {
  status: 'parcial',
  valor_pago: 600.00,
  data_pagamento: '2026-04-24',
  forma_pagamento: 'pix',
  conta_bancaria_id: 'uuid-da-conta',
}
```

---

## Eventos operacionais vs. Auditoria

São dois registros distintos com propósitos diferentes:

| | Auditoria | Evento Operacional |
|---|---|---|
| **Propósito** | Rastreabilidade legal e de negócio | Observabilidade técnica e operacional |
| **Quando** | Dentro da transação | Após o commit |
| **Quem consome** | Contador, gestor, compliance | Sistema de monitoramento, agentes futuros |
| **Falha** | Impede a operação | Não impede a operação |
| **Contém** | Estado antes/depois | Payload resumido, severidade, origem |

```typescript
// Após o commit — evento operacional
await eventBus.emit({
  tipo_evento: 'FIN_CONTA_MARCADA_PAGA',
  severidade: 'info',
  origem: 'usuario',
  entidade: 'ContaFinanceira',
  entidade_id: id,
  correlation_id: correlationId,
  payload_resumo: { valor: conta.valor, empresa_id: tenantId },
})
```

---

## Proteção de dados sensíveis na auditoria

Nunca inclua em `antes`/`depois`:
- Senhas ou hashes de senha
- Tokens ou chaves de API
- Números completos de cartão
- Conteúdo de certificados digitais

Se precisar registrar que uma credencial foi alterada, registre apenas `{ credencial_alterada: true }`.
