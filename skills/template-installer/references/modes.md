# Modos do Template Installer

## `new`

Usar quando:

- a pasta está vazia;
- o projeto vai nascer agora;
- o usuário quer iniciar um repositório do zero com a espinha dorsal do template.

Comportamento:

- cria a base completa;
- pode inicializar Git se pedido;
- sugere seguir por `FLOW.md` -> `docs/00_Contexto_Mestre.md` -> `skills/factory`.

## `existing`

Usar quando:

- já existe código;
- o projeto está pela metade;
- o usuário quer organizar um produto que já está em andamento.

Comportamento:

- cria só o que estiver faltando por padrão;
- preserva arquivos existentes;
- orienta preencher `docs/20`, `docs/21` e `docs/22`.

## `sync`

Usar quando:

- o projeto já usa o template;
- o usuário quer atualizar a fábrica sem reescrever a memória do projeto.

Comportamento:

- sincroniza `skills/`;
- opcionalmente sincroniza `AGENTS.md` e `CLAUDE.md`;
- não sobrescreve `FLOW.md` nem docs factuais por padrão.
