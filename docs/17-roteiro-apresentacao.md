# Etapa 17 — Roteiro de Apresentação (Banca · 15 minutos)

Sugestão de ritmo e fala para a defesa. Ajuste ao seu estilo.

---

## 0 – 1 min · Abertura
- "Boa tarde. Vou apresentar a reformulação do **Desperte Mulher**, uma
  plataforma de **análise de risco para mulheres em situação de violência
  doméstica**, com foco no Tocantins."
- Deixe claro o recorte: **reformulei design, UX e arquitetura, preservando
  100% da lógica de negócio** (perguntas, pontuação, formulários, fluxos).

## 1 – 3 min · Problema
- Violência doméstica é subnotificada; muitas vítimas não percebem o nível de
  risco em que estão.
- O site original cumpre a função, mas há espaço para **modernizar a
  experiência** e **profissionalizar a arquitetura** (manutenibilidade, testes,
  deploy).
- Mostre a tabela da [engenharia reversa](01-engenharia-reversa.md): páginas,
  formulários e o núcleo (questionário → classificação de risco).

## 3 – 5 min · Solução proposta
- App único (Flutter) para **Web e Mobile**, mais uma **API REST** (Node) e
  **PostgreSQL**.
- Tema **híbrido** (acolhedor + institucional) — justifique pelo público duplo:
  a usuária em crise e os parceiros públicos. Mostre os 3 mockups e a escolha
  ([mockups](02-mockups.md)).

## 5 – 8 min · Arquitetura (o coração da defesa)
- Macro: Flutter → API REST → PostgreSQL ([diagramas](03-arquitetura.md)).
- Micro (frontend): **Clean Architecture** — Presentation / Domain / Data; a
  dependência aponta para dentro; o domínio é Dart puro.
- **SOLID** na prática: UseCases dependem de **interfaces** (D); cada classe tem
  uma responsabilidade (S). Repository Pattern + Injeção de Dependência (GetIt).
- Mostre a árvore `modules/analise/` (domain/data/presentation).

## 8 – 10 min · Backend, Banco e Segurança
- Backend em camadas: Routes → Middlewares → Controllers → Services →
  Repositories ([backend](10-backend.md)).
- **Segurança** (Etapa 14): JWT + refresh, BCrypt, Helmet, CORS, rate limit,
  validação (Zod), **SQL parametrizado** e auditoria.
- Banco: mostre o **DER** ([banco](11-banco-de-dados.md)) e destaque o
  **anonimato** (results sem usuário; reports sem identidade).

## 10 – 13 min · Demonstração ao vivo
1. Home → "Quero entender meu risco" → **questionário** (responder, avançar).
2. **Resultado**: medidor %, faixa, quebra por categoria, encaminhamentos
   (banner de urgência se Alto/Extremo).
3. **Login do Acolhe** → **Painel** (rota protegida; mostre o redirect quando
   sem sessão).
4. **Denúncia Anônima** (formulário com validação).
5. Cite a validação: `flutter analyze` limpo, `flutter test` verde (6),
   `flutter build web` ok, API respondendo (`/health`).
6. Mostre o **interruptor mock↔API** (`--dart-define=USE_MOCK=false`) —
   [integração](12-integracao.md).

## 13 – 14 min · Deploy
- Pipeline: Vercel/Firebase (web) · Render/Railway (API) · Supabase (banco)
  ([deploy](16-deploy.md)). HTTPS ponta a ponta, segredos por ambiente.

## 14 – 15 min · Melhorias futuras + encerramento
- Substituir o banco de perguntas pelo **instrumento científico validado**.
- i18n (PT/ES/EN), modo escuro, notificações, painel com dados reais.
- Testes de widget/integração e CI/CD; LGPD e criptografia em repouso.
- Encerramento: "O resultado é um sistema **profissional, limpo, testável e
  pronto para evoluir**, sem alterar a essência que protege vidas. Obrigado."

---

### Possíveis perguntas da banca (prepare-se)
- *Por que Clean Architecture?* Testabilidade, baixo acoplamento, troca de
  detalhes (mock↔API) sem mexer em regra/UI.
- *Como garante o anonimato?* `results.user_id` nulo e `reports` sem FK de
  usuário; nenhuma identificação é exigida.
- *Onde fica a lógica de risco?* No domínio (`RiskCalculator`) e espelhada no
  backend (`answer.service`) — coberta por testes.
- *Segurança contra SQL Injection?* Queries 100% parametrizadas.
