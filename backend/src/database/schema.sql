-- =============================================================================
-- Desperte Mulher — Schema do banco (PostgreSQL)  | Etapa 11
-- =============================================================================
-- Modelo relacional normalizado (3FN). Comentários explicam cada relacionamento.
-- Execução: `npm run migrate` (lê este arquivo) ou psql -f schema.sql.
-- =============================================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto; -- gen_random_uuid()

-- Tipos enumerados (refletem a lógica de negócio do site) ---------------------
DO $$ BEGIN
  CREATE TYPE risk_level AS ENUM
    ('muitoBaixo','baixo','moderado','alto','extremo');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE risk_category AS ENUM
    ('violencia','controle','escalada','dependentes','apoio');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- 1) ROLES — papéis de acesso da área Acolhe ----------------------------------
CREATE TABLE IF NOT EXISTS roles (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(40)  NOT NULL UNIQUE,   -- admin, atendente, parceiro
  description VARCHAR(160)
);

-- 2) USERS — profissionais da rede (1 papel : N usuários) ---------------------
CREATE TABLE IF NOT EXISTS users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  role_id       INTEGER NOT NULL REFERENCES roles(id),
  name          VARCHAR(120) NOT NULL,
  email         VARCHAR(160) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,        -- BCrypt (nunca senha em texto)
  phone         VARCHAR(20),
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3) QUESTIONS — itens do questionário de risco -------------------------------
CREATE TABLE IF NOT EXISTS questions (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category   risk_category NOT NULL,
  text       TEXT NOT NULL,
  position   INTEGER NOT NULL DEFAULT 0,      -- ordem de exibição
  is_active  BOOLEAN NOT NULL DEFAULT TRUE
);

-- 4) ANSWER_OPTIONS — opções de resposta (1 pergunta : N opções) --------------
CREATE TABLE IF NOT EXISTS answer_options (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  label       VARCHAR(120) NOT NULL,
  score       NUMERIC(5,2) NOT NULL DEFAULT 0 -- peso da opção
);

-- 5) RESULTS — uma análise concluída ------------------------------------------
-- user_id é NULL para análises ANÔNIMAS (preserva o anonimato do site).
CREATE TABLE IF NOT EXISTS results (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES users(id) ON DELETE SET NULL,
  percent    NUMERIC(5,2) NOT NULL,
  level      risk_level NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 6) ANSWERS — respostas de uma análise (1 result : N answers) ----------------
CREATE TABLE IF NOT EXISTS answers (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  result_id        UUID NOT NULL REFERENCES results(id) ON DELETE CASCADE,
  question_id      UUID NOT NULL REFERENCES questions(id),
  answer_option_id UUID NOT NULL REFERENCES answer_options(id),
  score            NUMERIC(5,2) NOT NULL
);

-- 7) REPORTS — denúncias anônimas (sem vínculo com usuário) -------------------
CREATE TABLE IF NOT EXISTS reports (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  violence_type   VARCHAR(60) NOT NULL,
  municipality    VARCHAR(80) NOT NULL,
  address         VARCHAR(200),
  reference_point VARCHAR(160),
  description     TEXT NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 8) CONTACTS — mensagens do formulário "Fale conosco" ------------------------
CREATE TABLE IF NOT EXISTS contacts (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       VARCHAR(120) NOT NULL,
  email      VARCHAR(160) NOT NULL,
  message    TEXT NOT NULL,
  handled_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 9) AUDIT_LOGS — rastreabilidade de ações sensíveis --------------------------
CREATE TABLE IF NOT EXISTS audit_logs (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES users(id) ON DELETE SET NULL,
  action     VARCHAR(60) NOT NULL,           -- LOGIN, CREATE_REPORT, ...
  entity     VARCHAR(60),
  entity_id  VARCHAR(64),
  ip_address VARCHAR(45),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Índices para consultas frequentes -------------------------------------------
CREATE INDEX IF NOT EXISTS idx_users_email        ON users(email);
CREATE INDEX IF NOT EXISTS idx_options_question   ON answer_options(question_id);
CREATE INDEX IF NOT EXISTS idx_answers_result     ON answers(result_id);
CREATE INDEX IF NOT EXISTS idx_results_created     ON results(created_at);
CREATE INDEX IF NOT EXISTS idx_reports_municipality ON reports(municipality);
CREATE INDEX IF NOT EXISTS idx_audit_user          ON audit_logs(user_id);
