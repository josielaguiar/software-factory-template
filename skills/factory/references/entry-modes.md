# Modos de entrada da factory

## Objetivo

Fazer a orquestradora decidir primeiro o tipo de entrada do trabalho, antes de escolher entrevista, auditoria ou pipeline completo.

## Modos

### `zero`

Usar quando:

- o usuario esta começando de verdade;
- nao existe conversa anterior aproveitavel;
- nao existe repo, app ou base documental real.

Sinal:

- a pessoa tem ideia, mas nao tem estrutura ainda.

### `external-context`

Usar quando:

- o usuario ja falou com ChatGPT, Claude ou outro agente;
- existe resumo, prompt, documento ou rascunho fora do projeto;
- vale a pena importar contexto antes de perguntar muito.

Sinal:

- a pessoa diz que "ja conversou bastante sobre isso" ou "ja tem um resumo em outro chat".

### `existing-project`

Usar quando:

- ja existe codigo;
- ja existe produto em andamento;
- ja existe repo, docs, APK, portal ou algo concreto para ler.

Sinal:

- a leitura do repositorio precisa vir antes da entrevista.

### `template-resume`

Usar quando:

- o projeto ja usa este template;
- existe `FLOW.md`;
- a intencao e retomar ou redetalhar o que ja estava em curso.

Sinal:

- o repositorio ja tem memoria de processo e docs do proprio modelo.
