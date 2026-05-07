# 17 - Governanca da Documentacao

## Objetivo

Definir:

- qual documento e fonte de verdade para cada assunto;
- como propagar decisoes;
- quando atualizar docs factuais;
- quais checagens fazer antes de commitar docs.

## Fontes de verdade por assunto

| Assunto | Fonte principal | Espelhos comuns |
|---|---|---|
| Contexto e navegacao documental | `docs/00_Contexto_Mestre.md` | `CLAUDE.md`, `README.md` |
| Produto e requisitos | `docs/01_Visao_Produto.md`, `docs/02_PRD_Requisitos_Funcionais.md` | `docs/07_Roadmap.md` |
| Arquitetura e dados | `docs/04_Arquitetura_Tecnica.md`, `docs/05_Modelo_de_Dados.md` | `docs/09_Contratos_Entre_Camadas.md` |
| Permissoes e escopo | `docs/10_Permissoes_e_Acessos.md` | `docs/13_Cadastros_e_Telas.md` |
| Andamento parcial | `docs/18_Andamento_Atual.md` | `docs/00_Contexto_Mestre.md` |
| Estado real do produto | `docs/20_Estado_Atual_do_Produto.md` | `docs/21_Matriz_de_Acoes_e_Efeitos.md`, `docs/22_Runbook_Operacional_do_Produto.md` |

## Regras

1. atualizar primeiro a fonte de verdade;
2. depois atualizar espelhos e historicos;
3. quando o produto real mudar, atualizar tambem `20`, `21` e `22`;
4. quando houver progresso parcial de fase, atualizar `docs/18_Andamento_Atual.md`;
5. quando uma sessao encerrar com pendencia operacional, registrar tambem no `FLOW.md`;
6. antes de commit documental, revisar consistencia e checar `git diff --check`.

## Matriz de propagacao minima

| Quando mudar | Atualizar obrigatoriamente |
|---|---|
| regra de negocio ou escopo | `docs/01`, `docs/02`, `docs/07`, `docs/Decisoes.md` |
| arquitetura, dados ou permissao | `docs/04`, `docs/05`, `docs/09`, `docs/10`, `docs/Decisoes.md` |
| progresso parcial de fase | `docs/18_Andamento_Atual.md`, `FLOW.md` |
| estado real do produto | `docs/20`, `docs/21`, `docs/22` |
| passo operacional, deploy ou rotina de validacao | `docs/22_Runbook_Operacional_do_Produto.md`, `FLOW.md` |

## Regra de autonomia documental

O agente deve atualizar docs sem depender de pedido explicito do usuario quando a mudanca ja tiver sido implementada, validada ou decidida durante a sessao.

## Regra de leitura minima

O agente deve confiar primeiro na trilha documental indicada em `docs/00_Contexto_Mestre.md`.

Regra:

- nao abrir todos os docs por padrao;
- nao reler arquivos grandes sem motivo concreto;
- escalar leitura somente quando a trilha minima deixar lacuna real.

O agente so deve pausar para confirmar quando:

- a mudanca documental implicar decisao de produto ainda nao fechada;
- houver duvida real sobre qual documento e fonte;
- a acao seguinte sair do escopo local, como `push` ou deploy em ambiente externo.
