import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/session/session_controller.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/content_container.dart';

/// Painel da área "Acolhe" (rota protegida).
///
/// Resumo operacional para a rede de apoio. Os números são ilustrativos; na
/// Etapa 12 virão da API com base no perfil/autorização da usuária.
class PainelAdminPage extends StatelessWidget {
  const PainelAdminPage({super.key});

  static const _cards = <(String, String, IconData, Color)>[
    ('Atendimentos', '128', Icons.diversity_3_outlined, AppColors.secondary),
    ('Denúncias', '342', Icons.report_outlined, AppColors.accent),
    ('Análises', '1.204', Icons.fact_check_outlined, AppColors.primary),
    ('Casos urgentes', '37', Icons.priority_high_rounded, AppColors.error),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = sl<SessionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Acolhe'),
        actions: [
          IconButton(
            tooltip: 'Perfil',
            onPressed: () => context.goNamed(AppRoutes.perfilName),
            icon: const Icon(Icons.person_outline),
          ),
          IconButton(
            tooltip: 'Configurações',
            onPressed: () => context.goNamed(AppRoutes.configName),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: () {
              session.signOut();
              context.goNamed(AppRoutes.homeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ContentContainer(
          vertical: AppSpacing.lg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá, ${session.userName ?? 'profissional'} 👋',
                  style: theme.textTheme.headlineSmall,),
              const SizedBox(height: AppSpacing.xs),
              Text('Visão geral da rede de apoio',
                  style: theme.textTheme.bodyMedium,),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  for (final (label, valor, icon, color) in _cards)
                    Container(
                      width: 220,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.10),
                        borderRadius: AppRadius.brLg,
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, color: color),
                          const SizedBox(height: AppSpacing.sm),
                          Text(valor,
                              style: theme.textTheme.displaySmall
                                  ?.copyWith(color: color),),
                          Text(label, style: theme.textTheme.titleSmall),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('Atividades recentes', style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              for (var i = 1; i <= 4; i++)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text('Análise #${1200 + i} encaminhada à rede'),
                    subtitle: const Text('Há poucos minutos'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              Text('* Dados ilustrativos (Etapa 12 integra com a API).',
                  style: theme.textTheme.bodySmall,),
            ],
          ),
        ),
      ),
    );
  }
}
