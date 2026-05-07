# Checklist de Testes de Segurança

Execute em todo endpoint antes de considerar implementado.
Este checklist é obrigatório — não opcional.

---

## Autenticação

- [ ] Requisição sem header Authorization → 401
- [ ] Token com formato inválido → 401
- [ ] Token com assinatura inválida → 401
- [ ] Token expirado → 401
- [ ] Token de ambiente diferente (staging token em prod) → 401

---

## Autorização

- [ ] Usuário autenticado sem papel adequado → 403
- [ ] Feature inativa para o tenant → 403
- [ ] Papel correto mas empresa errada → 403 ou 404

---

## Isolamento de tenant (multitenancy)

- [ ] GET /recurso/:id — id pertence a outro tenant → 404 (não 403, não revelar existência)
- [ ] PUT /recurso/:id — id pertence a outro tenant → 404
- [ ] DELETE /recurso/:id — id pertence a outro tenant → 404
- [ ] GET /recurso — listagem não inclui dados de outro tenant
- [ ] POST /recurso — body com empresa_id diferente → ignorado (usa tenant do JWT)
- [ ] Filtros não permitem bypassar isolamento

---

## Validação de entrada

- [ ] Campo obrigatório ausente → 422 com nome do campo
- [ ] Tipo errado (string onde espera número) → 422
- [ ] Número negativo onde só aceita positivo → 422
- [ ] String além do limite de caracteres → 422
- [ ] Email inválido → 422
- [ ] UUID inválido em parâmetro de rota → 422 ou 404
- [ ] Payload JSON malformado → 400
- [ ] Payload vazio onde é obrigatório → 422

---

## Injeção e manipulação

- [ ] SQL injection em campo de texto → ORM trata, não deve vazar dados
- [ ] Script em campo de texto → deve ser salvo como texto, não executado
- [ ] Path traversal em campos de arquivo → rejeitado
- [ ] Referência circular em JSON → rejeitada ou limitada

---

## Operações destrutivas

- [ ] Cancelar/excluir recurso de outro tenant → 404
- [ ] Cancelar recurso já cancelado → 422 com mensagem clara
- [ ] Reabrir recurso que não pode ser reaberto → 422

---

## Rate limiting (se implementado)

- [ ] Exceder limite de requisições → 429 com Retry-After
- [ ] Endpoint de login tem limite mais restritivo

---

## Dados sensíveis

- [ ] Senha nunca retorna em nenhuma resposta
- [ ] Token nunca aparece em log
- [ ] CPF/dados pessoais mascarados em log
- [ ] Resposta de erro não expõe stack trace em produção

---

## Como usar este checklist

Para cada endpoint implementado pelo Codex, rode os testes
relevantes desta lista e marque o que passou.

Se algum item falhar, registre como bug antes de avançar:

```
Bug: [endpoint] — [item do checklist que falhou]
Comportamento atual: [o que acontece]
Comportamento esperado: [o que deveria acontecer]
Prioridade: 🔴 Crítico (segurança) / 🟡 Importante / 🟢 Menor
```
