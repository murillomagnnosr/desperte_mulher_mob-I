import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_shell.dart';
import '../../../../shared/widgets/content_container.dart';
import '../../../../shared/widgets/custom_text_field.dart';

/// Tela "Contato" — canais de emergência + formulário de mensagem.
class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _mensagem = TextEditingController();

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _mensagem.dispose();
    super.dispose();
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      // Etapa 12: POST /contacts. Por ora, feedback local.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mensagem enviada. Obrigado!')),
      );
      _formKey.currentState!.reset();
      _nome.clear();
      _email.clear();
      _mensagem.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppShell(
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fale conosco', style: theme.textTheme.displaySmall),
            const SizedBox(height: AppSpacing.md),

            // Emergência
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.08),
                borderRadius: AppRadius.brLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emergência', style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.xs),
                  const Text('180 — Central de Atendimento à Mulher'),
                  const Text('190 — Polícia Militar'),
                  const Text('Ouvidoria da Mulher: ${AppStrings.telOuvidoria}'),
                  const Text(
                      'Casa da Mulher Brasileira: ${AppStrings.telCasaMulher}',),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Formulário
            Text('Envie uma mensagem', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.md),
            ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.maxFormWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Nome',
                      controller: _nome,
                      prefixIcon: Icons.person_outline,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Informe seu nome' : null,
                    ),
                    CustomTextField(
                      label: 'E-mail',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      validator: (v) => (v == null || !v.contains('@'))
                          ? 'E-mail inválido'
                          : null,
                    ),
                    CustomTextField(
                      label: 'Mensagem',
                      controller: _mensagem,
                      maxLines: 4,
                      validator: (v) => (v == null || v.trim().length < 5)
                          ? 'Escreva sua mensagem'
                          : null,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _enviar,
                        child: const Text('Enviar mensagem'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
