# Invariantes por Tipo de Produto

Regras que nunca podem ser violadas, por categoria de produto.
Para SaaS, use também saas-multitenancy-contract/SKILL.md.

---

## Invariantes universais — valem para todos os produtos

1. **Segredos nunca no código** — senhas, tokens, chaves de API sempre em variáveis de ambiente
2. **HTTPS em produção** — sem exceção
3. **Input nunca confiado** — toda entrada do usuário é validada no backend
4. **Erro sem detalhe interno** — stack trace nunca chega ao cliente em produção
5. **Log sem dado sensível** — CPF, senha, token nunca em log
6. **Paginação obrigatória** — nenhum endpoint retorna lista ilimitada
7. **Timeout em chamadas externas** — nenhuma chamada a API externa sem timeout definido

---

## Ferramenta Interna

1. Mesmo com usuário único, autenticação é obrigatória — ferramenta interna não significa acesso livre
2. Ações destrutivas (delete, reset) exigem confirmação explícita
3. Log de auditoria para ações que alteram dados importantes
4. Backup verificado — não adianta ter backup que nunca foi testado

---

## Mobile App

1. Token nunca em localStorage ou AsyncStorage sem criptografia
2. Dados sensíveis no Keychain (iOS) ou Keystore (Android)
3. Certificate pinning para APIs críticas
4. Sem lógica de negócio crítica só no mobile — servidor é a fonte da verdade
5. Versioning de API — mobile antigo deve continuar funcionando

---

## E-commerce

1. Preço sempre calculado no backend — nunca confiar no preço enviado pelo frontend
2. Estoque verificado no momento da confirmação do pedido, não do carrinho
3. Pagamento processado via gateway — nunca dados de cartão no seu servidor (PCI DSS)
4. Pedido confirmado só após confirmação do pagamento — nunca antes
5. Webhook de pagamento verificado por assinatura — nunca aceitar sem validar

---

## Automação / Script

1. Idempotência — executar duas vezes produz o mesmo resultado que executar uma
2. Toda execução gera log com: início, fim, quantidade processada, erros
3. Falha notifica responsável — nunca falha silenciosa
4. Dados de entrada validados antes de processar
5. Rollback definido — o que acontece se falhar no meio do processo?
