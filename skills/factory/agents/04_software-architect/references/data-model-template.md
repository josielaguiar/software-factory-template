# 05 - Modelo de Dados

Produzido por: Software Architect Agent

---

## Entidades

Lista de todas as entidades do sistema:

- [Entidade 1]
- [Entidade 2]
- [Entidade N]

---

## Detalhamento por entidade

### [NomeEntidade]

**Campos:**
```
id              uuid, PK
[campo]         tipo, [nullable/not null], [descrição]
[campo]         tipo, [nullable/not null], [descrição]
created_at      timestamp, not null
updated_at      timestamp, not null
created_by      uuid, FK → Usuario (se aplicável)
updated_by      uuid, FK → Usuario (se aplicável)
```

**Relações:**
- Pertence a: [Entidade] via [campo_id]
- Tem muitos: [Entidade] via [campo_id]
- Muitos para muitos: [Entidade] via [tabela_pivot]

**Índices:**
```
idx_[entidade]_[campo]        ([campo]) — [motivo]
idx_[entidade]_[campo1_campo2] ([campo1, campo2]) — [motivo]
```

**Restrições de unicidade:**
- único por ([campo1, campo2]) — [motivo]

**Regras de negócio no modelo:**
- [regra que se traduz em constraint ou validação]

**Observações:**
- [nota importante sobre esta entidade]

---

### [Próxima entidade]
[idem]

---

## Diagrama de relações (texto)

```
[Entidade A] --1:N--> [Entidade B]
[Entidade B] --N:M--> [Entidade C] (via [pivot])
[Entidade A] --1:1--> [Entidade D]
```

---

## Dados sensíveis

| Entidade | Campo | Tipo de sensibilidade | Como proteger |
|---|---|---|---|
| [entidade] | [campo] | [pessoal/financeiro/credencial] | [criptografia/hash/mascaramento] |

---

## Migrations

Ordem de criação das migrations:
1. [tabela sem dependências]
2. [tabela com FK para a anterior]
3. [...]

**Observação:** Toda migration deve ter `up` e `down` implementados.

---

## Índices de performance

Campos que com certeza precisam de índice:
- `(empresa_id)` — em toda entidade com isolamento por tenant
- `(empresa_id, status)` — listagens filtradas por status
- `(empresa_id, created_at)` — ordenação cronológica
- `(empresa_id, vencimento)` — se houver datas de vencimento
