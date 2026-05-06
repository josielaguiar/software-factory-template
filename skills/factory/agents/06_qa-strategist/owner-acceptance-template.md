# Template de Aceite do Owner

Use ao final de cada fase para o Owner verificar manualmente
antes de considerar a fase concluída e avançar.

Linguagem simples — o Owner executa, não o desenvolvedor.

---

# Aceite — Fase [N]: [Nome]

Data: ___________
Verificado por: ___________

---

## O que você vai fazer

[Descrição em linguagem simples do que o Owner vai executar]

---

## Pré-requisitos para o teste

- [ ] Sistema rodando em staging (não em produção)
- [ ] Dados de teste disponíveis (usuário, empresa, etc.)
- [ ] Acesso com usuário de teste com papel [papel]

---

## Verificações principais

Execute cada item e marque se passou ou falhou:

| # | O que fazer | O que deve acontecer | ✅/❌ | Observação |
|---|---|---|---|---|
| 1 | [ação concreta] | [resultado esperado] | | |
| 2 | [ação concreta] | [resultado esperado] | | |
| N | [ação concreta] | [resultado esperado] | | |

---

## Verificações de segurança (Owner testa)

| # | O que tentar | O que deve acontecer | ✅/❌ |
|---|---|---|---|
| 1 | Acessar sem estar logado | Redirecionar para login | |
| 2 | Tentar acessar página de outro usuário/empresa | Ser bloqueado | |
| 3 | [verificação específica do produto] | [resultado] | |

---

## Verificações de dados

| # | O que verificar | Como verificar | ✅/❌ |
|---|---|---|---|
| 1 | Valores calculados corretos | [onde olhar] | |
| 2 | Relatório bate com lançamentos | [como comparar] | |
| 3 | [verificação específica] | [método] | |

---

## Resultado

[ ] **Aprovado** — todos os itens críticos passaram, fase concluída

[ ] **Aprovado com ressalvas** — itens menores falharam, registrados como melhoria
    Itens pendentes: ___________

[ ] **Reprovado** — itens críticos falharam, precisa corrigir antes de avançar
    Itens críticos com falha: ___________

---

## Observações do Owner

[Espaço para o Owner registrar qualquer percepção sobre usabilidade,
comportamento inesperado ou sugestão de melhoria]
