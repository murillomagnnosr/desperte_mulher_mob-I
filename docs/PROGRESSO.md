# Progresso — 17 Etapas

| Etapa | Descrição | Status |
|-------|-----------|--------|
| 1 | Engenharia reversa do site | ✅ Concluída |
| 2 | Propostas de redesign (3 mockups) | ✅ Concluída |
| 3 | Definição da arquitetura (diagramas) | ✅ Concluída |
| 4 | Estrutura de pastas Flutter | ✅ Concluída |
| 5 | pubspec.yaml | ✅ Concluída |
| 6 | Design System (theme/) | ✅ Concluída |
| 7 | Navegação (GoRouter) | ✅ Concluída |
| 8 | Telas (todas as páginas) | ✅ Concluída — 13 telas, `flutter analyze` limpo |
| 9 | Componentes reutilizáveis | ✅ Concluída — Navbar/Footer/Drawer/Button/Card/TextField/Dropdown/Loading/Error/EmptyState/Shell/Container |
| 10 | Backend (Node/Express/JWT) | ✅ Concluída — API sobe, /health 200, rotas validadas |
| 11 | Banco de dados (MER/DER/DDL) | ✅ Concluída — schema.sql + DER + migrate + seed |
| 12 | Integração Flutter + API | ✅ Concluída — interruptor mock↔API + fluxo documentado |
| 13 | Responsividade | ✅ Concluída — ResponsiveFramework + ScreenUtil + Wrap/LayoutBuilder |
| 14 | Segurança | ✅ Concluída — JWT/refresh, BCrypt, Helmet, CORS, rate-limit, Zod, SQL param, auditoria |
| 15 | Testes | ✅ Base — 6 testes verdes (RiskCalculator + RiskLevel); estrutura p/ widget/integração/backend |
| 16 | Deploy | ✅ Concluída — guia Vercel/Firebase + Render/Railway + Supabase |
| 17 | Documentação + roteiro de banca | ✅ Concluída — README completo + roteiro de 15 min |

## Entregue nesta fase (fundação do frontend)

- Árvore de diretórios completa (frontend + backend + docs).
- Design System híbrido: `app_colors`, `app_typography`, `app_spacing`,
  `app_border_radius`, `app_shadows`, `app_theme`.
- Navegação GoRouter com todas as rotas + guard de rotas protegidas + 404.
- Infra: `AppConfig`, `DioClient` (JWT), `Failures`, DI (GetIt).
- `main.dart` / `app.dart` (Material 3 + ScreenUtil + ResponsiveFramework).
- **HomePage** implementada no tema híbrido (responsiva).
- Docs das etapas 1–4.

## Etapa 8 — entregue até agora (núcleo Análise de Risco)

Módulo `modules/analise/` completo em Clean Architecture + BLoC:
- **domain:** `RiskLevel`, `Question`/`AnswerOption`/`RiskCategory`, `RiskResult`,
  `RiskCalculator` (regra de cálculo pura), interface do repositório, UseCases
  `GetQuestions` e `SubmitAssessment`.
- **data:** `QuestionModel` (DTO), datasource local (mock + cálculo) e remoto
  (API, pronto p/ Etapa 12), `AnaliseRepositoryImpl` (mapeia exceções→Failures).
- **presentation:** `AnaliseCubit` + `AnaliseState`, `PerguntasPage` (wizard com
  progresso e validação) e `ResultadoPage` (medidor, quebra por categoria,
  encaminhamentos, banner de urgência).
- DI: `registerAnaliseModule` ligado ao container; rotas `perguntas`/`resultado`
  agora reais; CTA da Home navega para o fluxo.

> Tipo `Result<T>` (Ok/Err) criado em `core/utils/` para erro explícito sem dartz.

## Etapa 8 — concluída (todas as telas)

13 telas, `flutter analyze` **sem nenhum problema**:
Home · Sobre · Apoios · Observatório · Contato · Termos · Análise (info) ·
Perguntas · Resultado · Denúncia · Login · Cadastro · Painel Acolhe · Perfil ·
Configurações.

- **Sessão:** `SessionController` (ChangeNotifier) + `refreshListenable` no
  GoRouter → login/logout reavaliam os redirects (área Acolhe protegida).
- **Componentes compartilhados (adianta a Etapa 9):** `CustomNavbar`,
  `CustomFooter`, `ContentContainer`, `AppShell`, `CustomTextField`,
  `CustomDropdownField`.
- Formulários com validação (`Form`/`GlobalKey`): Contato, Login, Cadastro,
  Perfil, Denúncia.

## Ambiente

Flutter SDK instalado em `C:\src\flutter` (PATH do usuário atualizado).
Plataforma **web** habilitada. Validações executadas: `flutter analyze` (limpo).

## Próximo

Etapa 9 (formalizar componentes restantes: CustomButton, CustomCard,
CustomDrawer, Loading/Error/EmptyState) e Etapas 10–11 (backend + banco).
