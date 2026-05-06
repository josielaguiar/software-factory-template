# 23 - Instalacao e Sincronizacao do Template

## Objetivo

Explicar como este template deve ser aplicado em:

- projeto novo;
- projeto existente;
- atualizacao posterior das skills compartilhadas.

Tambem serve como referencia da skill `skills/template-installer/`, que automatiza esses modos a partir do GitHub.

## Modos oficiais

### 1. Projeto novo

Usar quando o repositorio ainda vai nascer ou esta praticamente vazio.

Objetivo:

- copiar a estrutura base;
- criar `FLOW.md`, `CLAUDE.md`, `AGENTS.md`, `docs/` e `skills/`;
- deixar o projeto pronto para iniciar pela `factory`.

Script:

- PowerShell: `scripts/install-template.ps1 -TargetPath <projeto> -Mode new`
- Shell: `scripts/install-template.sh <projeto> new`

### 2. Projeto existente

Usar quando o codigo ja existe e o que falta e governanca, documentacao e disciplina operacional.

Objetivo:

- inserir a espinha dorsal do template sem destruir o trabalho existente;
- criar arquivos ausentes;
- preservar arquivos ja presentes por padrao.

Script:

- PowerShell: `scripts/install-template.ps1 -TargetPath <projeto> -Mode existing`
- Shell: `scripts/install-template.sh <projeto> existing`

Depois da instalacao em projeto existente, o passo obrigatorio e preencher:

- `docs/20_Estado_Atual_do_Produto.md`
- `docs/21_Matriz_de_Acoes_e_Efeitos.md`
- `docs/22_Runbook_Operacional_do_Produto.md`

## Politica de sobrescrita

Por padrao:

- arquivos existentes sao preservados;
- arquivos ausentes sao criados;
- `-Force` ou `FORCE=1` ativa sobrescrita.

## Sincronizacao posterior

O sync nao deve sobrescrever a memoria do projeto.

Por isso, o modo padrao sincroniza:

- `skills/`

Opcionalmente, pode sincronizar tambem:

- `AGENTS.md`
- `CLAUDE.md`

Mas nao deve sobrescrever automaticamente:

- `FLOW.md`
- docs factuais do projeto;
- docs de andamento que ja refletem a realidade local.

Scripts:

- PowerShell: `scripts/sync-template.ps1 -TargetPath <projeto>`
- Shell: `scripts/sync-template.sh <projeto>`

Para incluir os guias raiz:

- PowerShell: `-IncludeGuides`
- Shell: `INCLUDE_GUIDES=1`

## Regra pratica

Use:

- instalacao `new` para projeto vazio;
- instalacao `existing` para projeto em andamento;
- `sync` para atualizar a fabrica depois que varios projetos ja estiverem usando o template.
