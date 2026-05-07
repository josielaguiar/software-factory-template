# Template de User Story

Use para TODA funcionalidade antes de passar para o Codex implementar.
Story sem critério técnico não é story — é intenção.

---

## US-[MODULO]-[NN] — [Nome descritivo]

**Como** [papel/ator]
**Quero** [ação concreta que o usuário executa]
**Para** [objetivo de negócio — resultado esperado]

---

### Contexto de negócio
[O que o usuário vê na tela. O que ele espera que aconteça.
Casos de uso do ponto de vista do negócio, não da tecnologia.]

---

### Critérios de aceite funcionais
- [ ] [comportamento observável 1 — o que o usuário vê/consegue fazer]
- [ ] [comportamento observável 2]
- [ ] [comportamento em caso de erro — o que o usuário vê quando algo dá errado]
- [ ] [comportamento de borda — casos especiais]

---

### Critérios técnicos obrigatórios

#### Isolamento de tenant
- Campo de tenant: `[campo]`
- Fonte do tenant: `[JWT / contexto / sessão]`
- Queries filtram por: `[campo]`

#### Feature flag
- Feature verificada: `[FEATURE_CODE]` (ou N/A)
- Comportamento se inativa: `403 — [mensagem]`

#### RBAC
- Papel mínimo: `[PAPEL]`
- Verificado em: `[guard / caso de uso]`
- Comportamento se insuficiente: `403 — [mensagem]`

#### Transição de estado (se aplicável)
- Estado atual válido: `[estados que permitem esta operação]`
- Estado resultante: `[estado após operação]`
- Caso de uso nomeado: `[NomeDoCasoDeUso]`
- Comportamento se estado inválido: `422 — [mensagem]`

#### Auditoria
- Ação auditada: `[CODIGO_AUDITORIA]` (ou N/A)
- Campos em `antes`: `[campos relevantes]`
- Campos em `depois`: `[campos alterados]`
- Momento: dentro da transação

#### Evento operacional
- Evento emitido: `[TIPO_EVENTO]` (ou N/A)
- Momento: após o commit
- Inclui correlation_id: sim

---

### Pré-condições
[O que precisa existir/estar configurado antes desta operação funcionar]
- [pré-condição 1]
- [pré-condição 2]

### Pós-condições
[O que deve ser verdade após a operação concluir com sucesso]
- [pós-condição 1]
- [pós-condição 2]

---

### Testes obrigatórios
- [ ] Caminho feliz — [descreva o cenário de sucesso]
- [ ] Usuário de outro tenant tentando acessar → 403
- [ ] Feature inativa → 403 (se aplicável)
- [ ] Papel insuficiente → 403
- [ ] Estado inválido → 422 (se aplicável)
- [ ] [caso de borda específico do domínio]
- [ ] [outro caso de borda]

---

### Dependências
- Depende de: [story ou entidade que precisa existir antes]
- Bloqueia: [story que depende desta]

### Complexidade
[ ] P — Pequena (endpoint simples, CRUD básico)
[ ] M — Média (lógica de negócio, múltiplas entidades)
[ ] G — Grande (integração externa, fluxo complexo)
