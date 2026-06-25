import 'package:flutter/material.dart';

import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "Sobre" — história, missão e fundadores do projeto.
class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  static const _fundadores = <(String, String)>[
    ('Felipe Scarpelli de Andrade', 'Polícia Federal — metodologia de risco'),
    ('David Neme Muradás', 'Polícia Civil-TO — desenvolvimento da tecnologia'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sobre o Desperte Mulher',
                style: theme.textTheme.displaySmall,),
            const SizedBox(height: AppSpacing.sm),
            Text('Conhecimento é o primeiro passo para a Vida!',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(color: AppColors.primary),),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'O projeto nasceu de um encontro, em 2024, em Brasília, entre um '
              'programador da Polícia Civil do Tocantins e um agente federal '
              'especialista em análise de risco. Em 2026, juntos, criaram esta '
              'ferramenta de avaliação de risco para mulheres em situação de '
              'violência doméstica — gratuita, anônima e baseada em metodologia '
              'científica.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Quem idealizou', style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final (nome, papel) in _fundadores)
                  SizedBox(
                    width: 340,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: AppRadius.brLg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nome, style: theme.textTheme.titleMedium),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(papel, style: theme.textTheme.bodyMedium),
                        ],
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
