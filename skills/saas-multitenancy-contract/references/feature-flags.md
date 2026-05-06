# Padrões de Feature Flags SaaS

---

## Princípio

Feature flags em SaaS não são variáveis de ambiente nem condicionais de plano. São registros no banco que dizem, para cada tenant, quais funcionalidades estão ativas. Isso permite ativar features por tenant individualmente, sem redeploy.

---

## Modelo de dados mínimo

```
Plano: id, nome, status
Feature: code, modulo, descricao, status
PlanoFeature: plano_id, feature_code, enabled
EmpresaFeatureOverride (opcional): empresa_id, feature_code, enabled, motivo
```

O override por empresa permite ativar/desativar uma feature para um tenant específico independentemente do plano — útil para pilotos, clientes especiais ou bloqueios emergenciais.

---

## Como verificar no caso de uso

```typescript
// Verificação obrigatória antes de qualquer lógica
async execute(tenantId: string, userId: string, input: Input) {
  // 1. Verifica feature
  await this.featureService.assertActive(tenantId, 'FEATURE_CODE')
  
  // 2. Verifica papel
  await this.authService.assertRole(userId, tenantId, ['ROLE_REQUIRED'])
  
  // 3. Executa lógica de negócio
  ...
}
```

---

## O que a verificação deve fazer

```typescript
async assertActive(tenantId: string, featureCode: string): Promise<void> {
  const empresa = await this.empresaRepo.findOne({ where: { id: tenantId } })
  
  // Verificar override específico da empresa primeiro
  const override = await this.overrideRepo.findOne({
    where: { empresa_id: tenantId, feature_code: featureCode }
  })
  if (override) {
    if (!override.enabled) throw new ForbiddenException(`Feature ${featureCode} não disponível`)
    return // override ativo, ok
  }
  
  // Verificar pelo plano da empresa
  const planoFeature = await this.planoFeatureRepo.findOne({
    where: { plano_id: empresa.plano_id, feature_code: featureCode, enabled: true }
  })
  if (!planoFeature) throw new ForbiddenException(`Feature ${featureCode} não disponível no plano atual`)
}
```

---

## Códigos de feature — convenção de nomenclatura

```
MODULO_ENTIDADE_ACAO

Exemplos:
FIN_PAGAR_MANUAL        — financeiro, contas a pagar, lançamento manual
FIN_RECEBER_MANUAL      — financeiro, contas a receber, lançamento manual
FIN_CONCILIACAO_OFX     — financeiro, conciliação bancária via OFX
FIN_RECEBER_AUTO        — financeiro, recebimento automático (futuro)
FISCAL_NFSE_EMITIR      — fiscal, NFS-e, emissão
FISCAL_NFSE_CANCELAR    — fiscal, NFS-e, cancelamento
DOC_UPLOAD              — documental, upload de documento
DOC_SOLICITACAO         — documental, solicitação pela contabilidade
```

---

## Features nascem desativadas

Ao criar uma nova feature:
1. Inserir na tabela `Feature` com `status = ativo`
2. **Não ativar** em nenhum plano automaticamente
3. Ativar explicitamente nos planos que devem tê-la
4. Em desenvolvimento local, usar seed que ativa todas as features para facilitar testes

---

## Erros comuns a evitar

```typescript
// ERRADO — verifica plano pelo nome
if (empresa.plano === 'premium') { ... }

// ERRADO — verifica role como substituto de feature
if (user.role === 'admin') { ... }

// ERRADO — feature verificada na UI, não no backend
// (UI pode ser bypassada)

// CERTO — verifica feature no caso de uso, pelo código
await this.featureService.assertActive(tenantId, 'FIN_PAGAR_MANUAL')
```

---

## Seed de desenvolvimento

Em ambiente de desenvolvimento e staging, criar um seed que ativa todas as features para a empresa de teste:

```typescript
// seed/features.seed.ts
const allFeatureCodes = [
  'FIN_PAGAR_MANUAL',
  'FIN_RECEBER_MANUAL',
  'FIN_CONCILIACAO_OFX',
  'FISCAL_NFSE_EMITIR',
  // ...
]

// Ativar no plano padrão de desenvolvimento
for (const code of allFeatureCodes) {
  await planoFeatureRepo.upsert({
    plano_id: devPlano.id,
    feature_code: code,
    enabled: true,
  })
}
```

Isso garante que em dev todas as features funcionam sem precisar popular manualmente, mas o mecanismo de verificação já existe e está sendo exercitado.
