# Template de Inventário de Telas

Liste todas as telas do sistema. Não é wireframe — é inventário.
Cada tela tem um propósito claro e ações definidas.

---

## Navegação principal

```
[Desenho textual da navegação]

Ex para web app:
Sidebar/Menu:
  → Dashboard
  → Financeiro
    → Contas a Pagar
    → Contas a Receber
    → Relatórios
  → Configurações

Ex para mobile:
Bottom Nav:
  → Início  → Lançar  → Histórico  → Perfil
```

---

## Inventário de telas

### Área: [Nome da área/módulo]

---

**Tela: [Nome]**
- **Rota/caminho:** [ex: /financeiro/contas-pagar]
- **Persona principal:** [quem usa mais]
- **Objetivo:** [o que o usuário resolve nesta tela]
- **Informações exibidas:**
  - [dado 1]
  - [dado 2]
  - [dado 3]
- **Ações disponíveis:**
  - Primária: [ação principal — botão mais visível]
  - Secundárias: [outras ações]
  - Destrutivas: [cancelar, excluir — com confirmação]
- **Filtros/buscas:** [se aplicável]
- **Vem de:** [tela de origem]
- **Vai para:** [telas de destino possíveis]
- **Estados da tela:**
  - Vazio (sem dados): [o que mostrar]
  - Com dados: [comportamento normal]
  - Loading: [feedback de carregamento]
  - Erro: [mensagem e opção de retry]

---

**Tela: [Próxima tela]**
[idem]

---

## Fluxos críticos

### Fluxo: [Nome do fluxo]
**Persona:** [quem executa]
**Frequência:** [diário / semanal / ocasional]
**Importância:** [crítico / importante / secundário]

```
1. Usuário está em [tela]
2. [ação do usuário]
3. Sistema [resposta imediata]
4. Usuário [próxima ação]
5. Sistema [resultado]
6. Usuário vê [estado final]
```

**Fluxo de erro:**
- Se [condição de erro]: [mensagem em linguagem humana] + [opção de recuperação]

**Fluxo alternativo:**
- Se [condição alternativa]: [desvio do fluxo principal]

---

### Fluxo: [Próximo fluxo]
[idem]
