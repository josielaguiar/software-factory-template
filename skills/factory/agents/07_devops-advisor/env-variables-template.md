# .env.example
# Copie para .env e preencha com os valores reais
# NUNCA commite o .env no repositório

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# APLICAÇÃO
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NODE_ENV=development
PORT=3000
APP_URL=http://localhost:3000
FRONTEND_URL=http://localhost:5173

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# BANCO DE DADOS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DATABASE_URL=postgresql://usuario:senha@localhost:5432/nome_do_banco
# Exemplo Neon: postgresql://usuario:senha@ep-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# AUTENTICAÇÃO JWT
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
JWT_SECRET=sua-chave-secreta-muito-longa-e-aleatoria-aqui
JWT_EXPIRATION=15m
JWT_REFRESH_SECRET=outra-chave-secreta-para-refresh-token
JWT_REFRESH_EXPIRATION=7d

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STORAGE (Cloudflare R2)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STORAGE_ENDPOINT=https://[account-id].r2.cloudflarestorage.com
# STORAGE_ACCESS_KEY=sua-access-key
# STORAGE_SECRET_KEY=sua-secret-key
# STORAGE_BUCKET=nome-do-bucket
# STORAGE_PUBLIC_URL=https://pub-xxx.r2.dev

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# EMAIL (se necessário)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# SMTP_HOST=smtp.exemplo.com
# SMTP_PORT=587
# SMTP_USER=seu@email.com
# SMTP_PASS=sua-senha
# EMAIL_FROM=noreply@seuproduto.com

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# INTEGRAÇÕES EXTERNAS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# [SERVICO]_API_KEY=sua-api-key
# [SERVICO]_BASE_URL=https://api.servico.com
# [SERVICO]_WEBHOOK_SECRET=seu-webhook-secret

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# OBSERVABILIDADE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# LOG_LEVEL=info
# SENTRY_DSN=https://xxx@sentry.io/xxx
