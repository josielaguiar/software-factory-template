# Perguntas de Entrevista — SaaS (B2B e B2C)

Use em rodadas de no máximo 4 perguntas cada.
Pule perguntas já respondidas pelo contexto existente.

---

## Rodada 1 — O problema e o usuário

1. Qual é o problema principal que o produto resolve? Descreva em uma frase do ponto de vista do usuário.
2. Quem é o usuário que vai usar o sistema no dia a dia? (não o comprador — o usuário real)
3. Hoje como esse problema é resolvido? Planilha, sistema antigo, processo manual?
4. O que faz o usuário abandonar a solução atual e buscar outra?

## Rodada 2 — Escopo e módulos

1. Quais são as 3 funcionalidades que o produto PRECISA ter para ser útil desde o primeiro dia?
2. Existe alguma funcionalidade que parece óbvia mas você quer deixar para depois? Qual e por quê?
3. O produto vai substituir algum sistema existente ou vai conviver com ele?
4. Tem alguma funcionalidade que você definitivamente NÃO quer no produto, pelo menos por agora?

## Rodada 3 — Usuários e acessos

1. Quantos tipos de usuário o sistema vai ter? (ex: admin, operador, cliente, contador)
2. O que cada tipo de usuário pode fazer que os outros não podem?
3. Uma empresa (tenant) vai ter múltiplos usuários ou é um usuário por conta?
4. Vai ter algum usuário externo que acessa dados de outros? (ex: contador que vê dados do cliente)

## Rodada 4 — Regras de negócio críticas

1. Existe alguma regra que nunca pode ser violada no sistema? (ex: "conta paga não pode ser editada")
2. O que acontece quando um usuário tenta fazer algo que não tem permissão?
3. Tem algum cálculo ou processamento que o sistema precisa fazer automaticamente?
4. Existe alguma integração com sistema externo que é obrigatória desde o início?

## Rodada 5 — Dados e histórico

1. Que tipo de relatório ou visão consolidada o usuário vai precisar?
2. Os dados precisam ser exportados? Em qual formato?
3. Existe necessidade de histórico ou auditoria de ações?
4. Dados antigos de outro sistema precisam ser migrados?

## Rodada 6 — Crescimento e limites

1. Quantos usuários você espera nos primeiros 6 meses? E em 2 anos?
2. O produto vai ser vendido com planos diferentes? O que muda entre eles?
3. Existe alguma funcionalidade que hoje é manual mas no futuro precisa ser automática?
4. Tem alguma restrição legal ou regulatória específica do seu setor que o sistema precisa respeitar?

## Rodada 7 — Contexto brasileiro (se aplicável)

1. O produto precisa emitir ou processar documentos fiscais? (NF-e, NFS-e, CT-e)
2. Precisa se integrar com sistemas do governo? (SPED, eSocial, SEFAZ)
3. Vai processar pagamentos? Qual meio? (PIX, boleto, cartão)
4. Precisa seguir alguma regulamentação específica? (LGPD, CFM, CFC, BACEN)
