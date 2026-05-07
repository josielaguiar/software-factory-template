# 00 - Contexto Mestre

## Projeto
[Nome do projeto]

## Contexto
[Resumo do problema, contexto de negocio e ambiente do projeto]

## Objetivo
- [objetivo 1]
- [objetivo 2]
- [objetivo 3]

## Decisoes tomadas
- [decisao estrutural 1]
- [decisao estrutural 2]

## Principios
- [principio 1]
- [principio 2]
- [principio 3]

## Contexto mestre da documentacao

Este documento e a porta de entrada da documentacao.

Regra geral:

- ler o `00` antes de abrir varios arquivos;
- nao reler tudo em toda sessao;
- consultar apenas o minimo necessario conforme o tipo da tarefa.

## Papeis dos documentos

### Contexto e produto

- `docs/00_Contexto_Mestre.md`
- `docs/01_Visao_Produto.md`
- `docs/02_PRD_Requisitos_Funcionais.md`
- `docs/03_Requisitos_Nao_Funcionais.md`
- `docs/11_Contexto_Operacional.md`
- `docs/11_Plano_de_Testes.md`

### Planejamento e execucao

- `docs/07_Roadmap.md`
- `docs/18_Plano_de_Implementacao.md`
- `docs/15_Pendencias_e_Bloqueantes.md`
- `docs/18_Andamento_Atual.md`
- `docs/19_Checklist_Implementacao_Obrigatoria.md`

### Arquitetura e regras tecnicas

- `docs/04_Arquitetura_Tecnica.md`
- `docs/05_Modelo_de_Dados.md`
- `docs/08_Convencoes_do_Projeto.md`
- `docs/09_Contratos_Entre_Camadas.md`
- `docs/10_Permissoes_e_Acessos.md`
- `docs/12_Decisoes_Tecnologicas.md`
- `docs/12_Infraestrutura_e_Deploy.md`

### UX e experiencia

- `docs/06_UX_Personas_e_Jornadas.md`
- `docs/13_Cadastros_e_Telas.md`

### Estado factual do produto

- `docs/20_Estado_Atual_do_Produto.md`
- `docs/21_Matriz_de_Acoes_e_Efeitos.md`
- `docs/22_Runbook_Operacional_do_Produto.md`

### Governanca e historico

- `docs/14_Atualizacoes_e_Complementos.md`
- `docs/17_Governanca_Documentacao.md`
- `docs/Decisoes.md`
- `docs/Changelog.md`

### Operacao do proprio template

- `docs/23_Instalacao_e_Sincronizacao_do_Template.md`

## Sequencia de leitura por tipo de tarefa

### Se o pedido for planejar

1. `docs/00_Contexto_Mestre.md`
2. `docs/07_Roadmap.md`
3. `docs/15_Pendencias_e_Bloqueantes.md`
4. `docs/18_Andamento_Atual.md`

Se isso bastar para responder ou prosseguir, pare aqui.
So abra mais docs se houver lacuna real.

### Se o pedido for implementar

1. `docs/00_Contexto_Mestre.md`
2. `docs/19_Checklist_Implementacao_Obrigatoria.md`
3. `docs/04_Arquitetura_Tecnica.md`
4. `docs/05_Modelo_de_Dados.md`
5. `docs/09_Contratos_Entre_Camadas.md`
6. `docs/10_Permissoes_e_Acessos.md`

So depois disso abrir docs modulares extras, e apenas se a tarefa realmente pedir.

### Se o pedido for entender o produto real

1. `docs/00_Contexto_Mestre.md`
2. `docs/20_Estado_Atual_do_Produto.md`
3. `docs/21_Matriz_de_Acoes_e_Efeitos.md`
4. `docs/22_Runbook_Operacional_do_Produto.md`

Evite abrir planejamento macro ou arquitetura inteira se o pedido for apenas factual.

### Se o pedido for instalar ou sincronizar o template

1. `docs/00_Contexto_Mestre.md`
2. `docs/23_Instalacao_e_Sincronizacao_do_Template.md`
3. `README.md`

### Se o pedido for retomar projeto existente sem clareza do estado

1. `FLOW.md`
2. `docs/00_Contexto_Mestre.md`
3. `docs/18_Andamento_Atual.md`
4. `docs/20_Estado_Atual_do_Produto.md`

So depois expandir para docs tecnicos ou codigo.

## Regra pratica para agentes

- nao criar documento novo sem verificar se ele cabe na estrutura existente;
- atualizar primeiro a fonte de verdade e depois espelhos;
- quando o estado real do produto mudar, atualizar tambem `20`, `21` e `22`.
- nao depender do usuario para lembrar leitura minima, testes, atualizacao documental ou commit local;
- tratar a trilha de docs por tipo de tarefa como suficiente por padrao;
- so ampliar a leitura quando a trilha minima nao resolver a demanda com seguranca;
- usar `FLOW.md` para estado e `docs/22_Runbook_Operacional_do_Produto.md` para operacao;
- usar `docs/23_Instalacao_e_Sincronizacao_do_Template.md` quando a tarefa for instalar ou atualizar o template em outro projeto;
- ao concluir um bloco relevante, atualizar tambem `docs/18_Andamento_Atual.md`;
- perguntar ao usuario apenas em fronteiras externas ou decisoes com trade-off nao obvio.
