import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "O que é a Análise de Risco" — explica a metodologia e leva ao início.
class AnaliseInfoPage extends StatelessWidget {
  const AnaliseInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('O que é a Análise de Risco',
                style: theme.textTheme.displaySmall,),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Analisar risco é identificar situações que podem trazer perigo e '
              'avaliar a probabilidade de algo ruim acontecer. No contexto da '
              'violência doméstica, ajuda a reconhecer sinais de alerta — '
              'ameaças, controle excessivo, perseguição, agressões — e a pensar '
              'estratégias para se proteger.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('O que avaliamos', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            for (final item in AppStrings.oQueAvaliamos)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: AppColors.secondary, size: 20,),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                        child: Text(item, style: theme.textTheme.bodyMedium),),
                  ],
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () => context.goNamed(AppRoutes.termosName),
              icon: const Icon(Icons.play_circle_outline),
              label: const Text(AppStrings.ctaAvaliacaoGratuita),
            ),
          ],
        ),
      ),
    );
  }
}
