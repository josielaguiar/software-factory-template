# Monitoramento Mínimo

O mínimo que todo produto precisa antes de ter usuários reais.
Sem isso você descobre que o sistema caiu quando o usuário reclama.

---

## Uptime monitoring — gratuito

**UptimeRobot** (https://uptimerobot.com)
- Gratuito para até 50 monitores
- Verifica a cada 5 minutos
- Alerta por email, SMS ou webhook

Configurar:
1. Criar conta gratuita
2. Adicionar monitor HTTP para `https://sua-api.com/health`
3. Adicionar monitor HTTP para `https://seu-site.com`
4. Configurar alerta por email para o Owner

---

## Health check endpoint

Todo backend deve ter um endpoint `/health` que retorna:

```json
{
  "status": "ok",
  "timestamp": "2026-04-25T10:00:00Z",
  "database": "ok",
  "version": "1.0.0"
}
```

Se banco estiver fora:
```json
{
  "status": "degraded",
  "database": "error",
  "message": "Database connection failed"
}
```

Retorna 200 se ok, 503 se degradado.

---

## Logs em produção

### Render
- Logs disponíveis no dashboard em tempo real
- Retenção: últimas 24h no plano gratuito
- Para mais retenção: integrar com Logtail (gratuito até 1GB/mês)

### Vercel
- Logs de função no dashboard
- Runtime logs em tempo real

### Como acessar quando algo dá errado
```
Render: Dashboard → Serviço → Logs
Vercel: Dashboard → Projeto → Functions → Logs
```

---

## Alertas de erro

### Sentry (gratuito para projetos pequenos)
Captura erros em tempo real com stack trace completo.

Integração NestJS:
```bash
npm install @sentry/node
```

```typescript
// main.ts
Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
})
```

Alerta automático por email a cada novo erro em produção.

---

## Dashboard simples de métricas

Para o início, o que monitorar manualmente 1x por semana:

| Métrica | Onde verificar | Alerta se |
|---|---|---|
| Uptime | UptimeRobot | < 99% na semana |
| Erros em produção | Sentry / logs | Qualquer erro novo |
| Uso de banco | Neon dashboard | > 70% do limite |
| Requisições | Render dashboard | Pico inesperado |
| Bandwidth | Vercel dashboard | > 80% do limite free |

---

## Canais de alerta recomendados

Por ordem de praticidade para projetos solo/pequenos:

1. **Email** — simples, funciona, não precisa de configuração extra
2. **WhatsApp via Zapier** — mais imediato, gratuito até certo volume
3. **Slack** — ótimo se já usa, integração nativa com serviços
4. **Telegram bot** — gratuito, imediato, fácil de configurar

Para o início: email é suficiente. Configure um endereço dedicado
para alertas do sistema (ex: alerts@seudominio.com).
