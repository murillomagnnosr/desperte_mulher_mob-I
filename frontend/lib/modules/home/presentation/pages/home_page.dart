import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela inicial (equivalente ao `/` do site original), no tema híbrido.
///
/// Usa o [AppShell] (navbar + rodapé compartilhados) e empilha as seções.
/// Cada seção é um widget privado e responsivo (Wrap se adapta às larguras).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        children: [
          _Hero(onStart: () => _start(context)),
          const _SelosSection(),
          const _PorQueImportaSection(),
          const _NiveisRiscoSection(),
          const _OQueAvaliamosSection(),
          const _EmergenciaSection(),
        ],
      ),
    );
  }

  // Fluxo oficial: Início -> Termos -> Questionário. Enquanto Termos é stub,
  // apontamos direto ao questionário para demonstrar o núcleo ponta a ponta.
  void _start(BuildContext context) => context.goNamed(AppRoutes.perguntasName);
}

// -----------------------------------------------------------------------------
// Hero
// -----------------------------------------------------------------------------
class _Hero extends StatelessWidget {
  const _Hero({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: ContentContainer(
        child: Column(
          children: [
            Text(
              AppStrings.tagline.toUpperCase(),
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: AppColors.accentLight, letterSpacing: 2),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppStrings.heroTitle,
              textAlign: TextAlign.center,
              style:
                  theme.textTheme.displayMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.onAccent,
                  ),
                  icon: const Icon(Icons.shield_moon_outlined),
                  label: const Text(AppStrings.ctaEntenderRisco),
                ),
                OutlinedButton(
                  onPressed: onStart,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70),
                  ),
                  child: const Text(AppStrings.ctaComoFunciona),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Selos de confiança
// -----------------------------------------------------------------------------
class _SelosSection extends StatelessWidget {
  const _SelosSection();

  static const _selos = <(IconData, String)>[
    (Icons.visibility_off_outlined, AppStrings.seloAnonimato),
    (Icons.volunteer_activism_outlined, AppStrings.seloGratuito),
    (Icons.science_outlined, AppStrings.seloCientifico),
    (Icons.support_agent_outlined, AppStrings.seloSuporte),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentContainer(
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        alignment: WrapAlignment.center,
        children: [
          for (final (icon, label) in _selos)
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.brLg,
                boxShadow: AppShadows.sm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: theme.colorScheme.secondary),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(label, style: theme.textTheme.titleSmall),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Por que é importante
// -----------------------------------------------------------------------------
class _PorQueImportaSection extends StatelessWidget {
  const _PorQueImportaSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.surfaceVariant,
      width: double.infinity,
      child: ContentContainer(
        child: Column(
          children: [
            Text('Por que é importante', style: theme.textTheme.headlineLarge),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              alignment: WrapAlignment.center,
              children: [
                for (final item in AppStrings.porQueImporta)
                  SizedBox(
                    width: 320,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                color: AppColors.secondary,),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(item,
                                  style: theme.textTheme.titleSmall,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Níveis de risco
// -----------------------------------------------------------------------------
class _NiveisRiscoSection extends StatelessWidget {
  const _NiveisRiscoSection();

  static const _niveis = <(String, double)>[
    ('Muito Baixo', 20),
    ('Baixo', 40),
    ('Moderado', 60),
    ('Alto', 80),
    ('Extremo', 100),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentContainer(
      child: Column(
        children: [
          Text('Classificação de risco', style: theme.textTheme.headlineLarge),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            alignment: WrapAlignment.center,
            children: [
              for (final (label, pct) in _niveis)
                Container(
                  width: 180,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.riskColor(pct).withValues(alpha: 0.12),
                    borderRadius: AppRadius.brLg,
                    border:
                        Border.all(color: AppColors.riskColor(pct), width: 1.2),
                  ),
                  child: Column(
                    children: [
                      Text('${pct.toInt()}%',
                          style: theme.textTheme.displaySmall
                              ?.copyWith(color: AppColors.riskColor(pct)),),
                      Text(label, style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// O que avaliamos
// -----------------------------------------------------------------------------
class _OQueAvaliamosSection extends StatelessWidget {
  const _OQueAvaliamosSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: AppColors.surfaceVariant,
      width: double.infinity,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:
                  Text('O que avaliamos', style: theme.textTheme.headlineLarge),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final item in AppStrings.oQueAvaliamos)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right_rounded,
                        color: AppColors.primary,),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                        child: Text(item, style: theme.textTheme.bodyLarge),),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Emergência
// -----------------------------------------------------------------------------
class _EmergenciaSection extends StatelessWidget {
  const _EmergenciaSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContentContainer(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.08),
          borderRadius: AppRadius.brXl,
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Text('Precisa de ajuda agora?',
                style: theme.textTheme.headlineSmall,),
            const SizedBox(height: AppSpacing.sm),
            const Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                _PhoneChip(label: 'Central da Mulher', number: '180'),
                _PhoneChip(label: 'Polícia Militar', number: '190'),
                _PhoneChip(
                    label: 'Ouvidoria da Mulher',
                    number: AppStrings.telOuvidoria,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneChip extends StatelessWidget {
  const _PhoneChip({required this.label, required this.number});
  final String label;
  final String number;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.xs,),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.brPill,
        boxShadow: AppShadows.sm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.phone_in_talk_outlined,
              color: AppColors.accentDark, size: 18,),
          const SizedBox(width: AppSpacing.xs),
          Text('$label  ', style: theme.textTheme.bodySmall),
          Text(number,
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.accentDark),),
        ],
      ),
    );
  }
}
