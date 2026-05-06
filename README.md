# Software Factory Template

Template padrao para iniciar ou reorganizar projetos de software com:

- `FLOW.md` como memoria do processo;
- `docs/00` como mapa da documentacao;
- camada de planejamento, tecnica e factual padronizada;
- skills modulares para descoberta, detalhamento, entrega e auditoria.

## Objetivo

Este repositorio existe para servir como base reutilizavel em dois cenarios:

1. projeto novo, iniciado do zero;
2. projeto existente, ja em andamento, que precisa ganhar governanca e documentacao padrao.

## Estrutura principal

```text
FLOW.md
CLAUDE.md
docs/
manifest/
scripts/
skills/
```

## Como usar

### Projeto novo

PowerShell:

```powershell
.\scripts\install-template.ps1 -TargetPath C:\caminho\do\projeto -Mode new
```

Shell:

```bash
./scripts/install-template.sh /caminho/do/projeto new
```

Depois:

1. abra o projeto;
2. siga `FLOW.md` -> `docs/00_Contexto_Mestre.md`;
3. acione a `skills/factory` para iniciar o pipeline.

### Projeto existente

PowerShell:

```powershell
.\scripts\install-template.ps1 -TargetPath C:\caminho\do\projeto -Mode existing
```

Shell:

```bash
./scripts/install-template.sh /caminho/do/projeto existing
```

Depois:

1. mantenha o codigo existente;
2. adapte primeiro `docs/00_Contexto_Mestre.md`;
3. preencha `docs/20`, `docs/21` e `docs/22` com o estado real do produto;
4. use a `skills/factory/auditor` e as demais skills conforme necessidade.

### Sincronizar o template em projetos ja instalados

PowerShell:

```powershell
.\scripts\sync-template.ps1 -TargetPath C:\caminho\do\projeto
```

Shell:

```bash
./scripts/sync-template.sh /caminho/do/projeto
```

O `sync` atualiza `skills/` por padrao e preserva `FLOW.md` e docs factuais do projeto.

## Camadas de documentacao

- `00` a `15`: contexto, planejamento, arquitetura e regras.
- `17` a `19`: governanca, andamento e checklist obrigatorio.
- `20` a `22`: camada factual do produto real.

## Skills incluidas

- `template-installer`
- `factory`
- `phase-detailing`
- `saas-delivery-checklist`
- `saas-multitenancy-contract`

## Evolucao futura

Este template foi pensado para evoluir para um modelo instalavel via GitHub, de forma que uma unica skill possa instalar:

- estrutura base;
- docs padrao;
- `FLOW.md`;
- skills modulares;
- adaptacao inicial para projeto novo ou legado.

## Referencias do proprio template

- `docs/23_Instalacao_e_Sincronizacao_do_Template.md`
- `manifest/template-manifest.json`
- `scripts/install-template.ps1`
- `scripts/install-template.sh`
- `scripts/sync-template.ps1`
- `scripts/sync-template.sh`
- `skills/template-installer/`
