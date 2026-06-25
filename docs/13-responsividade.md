# Etapa 13 — Responsividade

O app é responsivo a partir de um único código (Web, desktop, tablet e mobile).
Combinamos quatro mecanismos, cada um no seu papel:

## 1. ResponsiveFramework (breakpoints globais)

Em [`app.dart`](../frontend/lib/app.dart), `ResponsiveBreakpoints.builder`
classifica o dispositivo:

```dart
breakpoints: const [
  Breakpoint(start: 0,    end: 600,      name: MOBILE),
  Breakpoint(start: 601,  end: 1024,     name: TABLET),
  Breakpoint(start: 1025, end: infinity, name: DESKTOP),
]
```

Consultado nos widgets, ex. na navbar:
`ResponsiveBreakpoints.of(context).smallerThan(TABLET)` → mostra o menu (drawer)
em vez dos links.

## 2. flutter_screenutil (escala fina)

`ScreenUtilInit(designSize: 390x844, minTextAdapt: true)` adapta tamanhos ao
DPI/tamanho da tela a partir de um design de referência, evitando UIs
"miniaturas" em telas grandes ou apertadas em telas pequenas.

## 3. LayoutBuilder / Wrap (layout fluido)

- `ContentContainer` limita a largura do conteúdo (`maxContentWidth = 1180`) e
  centraliza em telas largas — leitura confortável.
- Seções usam `Wrap` (selos, cards, níveis de risco): os itens refluem para a
  próxima linha conforme a largura, sem código condicional.

## 4. MediaQuery (consultas pontuais)

Disponível para ajustes finos (ex.: `MediaQuery.sizeOf(context)`,
safe areas via `SafeArea`). Usado quando se precisa do valor bruto da tela.

## Resumo de papéis

| Ferramenta | Responsabilidade |
|-----------|------------------|
| ResponsiveFramework | Classificar dispositivo (MOBILE/TABLET/DESKTOP) e autoescala |
| ScreenUtil | Escala fina de tamanhos a partir do design base |
| LayoutBuilder/Wrap | Layout fluido que reflui por largura |
| MediaQuery/SafeArea | Consultas pontuais e áreas seguras |

> Validação: `flutter build web` gerou o bundle; a navbar alterna links↔drawer
> conforme a largura; o conteúdo centraliza em telas largas.
