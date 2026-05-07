# 08 - Convenções do Projeto

Produzido por: Tech Lead Agent
Leia antes de escrever qualquer código.

---

## Commits

Padrão: `tipo: descrição curta em minúsculo`

| Tipo | Quando usar |
|---|---|
| `feat` | Nova funcionalidade |
| `fix` | Correção de bug |
| `docs` | Documentação |
| `refactor` | Refatoração sem mudança de comportamento |
| `test` | Testes |
| `chore` | Tarefas auxiliares (config, deps, CI) |
| `migration` | Nova migration de banco |

Exemplos:
```
feat: criar endpoint de baixa parcial de conta financeira
fix: corrigir filtro de empresa_id em listagem de categorias
migration: adicionar campo conta_bancaria_id em conta_financeira
```

---

## Estrutura de pastas

### Backend (NestJS)
```
src/
  modules/
    [modulo]/
      [modulo].module.ts
      [modulo].controller.ts
      [modulo].service.ts         ← caso de uso / aplicação
      [modulo].repository.ts      ← acesso ao banco
      dto/
        create-[entidade].dto.ts
        update-[entidade].dto.ts
      entities/
        [entidade].entity.ts
      [modulo].spec.ts
  shared/
    guards/                       ← auth, empresa, feature
    decorators/
    filters/                      ← tratamento de erros
    interceptors/                 ← logging, correlation-id
```

### Frontend (React + Vite)
```
src/
  pages/
    [modulo]/
      [Tela]Page.tsx
  components/
    [modulo]/
      [Componente].tsx
    ui/                           ← componentes genéricos
  hooks/
    use[Recurso].ts
  services/
    [modulo].service.ts           ← chamadas à API
  store/                          ← estado global (se necessário)
  types/
    [modulo].types.ts
```

---

## Nomenclatura

### Backend
- **Arquivos:** kebab-case (`conta-financeira.service.ts`)
- **Classes:** PascalCase (`ContaFinanceiraService`)
- **Métodos:** camelCase (`marcarComoPaga`)
- **Variáveis:** camelCase (`valorPago`)
- **Constantes:** SCREAMING_SNAKE_CASE (`FIN_CONTA_CRIADA`)
- **Tabelas banco:** snake_case plural (`contas_financeiras`)
- **Colunas banco:** snake_case (`valor_pago`, `empresa_id`)
- **Endpoints REST:** kebab-case plural (`/contas-financeiras/:id/pagar`)

### Frontend
- **Arquivos de componente:** PascalCase (`ContaFinanceiraForm.tsx`)
- **Arquivos de hook:** camelCase com prefixo use (`useContasFinanceiras.ts`)
- **Arquivos de serviço:** camelCase (`contaFinanceira.service.ts`)

---

## Endpoints REST

Padrão:
```
GET    /[recurso]              → listar
POST   /[recurso]              → criar
GET    /[recurso]/:id          → detalhar
PUT    /[recurso]/:id          → atualizar completo
PATCH  /[recurso]/:id          → atualizar parcial
DELETE /[recurso]/:id          → remover (se permitido)

Ações de negócio (não CRUD):
POST   /[recurso]/:id/[acao]   → ex: /contas/:id/pagar
```

Recursos sempre em kebab-case plural:
```
/contas-financeiras
/categorias-financeiras
/pessoas-relacionadas
/contas-bancarias
```

---

## Respostas da API

### Sucesso
```json
{
  "data": { ... },
  "meta": { "page": 1, "total": 100 }  // apenas em listagens
}
```

### Erro
```json
{
  "statusCode": 422,
  "error": "Unprocessable Entity",
  "message": "Conta não pode ser baixada no estado atual",
  "field": "status"  // opcional, para erros de validação de campo
}
```

---

## Variáveis de ambiente

- Nunca commitadas no repositório
- Arquivo `.env.example` sempre atualizado com as variáveis necessárias (sem valores reais)
- Prefixo por contexto:
  - `DB_` → banco de dados
  - `JWT_` → autenticação
  - `STORAGE_` → arquivos
  - `[SERVICO]_` → integrações externas

---

## Regras de implementação

1. Todo endpoint verifica autenticação via Guard
2. Todo endpoint operacional verifica empresa via Guard
3. Feature flag verificada no caso de uso, nunca no controller
4. RBAC verificado no caso de uso, nunca no controller
5. Auditoria registrada dentro da transação
6. Evento emitido após o commit, nunca dentro da transação
7. `empresa_id` nunca vem do body — sempre do contexto autenticado
8. Toda listagem tem paginação — nunca retornar tudo sem limite
9. Nenhuma exception sem tratamento — todo erro tem handler
10. Nenhum `console.log` em produção — usar logger estruturado
