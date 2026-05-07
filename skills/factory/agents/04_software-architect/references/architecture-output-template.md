# 04 - Arquitetura Técnica

Produzido por: Software Architect Agent

---

## Stack tecnológica

| Componente | Tecnologia | Justificativa |
|---|---|---|
| Backend | [tecnologia] | [requisito que justifica] |
| Frontend | [tecnologia] | [requisito que justifica] |
| Banco de dados | [tecnologia] | [requisito que justifica] |
| ORM | [tecnologia] | [requisito que justifica] |
| Autenticação | [abordagem] | [requisito que justifica] |
| Storage | [tecnologia] | [requisito que justifica] |
| Deploy backend | [plataforma] | [custo/requisito] |
| Deploy frontend | [plataforma] | [custo/requisito] |

### Decisões descartadas e motivo
- [tecnologia descartada]: [por que não foi escolhida]

---

## Arquitetura em camadas

```
[Desenho textual das camadas]
```

### Responsabilidades por camada

**[Camada 1]:**
- Pode: [o que pode fazer]
- Não pode: [o que nunca faz]

**[Camada 2]:**
[idem]

### Regras entre camadas
- [regra 1]
- [regra 2]

---

## Módulos do sistema

| Módulo | Responsabilidade | Depende de |
|---|---|---|
| [módulo] | [o que faz] | [dependências] |

---

## Contratos entre módulos

### Módulo: [Nome]
**Casos de uso expostos:**
- `[NomeCasoDeUso]` — [descrição]

**Eventos emitidos:**
- `[NOME_EVENTO]` — [quando e com quais dados]

**Eventos consumidos:**
- `[NOME_EVENTO]` — [o que faz com ele]

---

## Autenticação e autorização

[Descreva o modelo de autenticação e como permissões funcionam]

---

## Integrações externas

| Sistema | Tipo | Obrigatória | Como isolar |
|---|---|---|---|
| [sistema] | [REST/webhook/arquivo] | [sim/não] | [padrão adapter/port] |

---

## Decisões técnicas registradas

| Decisão | Alternativa | Escolha | Motivo |
|---|---|---|---|
| [decisão] | [alternativa] | [escolha] | [motivo] |

---

## Riscos identificados

| Risco | Probabilidade | Impacto | Mitigação |
|---|---|---|---|
| [risco] | [alta/média/baixa] | [alto/médio/baixo] | [como mitigar] |

---

## Padrões e convenções

[Convenções de código, nomenclatura, estrutura de pastas]
