import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';

/// Tela de Cadastro na rede (área Acolhe).
///
/// Validação local, incluindo confirmação de senha. Submissão simulada — na
/// Etapa 10/12 chama `POST /auth/register`.
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirma = TextEditingController();

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _senha.dispose();
    _confirma.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado! Faça login.')),
      );
      context.goNamed(AppRoutes.loginName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Faça parte da rede')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.maxFormWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Crie sua conta', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.lg),
                    CustomTextField(
                      label: 'Nome completo',
                      controller: _nome,
                      prefixIcon: Icons.person_outline,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Informe seu nome'
                          : null,
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
                      label: 'Senha',
                      controller: _senha,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Mínimo de 6 caracteres'
                          : null,
                    ),
                    CustomTextField(
                      label: 'Confirmar senha',
                      controller: _confirma,
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      validator: (v) =>
                          v != _senha.text ? 'As senhas não conferem' : null,
                    ),
                    ElevatedButton(
                        onPressed: _cadastrar,
                        child: const Text('Cadastrar'),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
