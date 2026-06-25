import 'package:flutter/material.dart';

import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "Apoios e Parcerias" — instituições que apoiam o projeto.
class ApoiosPage extends StatelessWidget {
  const ApoiosPage({super.key});

  static const _parceiros = <String>[
    'Polícia Federal',
    'Polícia Civil do Tocantins',
    'Secretaria de Estado da Mulher',
    'Casa da Mulher Brasileira',
    'Ouvidoria da Mulher',
    'OAB-TO — Comissão de Feminicídio',
    'Universidade Católica do Tocantins',
    'Lions Club de Palmas',
    'TO Hosts Data Center',
    '63 Uniformes',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apoios e Parcerias', style: theme.textTheme.displaySmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Uma rede de instituições públicas e da sociedade civil sustenta '
              'esta iniciativa.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final p in _parceiros)
                  Container(
                    width: 280,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: AppRadius.brLg,
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_outlined,
                            color: AppColors.secondary,),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                            child:
                                Text(p, style: theme.textTheme.titleSmall),),
                      ],
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
