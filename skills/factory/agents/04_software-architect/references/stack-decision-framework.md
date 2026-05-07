# Stack Decision Framework

Use para avaliar e justificar cada componente da stack.
Nunca escolha por preferência — escolha por requisito.

---

## Critérios de avaliação

Para cada componente, avalie:

| Critério | Peso | Descrição |
|---|---|---|
| Adequação ao problema | Alto | Resolve bem o problema específico? |
| Curva de aprendizado | Médio | O time consegue operar? |
| Ecossistema e suporte | Alto | Tem comunidade ativa, libs disponíveis? |
| Custo operacional | Alto | Quanto custa manter em produção? |
| Escalabilidade | Médio | Suporta o crescimento esperado? |
| Maturidade | Alto | É estável para produção? |
| Compatibilidade | Alto | Integra bem com os outros componentes? |

---

## Opções por componente

### Backend — API / Servidor

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| NestJS (Node/TS) | SaaS B2B, APIs REST, RBAC, multitenancy | Processamento pesado de dados |
| FastAPI (Python) | APIs de dados, ML, scripts | UI complexa, multitenancy elaborado |
| Django (Python) | CRUD rápido, admin interno, projetos solo | Alta concorrência sem ajuste |
| Express (Node) | APIs simples, protótipos | Projetos grandes sem estrutura |
| Laravel (PHP) | CRUD, e-commerce, times PHP | Microserviços, alta escala |
| Spring Boot (Java) | Enterprise, alta escala, equipe Java | Projetos pequenos, startup rápida |

### Frontend Web

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| React + Vite | SaaS, apps complexos, PWA | Sites simples sem interatividade |
| Next.js | SEO importante, e-commerce, marketing | App interno sem SEO |
| Vue + Vite | Times menores, curva menor | Ecossistema menor de libs |
| Astro | Sites estáticos, blog, marketing | App com muita interatividade |
| HTML/CSS puro | Landing page, site simples | Qualquer app com estado |

### Mobile

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| React Native | App cross-platform, time web existente | Performance nativa crítica |
| Flutter | UI customizada, cross-platform, Dart ok | Integração profunda com APIs nativas |
| PWA (React) | MVP mobile, app simples, sem loja | Acesso a hardware avançado |
| Swift/Kotlin nativo | Performance máxima, hardware profundo | Time pequeno, orçamento limitado |

### Banco de dados

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| PostgreSQL | SaaS, relacional, transações, JSON | Escala massiva sem DBA |
| MySQL/MariaDB | LAMP stack, e-commerce legado | JSON complexo, arrays |
| MongoDB | Documentos flexíveis, logs, catálogo | Transações complexas, joins |
| SQLite | Local, desktop, testes | Concorrência alta, produção web |
| Redis | Cache, sessões, filas simples | Persistência principal |

### ORM / Acesso a dados

| Tecnologia | Stack | Melhor para |
|---|---|---|
| TypeORM | Node/TS | NestJS, migrations, decorators |
| Prisma | Node/TS | Developer experience, type safety |
| SQLAlchemy | Python | FastAPI, Django customizado |
| Eloquent | PHP/Laravel | Laravel |
| Hibernate | Java | Spring Boot |

### Autenticação

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| JWT próprio | Controle total, offline, microserviços | Se não entende os riscos |
| Auth0 | Rápido, social login, enterprise | Custo em escala, dados sensíveis fora |
| Supabase Auth | Stack Supabase, MVP rápido | Controle fino de permissões |
| NextAuth | Next.js, social providers | Backend separado |
| Keycloak | Enterprise, SSO, LDAP | Projetos pequenos |

### Storage de arquivos

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| Cloudflare R2 | Custo baixo, CDN global, S3 compatible | Requer suporte AWS específico |
| AWS S3 | Ecossistema AWS, escala, maturidade | Custo de egress alto |
| Supabase Storage | Stack Supabase, simplicidade | Grande volume |
| Local/disco | Desenvolvimento, MVP sem documento | Qualquer produção real |

### Deploy e infraestrutura

| Tecnologia | Melhor para | Evitar quando |
|---|---|---|
| Render | Backend simples, free tier, auto-deploy | Alta escala, infra complexa |
| Vercel | Frontend Next.js/React, edge functions | Backend pesado |
| Railway | Full-stack simples, banco incluído | Escala enterprise |
| Fly.io | Containers, regiões múltiplas, latência | Times sem Docker |
| AWS/GCP/Azure | Enterprise, escala, controle total | Projetos pequenos sem DevOps |
| Neon | PostgreSQL serverless, branching | Alto volume de conexões |

---

## Combinações testadas e aprovadas pelo mercado

### SaaS B2B — Stack recomendada
```
Backend: NestJS + TypeScript
Frontend: React + Vite + TypeScript
Banco: PostgreSQL (Neon em dev/staging)
ORM: TypeORM com migrations
Auth: JWT próprio via NestJS Guards
Storage: Cloudflare R2
Deploy: Render (backend) + Vercel (frontend)
```

### App Mobile B2C — Stack recomendada
```
Backend: NestJS ou FastAPI
Mobile: React Native ou PWA
Banco: PostgreSQL
Auth: JWT + refresh token
Push: Firebase Cloud Messaging
Deploy: Railway ou Render
```

### Ferramenta interna — Stack recomendada
```
Backend: NestJS ou Django
Frontend: React + Vite
Banco: PostgreSQL
Auth: JWT simples ou SSO existente
Deploy: Docker + VPS ou Railway
```

### E-commerce — Stack recomendada
```
Frontend: Next.js (SEO crítico)
Backend: NestJS ou API do e-commerce
Banco: PostgreSQL
Pagamento: Stripe ou PagSeguro/MercadoPago (Brasil)
Deploy: Vercel (frontend) + Render (backend)
```

---

## Perguntas que sempre responde antes de decidir stack

1. Qual é o tamanho do time que vai manter isso?
2. Qual é o nível técnico do time?
3. Qual é o orçamento mensal máximo de infraestrutura?
4. Em quanto tempo precisa estar no ar?
5. Qual é o volume esperado em 12 meses?
6. Tem requisito de dados no Brasil? (LGPD, dado fiscal)
7. Precisa de integração com algum sistema legado?
