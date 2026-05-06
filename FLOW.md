# FLOW.md - Estado do Processo

Este arquivo e a memoria compartilhada entre os agentes da fabrica.
Todo agente le este arquivo antes de atuar e atualiza ao concluir.

---

## Projeto

Nome: [preencher]
Categoria: [saas-b2b | saas-b2c | internal-tool | mobile-app | website | ecommerce | automation | api-service]
Iniciado em: [YYYY-MM-DD]

---

## Status atual

Etapa concluida: -
Proxima etapa: Orquestrador -> [primeiro agente]
Aguardando: inicio do processo
Ultimo pacote concluido: -
Proxima acao operacional: -
Push/deploy pendente: nao

---

## Pipeline

| # | Etapa | Status | Data | Observacao |
|---|---|---|---|---|
| 0 | Orquestrador | Pendente | - | - |
| 1 | Market Researcher | Pendente | - | - |
| 2 | Business Analyst | Pendente | - | - |
| 3 | UX Strategist | Pendente | - | - |
| 4 | Software Architect | Pendente | - | - |
| 5 | Tech Lead | Pendente | - | - |
| 6 | QA Strategist | Pendente | - | - |
| 7 | DevOps Advisor | Pendente | - | - |

---

## Decisoes do Owner

| Data | Etapa | Decisao |
|---|---|---|
| - | - | - |

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

## Historico de sessoes

| Data | O que foi feito |
|---|---|
| - | Projeto iniciado |

---

## Checklist de encerramento da sessao

Antes de encerrar uma sessao ou bloco, registrar:

- o que foi concluido de fato;
- o que ficou pendente;
- quais docs foram atualizados;
- se houve mudanca no estado real do produto;
- se existe commit local pronto;
- se existe push ou deploy pendente de confirmacao do usuario;
- se existe acao manual necessaria fora do repositorio.

---

## Instrucao para agentes

Ao iniciar qualquer sessao nova:

1. leia este arquivo completamente;
2. identifique a etapa atual e o que esta pendente;
3. informe resumidamente onde o projeto esta;
4. leia `docs/00_Contexto_Mestre.md` antes de abrir outros docs;
5. escolha a trilha correta de leitura, implementacao, auditoria ou operacao;
6. atualize este arquivo ao concluir sua etapa ou bloco.
