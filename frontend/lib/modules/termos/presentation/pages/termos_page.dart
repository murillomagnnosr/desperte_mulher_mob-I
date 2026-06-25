import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "Termos de Uso" — porta de entrada da Análise de Risco.
///
/// Reproduz o fluxo original: a usuária aceita os termos antes de iniciar o
/// questionário. O botão só habilita após o aceite.
class TermosPage extends StatefulWidget {
  const TermosPage({super.key});

  @override
  State<TermosPage> createState() => _TermosPageState();
}

class _TermosPageState extends State<TermosPage> {
  bool _aceito = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      showFooter: false,
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Termos de Uso', style: theme.textTheme.displaySmall),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Esta ferramenta é gratuita, anônima e tem caráter informativo. '
              'A análise de risco NÃO substitui atendimento profissional, '
              'jurídico ou policial. Os dados informados são tratados de forma '
              'sigilosa e usados apenas para gerar sua orientação de segurança. '
              'Em situação de emergência, ligue 190.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            CheckboxListTile(
              value: _aceito,
              onChanged: (v) => setState(() => _aceito = v ?? false),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Li e aceito os Termos de Uso.'),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _aceito
                    ? () => context.goNamed(AppRoutes.perguntasName)
                    : null,
                child: const Text(AppStrings.ctaIniciarAnalise),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
