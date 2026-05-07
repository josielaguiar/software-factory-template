# Contexto para Agentes - Software Factory Template

> Leia `FLOW.md` primeiro. Depois leia `docs/00_Contexto_Mestre.md`.

## Objetivo

Este repositorio e um template de governanca para projetos de software.

Ele padroniza:

- memoria do processo;
- mapa da documentacao;
- documentos de planejamento;
- documentos factuais;
- skills modulares de descoberta, detalhamento, entrega e auditoria.

## Contrato operacional do agente

Em projeto que usa este template, o agente nao deve depender do usuario para lembrar o basico.

O comportamento padrao e:

1. ler `FLOW.md` para descobrir o estado do projeto;
2. ler `docs/00_Contexto_Mestre.md` para escolher a trilha documental correta;
3. consultar os docs fonte do assunto antes de alterar codigo ou regra;
4. executar validacoes minimas antes de encerrar um bloco;
5. atualizar docs de andamento e docs factuais quando o estado real mudar;
6. registrar no `FLOW.md` o que concluiu, o que ficou pendente e qual e o proximo passo;
7. so entao preparar commit, deploy ou handoff.

## Economia de contexto

Este template foi desenhado para reduzir consumo desnecessario de contexto e creditos.

Regra geral:

1. ler primeiro `FLOW.md` e `docs/00_Contexto_Mestre.md`;
2. escolher a trilha minima conforme o pedido do Owner;
3. abrir apenas os docs dessa trilha;
4. expandir leitura apenas se surgir lacuna real, contradicao ou dependencia tecnica nova.

Nunca ler todos os docs por padrao.
Nunca reler grandes blocos sem necessidade na mesma sessao.
Preferir contexto minimo suficiente, nao contexto maximo por seguranca.

## Autonomia esperada

O agente pode seguir sem perguntar quando a acao for local, reversivel e esperada pelo fluxo:

- leitura e analise do repositorio;
- alteracao de codigo ou docs;
- execucao de testes locais;
- build local;
- atualizacao de `FLOW.md`, `docs/18`, `docs/20`, `docs/21` e `docs/22`;
- commit local de pacote coeso.

O agente deve avisar ou pedir confirmacao quando houver fronteira externa ou risco operacional relevante:

- `git push`;
- deploy em ambiente compartilhado;
- uso de credenciais, painel externo ou acao manual do usuario;
- mudanca irreversivel ou com risco de perda de dados;
- decisao de produto com trade-off nao obvio.

## Fechamento obrigatorio de bloco

Ao concluir um bloco de trabalho, o agente deve:

1. validar o que mudou;
2. atualizar primeiro a fonte de verdade e depois os espelhos;
3. atualizar `docs/18_Andamento_Atual.md` quando houver progresso parcial de fase;
4. atualizar `docs/20`, `docs/21` e `docs/22` quando o produto real tiver mudado;
5. atualizar `FLOW.md` com status, output, pendencias e proxima acao;
6. preparar commit local se houver pacote coeso;
7. perguntar sobre `push` apenas quando o estado ja estiver pronto para sair do repositorio local.

## Comandos documentais uteis

- "Atualize o andamento atual da fase" -> atualizar `docs/18_Andamento_Atual.md`
- "Atualize o estado real do produto" -> atualizar `docs/20`, `docs/21` e `docs/22`
- "Registre esta decisao" -> atualizar fonte de verdade, espelhos e historico
- "Revise a consistencia dos docs" -> rodar revisao documental

## Estrutura esperada

- `FLOW.md`
- `docs/00_Contexto_Mestre.md`
- `docs/17_Governanca_Documentacao.md`
- `docs/18_Andamento_Atual.md`
- `docs/19_Checklist_Implementacao_Obrigatoria.md`
- `docs/20_Estado_Atual_do_Produto.md`
- `docs/21_Matriz_de_Acoes_e_Efeitos.md`
- `docs/22_Runbook_Operacional_do_Produto.md`
- `skills/`
