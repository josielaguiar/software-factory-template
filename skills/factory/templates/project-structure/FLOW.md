# FLOW.md — Estado do Processo

Este arquivo é a memória compartilhada entre os agentes da fábrica.
Todo agente lê este arquivo antes de atuar e atualiza ao concluir.
O Owner não precisa editar este arquivo — os agentes cuidam disso.

---

## Projeto
Nome: {{PRODUTO_NOME}}
Categoria: {{PRODUTO_CATEGORIA}}
Iniciado em: {{DATA_INICIO}}

---

## Status atual

Etapa concluída: —
Próxima etapa: Orquestrador → Market Researcher
Aguardando: início do processo

---

## Pipeline

| # | Etapa | Status | Data | Observação |
|---|---|---|---|---|
| 0 | Orquestrador | ⏳ Pendente | — | — |
| 1 | Market Researcher | ⏳ Pendente | — | — |
| 2 | Business Analyst | ⏳ Pendente | — | — |
| 3 | UX Strategist | ⏳ Pendente | — | — |
| 4 | Software Architect | ⏳ Pendente | — | — |
| 5 | Tech Lead | ⏳ Pendente | — | — |
| 6 | QA Strategist | ⏳ Pendente | — | — |
| 7 | DevOps Advisor | ⏳ Pendente | — | — |

Legenda: ⏳ Pendente | 🔄 Em andamento | ✅ Concluído | ⏸ Aguardando Owner

---

## Decisões do Owner

Registre aqui cada decisão tomada pelo Owner durante o processo.
Agentes subsequentes devem ler esta seção antes de atuar.

| Data | Etapa | Decisão |
|---|---|---|
| — | — | — |

---

## Outputs gerados

| Etapa | Arquivo gerado |
|---|---|
| Market Researcher | docs/market-research.md |
| Business Analyst | docs/01_Visao_Produto.md, docs/02_PRD_Requisitos_Funcionais.md |
| UX Strategist | docs/06_UX_Personas_e_Jornadas.md |
| Software Architect | docs/04_Arquitetura_Tecnica.md, docs/05_Modelo_de_Dados.md |
| Tech Lead | docs/07_Roadmap.md, docs/09_Contratos_Entre_Camadas.md |
| QA Strategist | docs/11_Plano_de_Testes.md |
| DevOps Advisor | docs/12_Infraestrutura_e_Deploy.md |

---

## Histórico de sessões

| Data | O que foi feito |
|---|---|
| — | Projeto iniciado |

---

## Instrução para agentes

Ao iniciar qualquer sessão nova:
1. Leia este arquivo completamente
2. Identifique a etapa atual e o que está pendente
3. Informe o Owner resumidamente onde o projeto está
4. Pergunte se pode continuar ou se há algo a ajustar
5. Ao concluir sua etapa, atualize este arquivo antes de encerrar
