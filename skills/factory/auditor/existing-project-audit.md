# Auditoria de Projeto Existente

Use quando o projeto não passou pelo processo da fábrica
ou quando quer avaliar o estado atual antes de continuar.

Mais amplo que a auditoria padrão — avalia também estrutura e riscos.

---

## Fase 1 — Inventário

Antes de auditar, mapeie o que existe:

```
[ ] Liste todos os endpoints disponíveis
[ ] Liste todas as entidades no banco
[ ] Liste os arquivos de código principais
[ ] Identifique se tem testes (quantos e de que tipo)
[ ] Identifique se tem migrations versionadas
[ ] Identifique se tem .env.example ou documentação de variáveis
```

---

## Fase 2 — Avaliação de segurança crítica

### Isolamento de dados
- [ ] Existe conceito de tenant/empresa/organização?
- [ ] Dados são isolados por tenant em todas as queries?
- [ ] Existe risco de um usuário ver dados de outro?
- [ ] Autenticação implementada em todos os endpoints que precisam?

### Senhas e segredos
- [ ] Senhas armazenadas com hash (bcrypt, argon2)?
- [ ] Segredos e API keys em variáveis de ambiente?
- [ ] .env está no .gitignore?
- [ ] Existe .env.example documentado?

### Exposição de dados
- [ ] Respostas de API expõem campos sensíveis desnecessariamente?
- [ ] Erros expõem stack trace ou detalhes internos?
- [ ] Logs contêm dados sensíveis?

---

## Fase 3 — Avaliação de arquitetura

### Separação de responsabilidades
- [ ] Lógica de negócio está no lugar certo (não na UI, não no banco)?
- [ ] Acesso ao banco centralizado ou espalhado em vários lugares?
- [ ] Integrações externas isoladas ou acopladas ao domínio?

### Modelo de dados
- [ ] Migrações versionadas existem?
- [ ] Índices nas colunas mais consultadas?
- [ ] Dados sensíveis protegidos adequadamente?

### Qualidade de código
- [ ] Existe padrão de nomenclatura consistente?
- [ ] Tratamento de erros implementado?
- [ ] Logs estruturados ou apenas console.log?

---

## Fase 4 — Avaliação de testes

- [ ] Existem testes automatizados?
- [ ] Que percentual do código crítico tem teste?
- [ ] Testes cobrem isolamento de tenant?
- [ ] Testes cobrem autenticação e autorização?
- [ ] CI/CD roda testes automaticamente?

---

## Fase 5 — Avaliação de operação

- [ ] Como é feito o deploy? Manual ou automatizado?
- [ ] Existe ambiente de staging separado de produção?
- [ ] Existe monitoramento de uptime?
- [ ] Existe forma de ver erros em produção?
- [ ] Backup configurado e testado?
- [ ] Como é feito rollback se algo der errado?

---

## Relatório de projeto existente

Após completar as fases, produza:

### Riscos críticos (corrigir imediatamente)
[Liste o que pode causar perda de dados, exposição de dados ou indisponibilidade]

### Débito técnico significativo (planejar correção)
[Liste o que está incorreto mas não é emergência imediata]

### O que está bem (não mexer sem motivo)
[Liste o que já está implementado corretamente]

### Recomendação de próximos passos
[Ordem de prioridade para corrigir os problemas encontrados]

### Estimativa de esforço
| Item | Complexidade | Urgência |
|---|---|---|
| [item] | P/M/G | 🔴/🟡/🟢 |
