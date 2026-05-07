# Checklist Pré-Deploy

Execute SEMPRE antes de qualquer deploy em produção.
Nunca pule itens — cada um existe por uma razão.

---

## Pré-deploy em staging

- [ ] Todos os testes automatizados passando
- [ ] Migrations testadas em banco de staging
- [ ] Variáveis de ambiente de staging configuradas
- [ ] Nenhum `console.log` de debug no código
- [ ] Nenhuma credencial hardcoded no código
- [ ] `.env` não está no repositório (verificar `.gitignore`)

---

## Pré-deploy em produção

### Código
- [ ] Deploy passou em staging sem erros
- [ ] Owner verificou em staging e aprovou
- [ ] Nenhuma mudança de última hora sem staging

### Banco de dados
- [ ] Migrations testadas em staging antes
- [ ] Backup do banco de produção feito agora (antes do deploy)
- [ ] Plano de rollback de migration definido
- [ ] Migration é reversível (down implementado)?

### Infraestrutura
- [ ] Variáveis de ambiente de produção atualizadas se necessário
- [ ] Serviços externos (APIs, email) funcionando
- [ ] Limites de free tier verificados — tem espaço para crescer?
- [ ] SSL/HTTPS válido e não vencendo nos próximos 30 dias

### Monitoramento
- [ ] Alertas de uptime configurados
- [ ] Logs acessíveis para verificar após deploy
- [ ] Canal de alerta (email/WhatsApp) funcionando

---

## Pós-deploy imediato (primeiros 15 minutos)

- [ ] Health check responde 200
- [ ] Login funciona
- [ ] Fluxo crítico principal funciona
- [ ] Nenhum erro 500 nos logs
- [ ] Banco conectado e respondendo

---

## Se algo der errado

### Sintomas e ações

**Sistema não sobe após deploy:**
1. Verifique logs do serviço de deploy
2. Verifique se variáveis de ambiente estão corretas
3. Se migration falhou → reverter migration antes de reverter código
4. Rollback para versão anterior

**Migration falhou em produção:**
1. NÃO fazer deploy do código novo ainda
2. Verificar se migration tem `down` implementado
3. Executar `down` para reverter
4. Corrigir migration e testar em staging novamente

**Erros 500 em produção:**
1. Verificar logs imediatamente
2. Identificar se é erro de código ou de infraestrutura
3. Se crítico → rollback imediato
4. Se localizado → hotfix com staging rápido

---

## Comunicação durante deploy

Se houver usuários usando o sistema:
- [ ] Comunicar horário de manutenção com antecedência
- [ ] Deploy em horário de baixo uso (noite/madrugada)
- [ ] Ter alguém disponível por 30 minutos após o deploy

---

## Registro de deploy

Após cada deploy em produção, registre em `docs/Changelog.md`:

```
## Deploy — [data e hora]
- Versão: [tag ou commit]
- O que mudou: [resumo]
- Migrations: [sim/não — quais]
- Problemas: [nenhum / descrever]
- Responsável: [quem fez]
```
