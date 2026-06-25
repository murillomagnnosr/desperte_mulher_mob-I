# Desperte Mulher — Reformulação (Projeto Final / TCC)

Reformulação completa de **design, UX/UI, arquitetura e organização de código**
do site [despertemulher.org](https://despertemulher.org/) — uma plataforma
gratuita e anônima de **análise de risco para mulheres em situação de violência
doméstica** (foco no Tocantins).

> **Premissa do projeto:** preservar 100% da **lógica de negócio** (perguntas,
> pontuação, formulários e encaminhamentos) e modernizar tudo o que é forma.

## 1. Descrição

O sistema permite que uma mulher avalie, de forma **anônima e gratuita**, seu
nível de risco respondendo a um questionário; recebe uma **classificação**
(Muito Baixo → Extremo) e **encaminhamentos** para a rede de apoio. Inclui
**denúncia anônima**, conteúdo institucional e uma **área profissional
(Acolhe)** protegida por autenticação.

## 2. Tecnologias

| Camada | Tecnologias |
|--------|-------------|
| Frontend | Flutter · Dart · BLoC/Cubit · GoRouter · Dio · GetIt · Material 3 · google_fonts · responsive_framework · screenutil |
| Backend | Node.js · Express · JWT · BCrypt · Zod · Helmet · PostgreSQL (pg) |
| Arquitetura | Clean Architecture · SOLID · Repository Pattern · Injeção de Dependência · Modularização |
| Deploy | Vercel/Firebase (web) · Render/Railway (API) · Supabase (DB) |

## 3. Arquitetura

Flutter (Web+Mobile) → API REST (Express) → PostgreSQL. No frontend,
**Clean Architecture** por módulo (Presentation/Domain/Data); no backend,
camadas (Routes → Middlewares → Controllers → Services → Repositories).
Detalhes e diagramas em [docs/03-arquitetura.md](docs/03-arquitetura.md).

## 4. Instalação

```bash
# Pré-requisitos: Flutter 3.27+, Node 18+, PostgreSQL (ou Supabase)
git clone <repo> && cd desperte-mulher

# Frontend
cd frontend && flutter pub get && cd ..

# Backend
cd backend && npm install && cp .env.example .env   # ajuste .env
```

## 5. Execução

```bash
# Frontend (mock, sem backend)
cd frontend
flutter run -d chrome

# Frontend consumindo a API real
flutter run -d chrome --dart-define=ENV=development --dart-define=USE_MOCK=false

# Backend
cd backend
npm run migrate && npm run seed   # precisa de PostgreSQL
npm run dev                       # http://localhost:3333

# Testes
cd frontend && flutter test       # 6 testes
cd backend  && npm test
```

## 6. Deploy

Vercel/Firebase (web) · Render/Railway (API) · Supabase (banco). Passo a passo
em [docs/16-deploy.md](docs/16-deploy.md).

## 7. Estrutura de pastas

```text
desperte-mulher/
├── docs/        # documentação acadêmica (etapas 1–17)
├── frontend/    # app Flutter (lib/core, lib/modules, lib/shared)
└── backend/     # API Express (src/{routes,controllers,services,repositories,middlewares,database})
```

Detalhe do frontend em [docs/04-estrutura-flutter.md](docs/04-estrutura-flutter.md).

## 8. Fluxo do sistema

`Home → (Termos) → Questionário → Resultado → Rede de apoio`, e
`Login do Acolhe → Painel` (protegido). Fluxo técnico e sequência em
[docs/12-integracao.md](docs/12-integracao.md).

## 9. Documentação (por etapa)

| Etapa | Documento |
|------|-----------|
| 01 | [Engenharia reversa](docs/01-engenharia-reversa.md) |
| 02 | [Mockups e design](docs/02-mockups.md) |
| 03 | [Arquitetura](docs/03-arquitetura.md) |
| 04 | [Estrutura Flutter](docs/04-estrutura-flutter.md) |
| 10 | [Backend (API)](docs/10-backend.md) |
| 11 | [Banco de dados (MER/DER)](docs/11-banco-de-dados.md) |
| 12 | [Integração Flutter↔API](docs/12-integracao.md) |
| 13 | [Responsividade](docs/13-responsividade.md) |
| 15 | [Testes](docs/15-testes.md) |
| 16 | [Deploy](docs/16-deploy.md) |
| 17 | [Roteiro de apresentação (banca)](docs/17-roteiro-apresentacao.md) |
| — | [Progresso das 17 etapas](docs/PROGRESSO.md) |

## 10. Conclusão

O projeto entrega um sistema **profissional, limpo, testável e responsivo**,
que moderniza a experiência sem alterar a lógica que protege vidas. A
arquitetura (Clean Architecture + SOLID) garante manutenibilidade e evolução —
trocar o questionário pelo instrumento validado, ligar a API ou publicar é
direto, sem reescrever telas ou regras.

## Tema visual

Híbrido **Moderno/Feminino + Institucional**: violeta `#6A2C8C` (acolhimento) +
teal `#0E6E7D` (confiança) + coral `#F2685B` (CTA), Poppins + Inter, acessível
(WCAG AA). Tokens em `frontend/lib/core/theme/`.

---
*Projeto acadêmico (TCC / Programação Mobile). Baseado no domínio público de
despertemulher.org; conteúdo sensível tratado com responsabilidade.*
