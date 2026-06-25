# Etapa 4 — Estrutura de Pastas do Flutter

Organização **feature-first** (por módulo) + **Clean Architecture** (camadas
dentro de cada módulo). Evita "código espaguete": cada funcionalidade é
isolada e cada arquivo tem uma responsabilidade.

```text
frontend/
├── pubspec.yaml              # dependências e assets (Etapa 5)
├── analysis_options.yaml     # regras de lint (Clean Code)
└── lib/
    ├── main.dart             # entrypoint: binding, config, DI, runApp
    ├── app.dart              # MaterialApp.router: tema, rotas, responsividade
    │
    ├── core/                 # código transversal, sem regra de negócio
    │   ├── config/           # AppConfig (ambientes dev/staging/prod)
    │   ├── constants/        # AppStrings, AppConstants, AppAssets
    │   ├── theme/            # DESIGN SYSTEM: cores, tipografia, spacing, tema
    │   ├── di/               # injection.dart (GetIt — Service Locator)
    │   ├── network/          # DioClient, ApiEndpoints (camada HTTP)
    │   ├── routes/           # AppRoutes, AppRouter (GoRouter), NavigationService
    │   ├── error/            # Failures (erros de domínio)
    │   └── utils/            # helpers genéricos
    │
    ├── modules/              # uma pasta por FEATURE
    │   └── <feature>/
    │       ├── presentation/ # UI — depende do Domain
    │       │   ├── pages/     # telas (rotas)
    │       │   ├── widgets/   # componentes da feature
    │       │   └── cubit/     # estado (Cubit/Bloc + States)
    │       ├── domain/        # regra de negócio — Dart puro, sem Flutter
    │       │   ├── entities/      # objetos de negócio
    │       │   ├── repositories/  # INTERFACES (contratos)
    │       │   └── usecases/      # casos de uso (1 ação cada)
    │       └── data/          # implementação de acesso a dados
    │           ├── datasources/  # remote (Dio) / local (prefs)
    │           ├── models/        # DTOs (JSON) + mapeamento p/ entities
    │           └── repositories/  # IMPLEMENTA as interfaces do domain
    │
    └── shared/               # reuso entre módulos
        ├── widgets/          # CustomButton, CustomTextField, ... (Etapa 9)
        ├── extensions/       # extensions de BuildContext, String, etc.
        └── mixins/           # comportamentos reutilizáveis
```

## Função de cada pasta

| Pasta | Responsabilidade | Regra de dependência |
|-------|------------------|----------------------|
| `core/` | Infra e configuração reutilizável (tema, rede, DI, rotas) | Não depende de módulos |
| `modules/<f>/presentation` | Renderizar e reagir a estados | Depende só do `domain` |
| `modules/<f>/domain` | Regras de negócio puras | **Não depende de nada externo** |
| `modules/<f>/data` | Buscar/persistir dados; mapear DTO↔Entity | Implementa interfaces do `domain` |
| `shared/` | Widgets/utilitários comuns | Sem regra de negócio |

**Módulos previstos:** `home`, `sobre`, `apoios`, `observatorio`, `analise`
(núcleo — questionário), `resultado`, `denuncia`, `authentication`, `profile`,
`admin`, `settings`, `contato`.
