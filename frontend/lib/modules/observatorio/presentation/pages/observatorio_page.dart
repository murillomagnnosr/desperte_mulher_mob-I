import 'package:flutter/material.dart';

import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "Observatório" — indicadores de violência (dados ILUSTRATIVOS).
///
/// Na Etapa 12 estes números virão da API (`/observatory/stats`). Aqui são
/// estáticos apenas para demonstrar o layout.
class ObservatorioPage extends StatelessWidget {
  const ObservatorioPage({super.key});

  static const _indicadores = <(String, String, IconData)>[
    ('Denúncias registradas', '1.248', Icons.report_outlined),
    ('Análises realizadas', '3.572', Icons.fact_check_outlined),
    ('Casos de risco alto/extremo', '21%', Icons.priority_high_rounded),
    ('Encaminhamentos à rede', '894', Icons.diversity_3_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Observatório da Violência',
                style: theme.textTheme.displaySmall,),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Indicadores agregados e anônimos que apoiam políticas públicas '
              'de enfrentamento à violência contra a mulher.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final (label, valor, icon) in _indicadores)
                  Container(
                    width: 260,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: const BoxDecoration(
                      gradient: AppColors.heroGradient,
                      borderRadius: AppRadius.brLg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon, color: Colors.white70),
                        const SizedBox(height: AppSpacing.sm),
                        Text(valor,
                            style: theme.textTheme.displaySmall
                                ?.copyWith(color: Colors.white),),
                        Text(label,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white70),),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text('* Dados ilustrativos para fins de demonstração acadêmica.',
                style: theme.textTheme.bodySmall,),
          ],
        ),
      ),
    );
  }
}
