# Skills do Template

Este template inclui skills modulares para diferentes momentos do projeto.

## Incluidas

- `template-installer/` -> instala ou sincroniza este template via GitHub
- `factory/` -> orquestracao da fabrica de software
- `phase-detailing/` -> detalhamento e redetalhamento de fases
- `saas-delivery-checklist/` -> checklist de entrega para projetos SaaS
- `saas-multitenancy-contract/` -> invariantes de multiempresa/SaaS

## Observacao

As skills foram trazidas como base reutilizavel e podem ser refinadas aqui antes da publicacao no GitHub.

## Relacao com os scripts

- `scripts/install-template.*` instala a espinha dorsal do modelo em projeto novo ou existente;
- `scripts/sync-template.*` atualiza as skills compartilhadas em projetos ja instalados;
- o `sync` preserva `FLOW.md` e docs factuais do projeto por padrao.
