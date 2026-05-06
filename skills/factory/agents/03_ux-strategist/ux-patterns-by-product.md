# Padrões de UX por Tipo de Produto

Referência de padrões que o mercado consolidou por categoria.
Use para validar decisões e identificar gaps no projeto.

---

## SaaS B2B — Padrões consolidados

### Navegação
- Sidebar fixa no desktop com seções colapsáveis
- Breadcrumb em telas de detalhe
- Troca de contexto (empresa/workspace) no topo da sidebar
- Busca global acessível por atalho (Ctrl+K ou Cmd+K)

### Dashboard
- Máximo 5-6 métricas principais visíveis sem scroll
- Cards clicáveis que levam ao detalhe
- Indicadores de tendência (subindo/descendo vs período anterior)
- Alertas de ação necessária em destaque (vencidos, pendentes)
- Período selecionável (hoje / semana / mês / personalizado)

### Listagens
- Filtros no topo, sempre visíveis
- Ordenação por coluna clicável
- Paginação ou scroll infinito (scroll infinito para listas longas)
- Estado vazio com CTA para criar o primeiro item
- Seleção múltipla para ações em lote
- Busca inline rápida
- Exportação CSV acessível na listagem

### Formulários
- Label acima do campo, nunca placeholder como label
- Validação inline ao sair do campo (não só no submit)
- Erro em vermelho com mensagem específica abaixo do campo
- Campos agrupados por contexto (dados básicos / detalhes / configurações)
- Botão primário no final do formulário e também fixo no topo em formulários longos
- Auto-save em formulários longos com indicador de "salvo"

### Ações destrutivas
- Sempre pede confirmação
- Modal de confirmação descreve exatamente o que vai acontecer
- Botão de confirmação é vermelho e exige texto digitado para ações irreversíveis graves

### Feedback
- Toast de sucesso aparece no canto superior direito por 3-5 segundos
- Toast de erro permanece até ser fechado manualmente
- Loading spinner para ações que demoram mais de 500ms
- Skeleton loading para carregamento de listas
- Progresso visual para uploads e processos longos

---

## SaaS B2C — Padrões consolidados

### Onboarding
- Máximo 3 passos para chegar ao primeiro valor
- Progresso visual do onboarding sempre visível
- Permitir pular etapas opcionais
- Primeiro valor entregue antes de pedir dados completos

### Navegação mobile
- Bottom navigation bar com 4-5 itens máximo
- Ação principal em botão flutuante (FAB) centralizado
- Gestos de swipe para ações comuns
- Pull to refresh em listagens

---

## App Mobile — Padrões consolidados

### Thumb zone
- Ações principais na metade inferior da tela (alcance do polegar)
- Ações destrutivas fora do alcance fácil do polegar
- Botões com área de toque mínima de 44x44pt

### Performance percebida
- Skeleton loading em vez de spinner para listas
- Otimistic UI — mostrar resultado antes de confirmar com servidor
- Cache local para dados que raramente mudam

### Gestos
- Swipe para esquerda: ação rápida (excluir, arquivar)
- Swipe para direita: ação positiva (concluir, aprovar)
- Pull to refresh: atualizar lista
- Long press: menu de contexto

---

## Financeiro — Padrões específicos

### Listagem de lançamentos
- Ordenação padrão: vencimento ascendente (mais urgente primeiro)
- Status visualmente distinto: vencido (vermelho), vence hoje (laranja), em dia (cinza/verde)
- Valor sempre alinhado à direita
- Filtro rápido: "Em aberto" / "Pagos" / "Todos"
- Agrupamento por data ou por status

### Baixa de título
- Formulário de baixa em modal ou drawer lateral, não nova tela
- Campo de valor pré-preenchido com saldo restante
- Data de pagamento pré-preenchida com hoje
- Conta bancária pré-selecionada com a última usada
- Confirmação rápida — não mais de 3 campos obrigatórios

### Dashboard financeiro
- 4-6 cards: vencido / vence hoje / a pagar no mês / a receber no mês
- Saldo bancário consolidado em destaque
- Gráfico de fluxo de caixa simples (opcional na fase 1)
- Lista das próximas contas a vencer abaixo dos cards

### Relatórios
- Período selecionável sempre visível
- Exportar CSV/PDF acessível no topo do relatório
- Totalizadores fixos no topo enquanto scrolla

---

## E-commerce — Padrões específicos

### Catálogo
- Grid de produtos com imagem, nome e preço
- Filtros colapsáveis na lateral (desktop) ou drawer (mobile)
- Ordenação: relevância, preço, avaliação, novidade
- Produto sem estoque visível mas desabilitado para compra

### Checkout
- Máximo 3 etapas: carrinho → dados → pagamento
- Resumo do pedido sempre visível
- Progresso do checkout visível no topo
- Não obrigar cadastro para comprar (guest checkout)

---

## Alertas de UX que sempre verificar

Independente do tipo de produto, sempre alerte o Owner se:

- [ ] Fluxo principal tem mais de 5 passos — pode simplificar?
- [ ] Formulário tem mais de 8 campos visíveis — pode agrupar ou esconder opcionais?
- [ ] Ação destrutiva não tem confirmação
- [ ] Estado vazio de lista não tem call to action
- [ ] Erro não tem mensagem em linguagem humana
- [ ] Ação assíncrona não tem feedback de loading
- [ ] Funcionalidade crítica está enterrada em 3+ cliques
- [ ] Sistema não lembra preferências do usuário (filtros, ordenação, último contexto)
