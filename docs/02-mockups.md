# Etapa 2 — Propostas de Redesign (3 Mockups)

Três direções visuais foram exploradas. Todas preservam o conteúdo e a lógica
do site; mudam linguagem visual, hierarquia e tom.

---

## Mockup 01 — Moderno · Minimalista · Feminino

- **Conceito:** acolhimento e dignidade. O foco é a usuária em situação de
  vulnerabilidade — clareza, calma e segurança emocional acima de tudo.
- **Cores:** Roxo/violeta `#6A2C8C` (primária), Coral `#F2685B` (acento/CTA),
  branco quente `#FFFBFE`, neutros suaves.
- **Fontes:** Poppins (títulos, humanista e calorosa) + Inter (corpo, legível).
- **Layout:** muito espaço em branco, cantos arredondados (16–24px), cards
  leves, hero com gradiente suave, microinterações discretas.
- **Componentes:** botões grandes (52px) e acessíveis, chips de contato,
  cartões de "por que importa" com ícones de linha.
- **Organização:** vertical, scroll guiado, CTA sempre visível.

## Mockup 02 — Institucional · Profissional · ONG

- **Conceito:** credibilidade e parceria governamental. Transmite a
  oficialidade da Secretaria da Mulher e dos órgãos parceiros.
- **Cores:** Azul-marinho `#0D47A1`, Teal `#00695C` (segurança), cinzas frios
  `#F5F7FA`. Tons sóbrios e de alto contraste.
- **Fontes:** Source Sans 3 / Roboto — neutras e formais.
- **Layout:** estrutura em grade, seções bem delimitadas, faixa de parceiros,
  números/indicadores em destaque.
- **Componentes:** cabeçalho fixo com selo institucional, tabelas e cards de
  dados (observatório), rodapé com créditos e logos.
- **Organização:** informacional, hierárquica, "site de instituição".

## Mockup 03 — Plataforma Digital · Startup · Comunidade

- **Conceito:** produto digital moderno, sensação de "app de comunidade".
- **Cores:** gradiente Indigo → Magenta, suporte a **dark mode**, acentos vivos.
- **Fontes:** Space Grotesk (geométrica) + Inter.
- **Layout:** cards arrojados, ilustrações, dashboards, animações.
- **Componentes:** bottom navigation, dashboards, badges, estados vazios
  ilustrados.
- **Organização:** orientada a tarefas, app-first.

---

## ✅ Decisão: HÍBRIDO Mockup 01 + 02 (implementado)

O público duplo justifica a fusão:

| Necessidade | Vem de |
|-------------|--------|
| Segurança emocional, acolhimento, clareza para a **usuária em crise** | Mockup 01 |
| Confiança, sobriedade e oficialidade para **parceiros públicos** e área Acolhe | Mockup 02 |

**Design system resultante** (ver `frontend/lib/core/theme/`):

- **Primária:** Violeta `#6A2C8C` (acolhimento/dignidade — Mockup 01).
- **Secundária:** Teal/azul `#0E6E7D` (confiança institucional — Mockup 02).
- **Acento:** Coral `#F2685B` (CTA calorosa).
- **Tipografia:** Poppins (títulos) + Inter (corpo).
- **Tom:** calmo, acessível (contraste WCAG AA), sóbrio e confiável.

> As cores de risco (verde → vermelho) são **semânticas e fixas**, independentes
> do tema, pois carregam significado de negócio.
