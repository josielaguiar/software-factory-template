# Padrões de Arquitetura por Tipo de Produto

---

## SaaS B2B — Arquitetura em camadas

```
UI (React/Vite)
  ↓ HTTP/REST
Application Layer (NestJS Controllers + Services)
  ↓ Casos de uso, permissões, features, auditoria
Domain Layer (Entities + Business Rules)
  ↓ Regras puras, sem dependência externa
Infrastructure Layer (TypeORM + PostgreSQL + Storage)
  ↓ Banco, arquivos, email, filas
Integration Layer (APIs externas isoladas)
  ↓ Fiscal, bancário, notificações
```

**Regras obrigatórias:**
- UI não contém lógica de negócio
- Application verifica permissão antes de qualquer operação
- Domain não conhece banco, HTTP ou UI
- Integrações externas isoladas — domínio não depende de fornecedor específico
- Toda escrita em entidade crítica passa por caso de uso nomeado

**Multitenancy:**
- `empresa_id` em toda entidade operacional
- Filtro de tenant em toda query — nunca opcional
- Tenant vem do JWT, nunca do body

---

## Ferramenta Interna — Arquitetura simplificada

```
UI (React/Vite ou similar)
  ↓
API Layer (NestJS ou Express)
  ↓ Validação, autenticação, lógica de negócio
Database (PostgreSQL)
```

**Regras:**
- Autenticação simples — JWT ou SSO existente
- Sem multitenancy elaborado se for uso de um time
- Logs e auditoria para ações críticas
- Deploy simples — Docker ou PaaS

---

## Mobile App — Arquitetura

```
Mobile App (React Native / Flutter)
  ↓ HTTPS
API Gateway / Backend (NestJS / FastAPI)
  ↓
Database + Storage + Push Notifications
```

**Regras:**
- API stateless — mobile gerencia estado local
- Token refresh transparente para o usuário
- Cache local para dados que raramente mudam
- Offline first para funcionalidades críticas
- Push notifications via serviço dedicado (FCM/APNs)

---

## E-commerce — Arquitetura

```
Frontend (Next.js — SSR para SEO)
  ↓
API (NestJS ou BFF)
  ↓
Banco + Storage + Gateway de Pagamento + ERP/Estoque
```

**Regras:**
- SSR obrigatório para páginas de produto (SEO)
- Gateway de pagamento nunca no frontend
- Webhook de pagamento processado no backend
- Estoque com controle de concorrência (evitar overselling)
- Filas para processamento de pedidos

---

## Automação / Script — Arquitetura

```
Trigger (cron / webhook / manual)
  ↓
Script / Worker
  ↓
Fonte de dados → Processamento → Destino
  ↓
Log + Notificação de resultado
```

**Regras:**
- Idempotência — rodar duas vezes não gera duplicidade
- Log completo de cada execução
- Alerta em caso de falha
- Retry com backoff para falhas transitórias

---

## Padrões transversais — valem para todos

### Autenticação e sessão
- JWT com expiração curta (15-60 min) + refresh token
- Refresh token rotativo — cada uso gera novo token
- Logout invalida refresh token no servidor
- Rate limiting em endpoints de auth

### Tratamento de erros
- Erros de validação: 422 com campo e mensagem específica
- Não autorizado: 401 (sem token) ou 403 (sem permissão)
- Não encontrado: 404
- Erro interno: 500 com log mas sem detalhe para o cliente
- Nunca expor stack trace em produção

### Logs e observabilidade
- Log estruturado (JSON) desde o início
- correlation_id em toda requisição
- Níveis: error, warn, info, debug
- Nunca logar dados sensíveis (senha, token, CPF completo)

### Segurança mínima
- HTTPS obrigatório em produção
- CORS configurado explicitamente
- Rate limiting em APIs públicas
- Variáveis de ambiente para segredos — nunca no código
- Dependências atualizadas — audit periódico

### Performance mínima
- Índices nos campos mais usados em queries (tenant_id, status, created_at)
- Paginação em toda listagem — nunca retornar tudo
- Timeout em chamadas externas
- Cache para dados que raramente mudam
