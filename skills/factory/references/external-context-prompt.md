# Prompt para recuperar contexto de outro agente

Quando o usuario disser que ja discutiu o projeto com ChatGPT, Claude ou outro agente, o orquestrador pode pedir que ele cole este prompt no outro chat e traga a resposta:

```text
Quero transferir este projeto para outro agente de software.
Monte um resumo estruturado e objetivo, sem marketing, contendo:

1. nome provisório do projeto
2. objetivo principal
3. quem são os usuários
4. problema que resolve
5. fluxo principal esperado
6. funcionalidades já discutidas
7. o que está fora de escopo
8. decisões já tomadas
9. dúvidas ainda abertas
10. arquitetura ou stack já sugerida, se houver
11. fase atual do projeto, se já existir
12. riscos ou pontos sensíveis percebidos

Se algo não tiver sido definido, escreva "não definido".
```

## Como usar o retorno

Depois de receber a resposta:

- tratar como contexto inicial, nao como verdade absoluta;
- cruzar com o que existir no repositorio;
- identificar lacunas e contradicoes;
- perguntar apenas o complemento necessario.
