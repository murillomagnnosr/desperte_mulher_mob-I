import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/question.dart';
import '../cubit/analise_cubit.dart';

/// Tela do questionário de Análise de Risco (uma pergunta por vez).
///
/// Cria o [AnaliseCubit] via injeção de dependência e reage ao estado:
/// loading / erro / pergunta atual. Ao concluir, navega para o resultado.
class PerguntasPage extends StatelessWidget {
  const PerguntasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnaliseCubit>(
      create: (_) => sl<AnaliseCubit>()..load(),
      child: const _PerguntasView(),
    );
  }
}

class _PerguntasView extends StatelessWidget {
  const _PerguntasView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Análise de Risco')),
      body: SafeArea(
        child: BlocConsumer<AnaliseCubit, AnaliseState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            if (state.status == AnaliseStatus.success && state.result != null) {
              context.goNamed(AppRoutes.resultadoName, extra: state.result);
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              AnaliseStatus.loading || AnaliseStatus.initial =>
                const Center(child: CircularProgressIndicator()),
              AnaliseStatus.failure => _ErrorView(
                  message: state.errorMessage ?? AppStrings.erroGenerico,
                  onRetry: () => context.read<AnaliseCubit>().load(),
                ),
              _ => _QuestionContent(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _QuestionContent extends StatelessWidget {
  const _QuestionContent({required this.state});
  final AnaliseState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<AnaliseCubit>();
    final question = state.currentQuestion;
    if (question == null) {
      return const Center(child: Text('Nenhuma pergunta disponível.'));
    }
    final submitting = state.status == AnaliseStatus.submitting;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progresso
              ClipRRect(
                borderRadius: AppRadius.brPill,
                child: LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 8,
                  backgroundColor: AppColors.surfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Pergunta ${state.currentIndex + 1} de ${state.questions.length}'
                ' · ${question.category.titulo}',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(question.text, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.lg),

              // Opções
              Expanded(
                child: ListView(
                  children: [
                    for (final option in question.options)
                      _OptionTile(
                        option: option,
                        selected: state.answers[question.id] == option.id,
                        onTap: () => cubit.answer(question.id, option.id),
                      ),
                  ],
                ),
              ),

              // Navegação
              Row(
                children: [
                  if (!state.isFirstQuestion)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: submitting ? null : cubit.previous,
                        child: const Text(AppStrings.voltar),
                      ),
                    ),
                  if (!state.isFirstQuestion)
                    const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: !state.currentAnswered || submitting
                          ? null
                          : () {
                              if (state.isLastQuestion) {
                                cubit.submit();
                              } else {
                                cubit.next();
                              }
                            },
                      child: submitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white,),
                            )
                          : Text(state.isLastQuestion
                              ? 'Ver resultado'
                              : AppStrings.continuar,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });
  final AnswerOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        borderRadius: AppRadius.brLg,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryContainer
                : theme.colorScheme.surface,
            borderRadius: AppRadius.brLg,
            border: Border.all(
              color: selected ? AppColors.primary : theme.colorScheme.outline,
              width: selected ? 1.8 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? AppColors.primary : AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(option.label, style: theme.textTheme.titleSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                color: AppColors.error, size: 48,),
            const SizedBox(height: AppSpacing.sm),
            Text(message,
                style: theme.textTheme.bodyLarge, textAlign: TextAlign.center,),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
                onPressed: onRetry,
                child: const Text(AppStrings.tentarNovamente),),
          ],
        ),
      ),
    );
  }
}
