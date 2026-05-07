# Conventions Audit

Verifica se o código segue as convenções definidas em
docs/08_Convencoes_do_Projeto.md.

---

## Nomenclatura

| # | Verificação | Status |
|---|---|---|
| 1 | Arquivos backend em kebab-case | |
| 2 | Classes em PascalCase | |
| 3 | Métodos e variáveis em camelCase | |
| 4 | Constantes de evento em SCREAMING_SNAKE_CASE | |
| 5 | Tabelas do banco em snake_case plural | |
| 6 | Colunas do banco em snake_case | |
| 7 | Endpoints em kebab-case plural | |
| 8 | Componentes React em PascalCase | |

---

## Estrutura de pastas

| # | Verificação | Status |
|---|---|---|
| 1 | Módulo tem: controller, service, repository, dto/, entities/ | |
| 2 | DTOs nomeados create-[entidade].dto.ts e update-[entidade].dto.ts | |
| 3 | Testes no mesmo nível do que testam ([modulo].spec.ts) | |
| 4 | Shared: guards, decorators, filters, interceptors | |

---

## Endpoints REST

| # | Verificação | Status |
|---|---|---|
| 1 | GET /recurso → listar | |
| 2 | POST /recurso → criar | |
| 3 | GET /recurso/:id → detalhar | |
| 4 | PUT /recurso/:id → atualizar | |
| 5 | Ações de negócio: POST /recurso/:id/[acao] | |
| 6 | Nenhum PATCH /recurso/:id com campo status | |

---

## Padrão de resposta

| # | Verificação | Status |
|---|---|---|
| 1 | Sucesso retorna `{ data: ... }` | |
| 2 | Listagem retorna `{ data: [...], meta: { page, total } }` | |
| 3 | Erro retorna `{ statusCode, error, message }` | |
| 4 | Erro de campo retorna com campo `field` identificado | |
| 5 | Nenhum stack trace em resposta de erro | |

---

## Regras de implementação

| # | Verificação | Status |
|---|---|---|
| 1 | Feature flag no caso de uso, não no controller | |
| 2 | RBAC no caso de uso, não no controller | |
| 3 | Auditoria dentro da transação | |
| 4 | Evento após o commit, fora da transação | |
| 5 | Toda listagem tem paginação | |
| 6 | Nenhum console.log — usar logger estruturado | |
| 7 | Nenhuma exception não tratada | |

---

## Commits

| # | Verificação | Status |
|---|---|---|
| 1 | Mensagem usa tipo: feat, fix, docs, refactor, test, chore, migration | |
| 2 | Mensagem em minúsculo | |
| 3 | Mensagem é descritiva — não "update" ou "fix" genérico | |
