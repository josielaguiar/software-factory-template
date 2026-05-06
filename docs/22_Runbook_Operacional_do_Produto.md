# 22 - Runbook Operacional do Produto

## Objetivo

Concentrar o minimo necessario para:

- rodar o projeto;
- publicar ou gerar artefatos;
- validar mudancas;
- operar o ambiente sem improviso.

## Politica operacional do template

O agente deve usar este documento para decidir como fechar o trabalho tecnicamente, e nao apenas como rodar comandos.

Regra geral:

- validacao local e commit local podem seguir sem confirmacao extra;
- `push` e deploy em ambiente compartilhado pedem alinhamento com o usuario;
- quando houver redeploy simples e previsivel, o agente deve pelo menos sinalizar que o pacote esta pronto;
- quando houver dependencia externa, credencial, painel ou risco operacional, o agente deve parar e explicar a proxima acao necessaria.

## Itens sugeridos

- como rodar localmente;
- como buildar;
- como testar;
- como tratar banco e seeds;
- checklist pos-mudanca;
- riscos operacionais atuais.

## Checklist minimo pos-mudanca

- build local ou validacao equivalente executada;
- testes relevantes executados ou lacuna registrada;
- docs afetados atualizados;
- `FLOW.md` atualizado com status e proxima acao;
- commit local preparado quando houver pacote coeso;
- necessidade de `push`, deploy ou acao manual registrada.
