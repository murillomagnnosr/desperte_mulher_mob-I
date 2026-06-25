# Etapa 11 — Banco de Dados (MER / DER)

DDL completo em [`backend/src/database/schema.sql`](../backend/src/database/schema.sql).
Migração: `npm run migrate` · Seed: `npm run seed`.

## DER (Diagrama Entidade-Relacionamento)

```mermaid
erDiagram
    ROLES ||--o{ USERS : "1:N papel"
    USERS ||--o{ RESULTS : "registra (opcional)"
    USERS ||--o{ CONTACTS : "atende"
    USERS ||--o{ AUDIT_LOGS : "gera"
    QUESTIONS ||--o{ ANSWER_OPTIONS : "possui"
    QUESTIONS ||--o{ ANSWERS : "respondida em"
    ANSWER_OPTIONS ||--o{ ANSWERS : "escolhida em"
    RESULTS ||--o{ ANSWERS : "agrupa"

    ROLES {
      serial id PK
      varchar name UK
      varchar description
    }
    USERS {
      uuid id PK
      int role_id FK
      varchar name
      varchar email UK
      varchar password_hash
      bool is_active
    }
    QUESTIONS {
      uuid id PK
      enum category
      text text
      int position
    }
    ANSWER_OPTIONS {
      uuid id PK
      uuid question_id FK
      varchar label
      numeric score
    }
    RESULTS {
      uuid id PK
      uuid user_id FK "NULL = anônimo"
      numeric percent
      enum level
      timestamptz created_at
    }
    ANSWERS {
      uuid id PK
      uuid result_id FK
      uuid question_id FK
      uuid answer_option_id FK
      numeric score
    }
    REPORTS {
      uuid id PK
      varchar violence_type
      varchar municipality
      text description
    }
    CONTACTS {
      uuid id PK
      varchar name
      varchar email
      text message
      uuid handled_by FK
    }
    AUDIT_LOGS {
      uuid id PK
      uuid user_id FK
      varchar action
      varchar entity
    }
```

## Relacionamentos (explicação)

| Relação | Cardinalidade | Justificativa |
|--------|----------------|---------------|
| ROLES → USERS | 1:N | Cada profissional tem um papel; um papel se aplica a vários. |
| QUESTIONS → ANSWER_OPTIONS | 1:N | Cada pergunta tem várias opções com peso (score). |
| RESULTS → ANSWERS | 1:N | Uma análise concluída agrupa as respostas dadas. |
| QUESTIONS/ANSWER_OPTIONS → ANSWERS | 1:N | Cada resposta referencia a pergunta e a opção escolhida. |
| USERS → RESULTS | 1:N (opcional) | `user_id` é **NULL** em análises anônimas — preserva o anonimato do site. |
| REPORTS | — | Denúncia **anônima**: sem FK para usuário, por princípio. |
| USERS → CONTACTS | 1:N (opcional) | `handled_by` marca quem tratou a mensagem. |
| USERS → AUDIT_LOGS | 1:N | Trilha de auditoria de ações sensíveis. |

## Decisões de modelagem

- **UUID** como PK das entidades sensíveis (results, reports) — IDs não
  sequenciais dificultam enumeração/inferência.
- **Tipos ENUM** (`risk_level`, `risk_category`) garantem integridade da
  classificação no nível do banco.
- **`ON DELETE CASCADE`** em options/answers (dependem do pai) e
  **`SET NULL`** onde o histórico deve sobreviver (results/contacts/audit).
- **Anonimato**: `results.user_id` e a tabela `reports` não exigem identidade.
- **Senhas**: somente `password_hash` (BCrypt) — nunca texto puro (Etapa 14).
- **Índices** nas colunas de busca (email, FKs, datas, município).
