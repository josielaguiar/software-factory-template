# 12 - Infraestrutura e Deploy

Produzido por: DevOps Advisor Agent

---

## Ambientes

| Ambiente | Propósito | URL | Quem acessa |
|---|---|---|---|
| Local | Desenvolvimento | localhost | Desenvolvedor |
| Staging | Testes pré-deploy | [url-staging] | Owner + time |
| Produção | Usuários reais | [url-producao] | Todos |

---

## Stack de infraestrutura

| Componente | Serviço | Plano atual | Limite | Custo |
|---|---|---|---|---|
| Backend | [serviço] | [plano] | [limite] | R$[X]/mês |
| Frontend | [serviço] | [plano] | [limite] | R$[X]/mês |
| Banco | [serviço] | [plano] | [limite] | R$[X]/mês |
| Storage | [serviço] | [plano] | [limite] | R$[X]/mês |
| **Total** | | | | **R$[X]/mês** |

---

## Custo projetado por cenário

| Cenário | Custo estimado | Quando ocorre |
|---|---|---|
| MVP — só uso interno | R$0/mês | Agora |
| Primeiros 10 clientes | R$[X]/mês | [quando] |
| Escala — 100 clientes | R$[X]/mês | [quando] |

---

## Alertas de free tier

[Liste cada limitação relevante do plano gratuito e quando impacta]

---

## Setup local

### Pré-requisitos
- Node.js [versão]
- Docker (para banco local)
- [outros]

### Passos
```bash
# 1. Clonar o repositório
git clone [url]
cd [projeto]

# 2. Instalar dependências
npm install

# 3. Configurar variáveis de ambiente
cp .env.example .env
# Edite .env com os valores locais

# 4. Subir banco de dados
docker-compose up -d

# 5. Rodar migrations
npm run migration:run

# 6. Iniciar em desenvolvimento
npm run start:dev
```

---

## Pipeline de deploy

```
Desenvolvedor faz push para main
        ↓
GitHub Actions roda testes
        ↓
Testes passam → deploy automático em staging
        ↓
Owner verifica em staging
        ↓
Owner aprova → deploy em produção
```

### Rollback
Como voltar para versão anterior:
```bash
# [comandos específicos do serviço de deploy]
```
Tempo estimado de rollback: [X minutos]

---

## Variáveis de ambiente

Ver `.env.example` para lista completa.

| Variável | Ambiente | Descrição |
|---|---|---|
| `DATABASE_URL` | Todos | String de conexão PostgreSQL |
| `JWT_SECRET` | Todos | Chave para assinar tokens JWT |
| `JWT_EXPIRATION` | Todos | Tempo de expiração (ex: 15m) |
| `[OUTRA]` | [env] | [descrição] |

---

## Monitoramento

| O que monitorar | Ferramenta | Como acessar |
|---|---|---|
| Uptime | UptimeRobot (gratuito) | [url dashboard] |
| Logs | [serviço de logs] | [como acessar] |
| Erros | [serviço] | [como acessar] |
| Performance banco | [serviço] | [como acessar] |

### Alertas configurados
- Sistema fora do ar → [quem recebe] por [canal]
- Erro 500 em produção → [quem recebe] por [canal]
- Banco acima de 80% de capacidade → [quem recebe]

---

## Backup

| O que | Frequência | Retenção | Como restaurar |
|---|---|---|---|
| Banco de dados | [frequência] | [período] | [procedimento] |
| Arquivos/storage | [frequência] | [período] | [procedimento] |

**Último teste de restore:** [data] — [resultado]

---

## Segurança de infraestrutura

- [ ] HTTPS configurado e automático
- [ ] HTTP redireciona para HTTPS
- [ ] Variáveis sensíveis nunca no repositório
- [ ] Secrets gerenciados pelo serviço de deploy
- [ ] Acesso ao banco apenas pelo backend (não exposto externamente)
- [ ] Rate limiting configurado em endpoints de auth
- [ ] CORS configurado explicitamente

---

## Domínio e SSL

- Domínio: [domínio ou subdomínio do serviço]
- SSL: [automático via serviço / Let's Encrypt / outro]
- Renovação: [automática / manual — quando]
