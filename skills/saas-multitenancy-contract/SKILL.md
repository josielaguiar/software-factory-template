---
name: saas-multitenancy-contract
description: Contrato de invariantes para sistemas SaaS multiempresa (multitenant). Use esta skill SEMPRE que for criar, revisar ou auditar qualquer endpoint, caso de uso, entidade, migration ou módulo em um projeto SaaS multiempresa. Deve ser carregada antes de qualquer implementação técnica — mesmo que o usuário não mencione explicitamente "SaaS" ou "multitenancy". Se o projeto tem empresas, organizações, workspaces ou tenants como unidade de isolamento, esta skill se aplica.
---

# SaaS Multitenancy Contract

Este documento define as invariantes que todo sistema SaaS multiempresa deve respeitar. São regras de estrutura — não de negócio — e se aplicam independentemente do domínio, linguagem ou framework.

**Como usar esta skill:**
- Leia este documento antes de criar qualquer endpoint, caso de uso ou entidade
- Use `references/checklist.md` para verificar cada entrega antes de considerá-la concluída
- Use `references/audit-patterns.md` para implementar auditoria corretamente
- Use `references/feature-flags.md` para implementar feature flags corretamente

---

## Invariantes do sistema

Estas regras nunca podem ser violadas. Em qualquer módulo, em qualquer fase.

### I1 — Isolamento de tenant

Todo recurso pertence a um tenant. Toda operação sobre um recurso verifica se o usuário pertence ao mesmo tenant.

```
// Toda consulta operacional inclui o filtro de tenant
repository.find({ where: { tenant_id: currentTenant.id } })

// Nunca buscar por ID sem verificar tenant
// ERRADO: repository.findOne({ where: { id } })
// CERTO:  repository.findOne({ where: { id, tenant_id } })
```

**Consequências:**
- Não existe endpoint que retorne recursos de múltiplos tenants sem ser uma rota administrativa explícita
- Parâmetros de tenant nunca vêm do body da requisição — vêm do contexto de autenticação
- Filtro de tenant aplicado no repositório, não na camada de apresentação

### I2 — Feature flags verificadas na camada de aplicação

Toda funcionalidade vendável verifica se está ativa para o tenant antes de executar.

```
// No caso de uso, antes de qualquer lógica
await this.featureService.assertActive(tenantId, 'FEATURE_CODE')
// Lança ForbiddenException se feature não está ativa
```

**Consequências:**
- Não existe `if (plan === 'premium')` no código — existe consulta à tabela de features
- Feature desativada retorna 403, não 404
- Novas features nascem desativadas por padrão

### I3 — RBAC verificado antes da lógica de negócio

Toda operação verifica papel do usuário no contexto do tenant antes de executar qualquer lógica.

```
// Guard ou verificação explícita no caso de uso
await this.authService.assertRole(userId, tenantId, ['ROLE_A', 'ROLE_B'])
```

**Consequências:**
- Papel nunca é assumido a partir do token JWT isoladamente — é sempre verificado contra o vínculo usuário-tenant
- Um usuário pode ter papéis diferentes em tenants diferentes
- Administrador da plataforma não é administrador de todos os tenants automaticamente

### I4 — Transições de estado por casos de uso nomeados

Status de entidades críticas nunca muda por PATCH livre. Cada transição é um caso de uso com nome, validação e auditoria.

```
// ERRADO
PATCH /contas/:id  { status: 'pago' }

// CERTO
POST /contas/:id/pagar    → caso de uso MarcarComoPago
POST /contas/:id/cancelar → caso de uso CancelarConta
POST /contas/:id/estornar → caso de uso EstornarBaixa
```

**Consequências:**
- Cada caso de uso valida pré-condições (ex: não pode pagar uma conta já cancelada)
- Cada caso de uso registra auditoria antes do commit
- Cada caso de uso emite evento operacional após o commit

### I5 — Auditoria antes do commit, evento após

Toda ação crítica registra auditoria dentro da mesma transação do banco. Eventos operacionais são emitidos após o commit.

```
// Dentro da transação
await auditLogger.record({ action, before, after, userId, tenantId })
await repository.save(entity)
// Após commit
await eventBus.emit('ENTITY_ACTION', payload)
```

**Consequências:**
- Se a transação falhar, não há registro de auditoria fantasma
- Se o evento falhar, a operação já foi persistida — o evento pode ser reenviado
- Auditoria nunca é opcional em ações definidas como críticas

### I6 — Correlation ID em toda operação

Toda operação que gera efeitos colaterais (escrita, evento, notificação) carrega um correlation_id único, gerado na entrada da requisição.

```
// Middleware gera correlation_id se não vier no header
const correlationId = req.headers['x-correlation-id'] ?? uuid()
```

**Consequências:**
- Logs, auditoria e eventos do mesmo request compartilham o mesmo correlation_id
- Permite rastrear uma operação completa através de múltiplos serviços ou workers

### I7 — Dados sensíveis nunca em texto puro

Senhas, tokens, chaves de API, certificados e segredos nunca são armazenados em texto puro nem logados.

**Consequências:**
- Campos sensíveis são excluídos explicitamente dos logs e respostas de API
- Migrations nunca inserem dados sensíveis em texto puro

### I8 — Tenant nunca inferido do body

O tenant da operação vem sempre do contexto de autenticação (token decodificado, sessão, claim JWT), nunca de um campo `tenant_id` no body da requisição.

```
// ERRADO
createAccount({ tenantId: body.tenantId, ... })

// CERTO
createAccount({ tenantId: currentUser.tenantId, ... })
```

---

## Padrões obrigatórios por camada

### Camada de apresentação (controllers/routes)
- Extrair tenant do contexto de autenticação
- Não conter lógica de negócio
- Não conter lógica de permissão além do guard de autenticação

### Camada de aplicação (use cases/services)
- Verificar feature flag
- Verificar papel do usuário no tenant
- Orquestrar domínio, repositório, auditoria e evento
- Nunca acessar banco diretamente — usar repositório

### Camada de domínio (entities/domain services)
- Não conhecer tenant, usuário ou banco
- Conter apenas regras de negócio puras
- Validar invariantes do domínio

### Camada de infraestrutura (repositories/ORM)
- Sempre incluir filtro de tenant em consultas
- Nunca retornar dados de múltiplos tenants em uma única query sem intenção explícita

---

## Referências

- `references/checklist.md` — Checklist de entrega por caso de uso
- `references/audit-patterns.md` — Como implementar auditoria corretamente
- `references/feature-flags.md` — Como implementar feature flags corretamente
