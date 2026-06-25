# Etapa 3 — Arquitetura do Sistema

## 3.1 Macro Arquitetura

Aplicação cliente Flutter (Web + Mobile a partir de um único código) consumindo
uma API REST em Node.js/Express, com PostgreSQL como banco relacional.

```mermaid
flowchart LR
    subgraph Cliente["Cliente (Flutter — código único)"]
        WEB["Flutter Web<br/>(Vercel/Firebase)"]
        MOB["Flutter Mobile<br/>(Android/iOS)"]
    end

    subgraph API["Backend — API REST (Render/Railway)"]
        EXP["Node.js + Express<br/>JWT · BCrypt · Validação"]
    end

    DB[("PostgreSQL<br/>(Supabase)")]

    WEB -- "HTTPS / JSON" --> EXP
    MOB -- "HTTPS / JSON" --> EXP
    EXP -- "SQL (pool)" --> DB
```

| Camada | Tecnologia | Hospedagem |
|--------|-----------|------------|
| Frontend Web | Flutter Web | Vercel / Firebase Hosting |
| Frontend Mobile | Flutter (APK/AAB) | Google Play (build) |
| Backend | Node.js + Express | Render / Railway |
| Banco | PostgreSQL | Supabase |

## 3.2 Micro Arquitetura — Frontend (Clean Architecture)

Cada módulo (`home`, `analise`, `authentication`, ...) é dividido em três
camadas. A dependência aponta **sempre para dentro** (Presentation → Domain ←
Data): o Domínio não conhece Flutter nem Dio.

```mermaid
flowchart TD
    subgraph Presentation
        UI[Pages / Widgets]
        CUBIT[Cubit / Bloc<br/>State]
    end
    subgraph Domain
        UC[UseCases]
        ENT[Entities]
        IREPO[Repository Interfaces]
    end
    subgraph Data
        REPO[Repository Impl]
        DS[DataSources<br/>remote/local]
        MODEL[Models / DTOs]
    end

    UI --> CUBIT --> UC --> IREPO
    REPO -. implementa .-> IREPO
    UC --> ENT
    REPO --> DS --> MODEL
    MODEL -. mapeia .-> ENT
```

**Por quê?** Testabilidade (o Domínio é Dart puro, testável sem device),
substituibilidade (trocar Dio por outro HTTP sem tocar em regras) e clareza para
a banca. Atende SOLID — em especial **D** (inversão: UseCases dependem de
interfaces) e **S** (cada classe, uma responsabilidade).

## 3.3 Micro Arquitetura — Backend (camadas)

```mermaid
flowchart LR
    RT[Routes] --> MW[Middlewares<br/>auth/validate/errors]
    MW --> CT[Controllers]
    CT --> SV[Services<br/>regras de negócio]
    SV --> RP[Repositories]
    RP --> DB[(PostgreSQL)]
    SV -.-> MD[Models/Entities]
```

- **Routes:** declaram endpoints e ligam ao controller.
- **Middlewares:** autenticação JWT, validação de entrada, tratamento de erros.
- **Controllers:** orquestram req/res; sem regra de negócio.
- **Services:** regras de negócio (ex.: cálculo de risco, emissão de token).
- **Repositories:** acesso a dados (SQL parametrizado).
- **Models:** representação das entidades.

## 3.4 Banco de Dados (visão preliminar)

Detalhado na Etapa 11 (MER/DER + DDL). Visão de entidades:

```mermaid
erDiagram
    ROLES ||--o{ USERS : possui
    USERS ||--o{ RESULTS : registra
    QUESTIONS ||--o{ ANSWERS : recebe
    RESULTS ||--o{ ANSWERS : agrupa
    USERS ||--o{ AUDIT_LOGS : gera
    CONTACTS }o--|| USERS : "atendido por"
```

## 3.5 Fluxo ponta a ponta (Análise de Risco)

```mermaid
sequenceDiagram
    actor U as Usuária
    participant F as Flutter (Cubit)
    participant A as API (Express)
    participant D as PostgreSQL
    U->>F: Responde perguntas
    F->>A: POST /answers (respostas)
    A->>A: Service calcula pontuação e faixa
    A->>D: INSERT result + answers
    A-->>F: 201 { riskPercent, level, encaminhamentos }
    F-->>U: Tela de Resultado + rede de apoio
```
