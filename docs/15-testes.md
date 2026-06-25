# Etapa 15 — Testes

## Pirâmide de testes adotada

```
        ▲  E2E / Integração (poucos, caros)
       ▲▲  Widget tests (médios)
      ▲▲▲  Unitários (muitos, baratos) ← base
```

A Clean Architecture favorece a base da pirâmide: como o **domínio é Dart puro**
(sem Flutter/HTTP), as regras de negócio são testáveis de forma rápida e isolada.

## Frontend (Flutter)

| Tipo | Arquivo | Cobre |
|------|---------|-------|
| Unitário | `test/unit/risk_calculator_test.dart` | Cálculo de risco: 0%/50%/100%, faixas e quebra por categoria |
| Unitário | `test/widget_test.dart` | `RiskLevel.fromPercent` (5 faixas) e urgência |

Rodar:

```bash
cd frontend
flutter test            # ✓ 6 testes passando
```

**Próximos** (estrutura pronta em `test/widget` e `integration_test/`):
- *Widget test* da `PerguntasPage` (responder e avançar habilita o botão).
- *Cubit test* (`bloc_test`) do `AnaliseCubit` (load → ready → success).
- *Integration test* do fluxo Home → Questionário → Resultado.

Mocks: `mocktail`; testes de Cubit: `bloc_test` (já em `dev_dependencies`).

## Backend (Node)

Estrutura em `backend/tests/` (`unit`, `integration`). Ferramentas: `jest` +
`supertest`.

**Planejados:**
- Unit: `answer.service` (cálculo de risco — paridade com o frontend).
- Unit: `auth.service` (hash/compare, emissão de tokens) com repositório mockado.
- Integration: `POST /api/v1/answers` e `POST /api/v1/auth/login` via `supertest`.

Rodar:

```bash
cd backend
npm test
```

## Estratégia

- Testar **regras** (domínio/services) antes de UI — maior retorno por esforço.
- Em verde no CI antes de qualquer deploy (Etapa 16).
