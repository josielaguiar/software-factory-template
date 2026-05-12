# Audit Checklist

Execute para cada endpoint ou caso de uso implementado.
Marque ✅ ⚠️ ❌ ou N/A para cada item.

---

## I1 — Isolamento de tenant

| # | Verificação | Status | Observação |
|---|---|---|---|
| 1.1 | `empresa_id` (ou equivalente) presente em toda entidade operacional | | |
| 1.2 | Toda query filtra por tenant — verificar no repositório | | |
| 1.3 | Busca por ID inclui filtro de tenant (não só WHERE id = ?) | | |
| 1.4 | Tenant vem do JWT/contexto — nunca do body da requisição | | |
| 1.5 | Listagem não retorna dados de outro tenant | | |
| 1.6 | Recurso de outro tenant retorna 404, não 403 | | |

**Como verificar:**
```
1. Abra o repositório/service do módulo
2. Procure por findOne, find, findAll, findAndCount
3. Verifique se empresa_id (ou tenant_id) está em TODOS os wheres
4. Teste: autentique como empresa A, tente acessar ID de empresa B
```

---

## I2 — Feature flags

| # | Verificação | Status | Observação |
|---|---|---|---|
| 2.1 | Feature flag verificada no caso de uso antes da lógica | | |
| 2.2 | Feature inativa retorna 403, não 404 ou 500 | | |
| 2.3 | Verificação usa o código de feature correto | | |
| 2.4 | Feature não é verificada apenas na UI (deve ser no backend) | | |

**Como verificar:**
```
1. Abra o service/use-case
2. Procure pela chamada de verificação de feature
3. Deve ser a PRIMEIRA coisa executada, antes de qualquer lógica
4. Teste: desative a feature no banco, chame o endpoint
```

---

## I3 — RBAC

| # | Verificação | Status | Observação |
|---|---|---|---|
| 3.1 | Papel mínimo necessário verificado no caso de uso | | |
| 3.2 | Verificação usa o vínculo usuário-tenant, não apenas JWT | | |
| 3.3 | Papel insuficiente retorna 403 | | |
| 3.4 | Administrador da plataforma não tem acesso automático a dados operacionais | | |

**Como verificar:**
```
1. Abra o service/use-case
2. Procure pela verificação de papel/permissão
3. Deve acontecer ANTES da lógica de negócio
4. Teste: autentique com papel insuficiente, chame o endpoint
```

---

## I4 — Transições de estado

| # | Verificação | Status | Observação |
|---|---|---|---|
| 4.1 | Status muda por caso de uso nomeado, não por PATCH livre | | |
| 4.2 | Pré-condições de estado validadas antes da mudança | | |
| 4.3 | Estado inválido retorna 422 com mensagem descritiva | | |
| 4.4 | Operação em estado incompatível é rejeitada | | |

**Como verificar:**
```
1. Verifique se existe endpoint PATCH /recurso/:id que aceita status
   → Se existe, é violação da I4
2. Verifique se existem endpoints POST /recurso/:id/[acao]
3. Teste: tente executar ação em estado inválido (ex: pagar conta cancelada)
```

---

## I5 — Auditoria

| # | Verificação | Status | Observação |
|---|---|---|---|
| 5.1 | Ação crítica registra auditoria | | |
| 5.2 | Auditoria registrada DENTRO da transação do banco | | |
| 5.3 | Registro inclui: ação, entidade, id, antes, depois, usuário | | |
| 5.4 | Falha na auditoria impede a operação | | |
| 5.5 | Dados sensíveis não estão em antes/depois | | |

**Ações que sempre exigem auditoria:**
- Criação/alteração de entidade financeira
- Baixa, cancelamento, estorno
- Alteração de permissão ou vínculo
- Download de documento sensível
- Importação de dados externos

---

## I6 — Correlation ID e eventos

| # | Verificação | Status | Observação |
|---|---|---|---|
| 6.1 | Middleware injeta correlation_id em toda requisição | | |
| 6.2 | Logs da requisição incluem correlation_id | | |
| 6.3 | Evento operacional emitido APÓS o commit | | |
| 6.4 | Evento inclui correlation_id | | |
| 6.5 | Falha no evento NÃO reverte a operação principal | | |

---

## I7 — Dados sensíveis

| # | Verificação | Status | Observação |
|---|---|---|---|
| 7.1 | Senha nunca retorna em nenhuma resposta | | |
| 7.2 | Token nunca aparece em log | | |
| 7.3 | Dados sensíveis excluídos explicitamente das respostas | | |
| 7.4 | Stack trace não exposto em produção | | |

---

## I8 — Tenant do contexto

| # | Verificação | Status | Observação |
|---|---|---|---|
| 8.1 | empresa_id nunca aceito do body em operações de escrita | | |
| 8.2 | empresa_id sempre extraído do contexto autenticado | | |
| 8.3 | Parâmetro de tenant em query string verificado contra o tenant autenticado | | |

---

## I9 — Completude de CRUD e telas de gestão

Execute uma vez por módulo ou entidade relevante implementada.

| # | Verificação | Status | Observação |
|---|---|---|---|
| 9.1 | Entidade tem Create implementado → Edit também existe ou há decisão explícita de excluir? | | |
| 9.2 | Entidade tem Create implementado → Delete/Archive também existe ou há decisão explícita de excluir? | | |
| 9.3 | Toda ausência de Edit ou Delete está documentada com justificativa (não é omissão silenciosa)? | | |
| 9.4 | Produto SaaS multi-tenant → existe tela de gestão de membros (listar, criar, editar papel, desativar)? | | |
| 9.5 | Produto SaaS com admin de plataforma → existe tela para gerenciar contas e usuários da plataforma? | | |
| 9.6 | Telas de listagem têm mecanismo de busca ou filtro quando o volume justifica? | | |

**Como verificar:**
```
1. Liste todas as entidades do módulo auditado
2. Para cada uma: verifique se Create, Edit e Delete têm endpoint + tela correspondente
3. Se algum estiver ausente, consulte o FRD ou docs/Decisoes.md
   → Se não houver decisão registrada, é uma lacuna — registre como pendência
4. Para SaaS: verifique se existe rota /admin/usuarios ou /settings/members com CRUD completo
```

**Exemplos de justificativa válida para ausência:**
- "Entidade imutável após criação (ex: registro de auditoria)" → Delete: N/A
- "Edição via novo registro com versão (ex: contrato)" → Edit: substituído por Create nova versão
- "Fora do MVP — registrado no backlog da Fase 2" → Edit/Delete: adiado com decisão explícita
