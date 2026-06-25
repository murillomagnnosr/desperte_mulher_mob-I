import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/risk_result.dart';

/// Tela de resultado da Análise de Risco.
///
/// Recebe o [RiskResult] via `GoRouterState.extra` (objeto autocontido, não
/// depende mais do cubit). Exibe o medidor de risco, a quebra por categoria e
/// os encaminhamentos. Se aberta sem resultado, convida a iniciar a análise.
class ResultadoPage extends StatelessWidget {
  const ResultadoPage({super.key, required this.result});
  final RiskResult? result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = result;

    if (r == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Resultado')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nenhum resultado para exibir.',
                    style: theme.textTheme.bodyLarge,),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => context.goNamed(AppRoutes.perguntasName),
                  child: const Text('Iniciar análise'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final color = AppColors.riskColor(r.percent);

    return Scaffold(
      appBar: AppBar(title: const Text('Seu resultado')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                _Gauge(percent: r.percent, color: color, level: r.level.label),
                const SizedBox(height: AppSpacing.lg),
                if (r.level.isUrgent)
                  const _UrgentBanner()
                else
                  const SizedBox.shrink(),
                const SizedBox(height: AppSpacing.lg),

                Text('Fatores por categoria',
                    style: theme.textTheme.headlineSmall,),
                const SizedBox(height: AppSpacing.sm),
                for (final entry in r.categoryBreakdown.entries)
                  _CategoryBar(label: entry.key, percent: entry.value),

                const SizedBox(height: AppSpacing.lg),
                Text('Encaminhamentos sugeridos',
                    style: theme.textTheme.headlineSmall,),
                const SizedBox(height: AppSpacing.sm),
                for (final rec in r.recommendations)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: AppColors.secondary, size: 20,),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                            child: Text(rec, style: theme.textTheme.bodyMedium),),
                      ],
                    ),
                  ),

                const SizedBox(height: AppSpacing.lg),
                ElevatedButton.icon(
                  onPressed: () => context.goNamed(AppRoutes.contatoName),
                  icon: const Icon(Icons.support_agent_outlined),
                  label: const Text('Falar com alguém da rede'),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () => context.goNamed(AppRoutes.homeName),
                  child: const Text('Voltar ao início'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Gauge extends StatelessWidget {
  const _Gauge(
      {required this.percent, required this.color, required this.level,});
  final double percent;
  final Color color;
  final String level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: 180,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 180,
                width: 180,
                child: CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 14,
                  backgroundColor: color.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${percent.toStringAsFixed(0)}%',
                      style: theme.textTheme.displaySmall
                          ?.copyWith(color: color),),
                  Text('risco', style: theme.textTheme.labelMedium),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.xs,),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: AppRadius.brPill,
          ),
          child: Text('Nível: $level',
              style: theme.textTheme.titleMedium?.copyWith(color: color),),
        ),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({required this.label, required this.percent});
  final String label;
  final double percent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AppColors.riskColor(percent);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.textTheme.titleSmall),
              Text('${percent.toStringAsFixed(0)}%',
                  style: theme.textTheme.labelMedium,),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          ClipRRect(
            borderRadius: AppRadius.brPill,
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 8,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgentBanner extends StatelessWidget {
  const _UrgentBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: AppRadius.brLg,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.priority_high_rounded, color: AppColors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Sua segurança pode estar em risco elevado. Em emergência, '
              'ligue 190. Você não está sozinha.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
