# Etapa 10 — Backend (API REST)

Node.js + Express, em camadas (Routes → Middlewares → Controllers → Services →
Repositories → PostgreSQL). ES Modules. Base: `/api/v1`.

## Como rodar

```bash
cd backend
cp .env.example .env        # ajuste DATABASE_URL e os segredos JWT
npm install
npm run migrate             # cria as tabelas (precisa de PostgreSQL)
npm run seed                # popula papéis, admin e questionário
npm run dev                 # http://localhost:3333
```

> Validado sem banco: `GET /health → 200` e o app carrega todas as rotas
> (`node -e "import('./src/app.js')"`).

## Endpoints

| Método | Rota | Acesso | Descrição |
|--------|------|--------|-----------|
| GET | `/health` | público | Status do serviço |
| POST | `/api/v1/auth/register` | público | Cadastro de profissional |
| POST | `/api/v1/auth/login` | público | Login → access + refresh token |
| POST | `/api/v1/auth/refresh` | público | Renova o access token |
| GET | `/api/v1/auth/me` | JWT | Dados do usuário logado |
| GET | `/api/v1/users` | JWT + admin | Lista usuários |
| GET | `/api/v1/questions` | público | Questionário (perguntas + opções) |
| POST | `/api/v1/answers` | público (anônimo) | Submete respostas → resultado classificado |
| POST | `/api/v1/reports` | público (anônimo) | Cria denúncia anônima |
| GET | `/api/v1/reports` | JWT + admin/atendente | Lista denúncias |
| POST | `/api/v1/contacts` | público | Mensagem de contato |

## Camadas e responsabilidades

- **Routes** — endpoints + middlewares (validate/authenticate/authorize).
- **Middlewares** — `validate` (Zod), `authenticate` (JWT), `authorize` (RBAC),
  `errorHandler` (respostas de erro consistentes), `notFound`.
- **Controllers** — orquestram req/res (sem regra de negócio).
- **Services** — regra de negócio (ex.: `answer.service` calcula o risco com a
  MESMA lógica do app: soma ponderada → 0..100% → 5 faixas).
- **Repositories** — SQL parametrizado (anti-SQL-Injection); `result.repository`
  grava resultado + respostas em transação.

## Segurança (Etapa 14, já aplicada aqui)

- **JWT** (access 15m + refresh 7d) e **BCrypt** (hash de senha, custo 10).
- **Validação/sanitização** de entrada com Zod (422 com mapa de erros).
- **Helmet** (cabeçalhos seguros), **CORS** por origem, **rate limiting**.
- **SQL parametrizado** em 100% das queries.
- **Auditoria** (`audit_logs`) de login e criação de denúncia.
