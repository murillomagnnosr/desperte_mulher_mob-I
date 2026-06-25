import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/session/session_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/custom_text_field.dart';

/// Tela de Login da área "Acolhe".
///
/// Validação local + autenticação simulada via [SessionController]. Na Etapa
/// 10/12 o `signIn` passará a chamar `POST /auth/login` e guardar o JWT.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  void _entrar() {
    if (_formKey.currentState!.validate()) {
      sl<SessionController>().signIn(_email.text.trim());
      context.goNamed(AppRoutes.painelAdminName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                    const Icon(Icons.favorite_rounded,
                        color: AppColors.primary, size: 48,),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Login do Acolhe',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,),
                    Text('Área profissional da rede de apoio',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,),
                    const SizedBox(height: AppSpacing.xl),
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
                      obscureText: _obscure,
                      prefixIcon: Icons.lock_outline,
                      validator: (v) => (v == null || v.length < 6)
                          ? 'Mínimo de 6 caracteres'
                          : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        child: Text(_obscure ? 'Mostrar senha' : 'Ocultar senha'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ElevatedButton(
                        onPressed: _entrar, child: const Text('Entrar'),),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem conta?'),
                        TextButton(
                          onPressed: () =>
                              context.goNamed(AppRoutes.cadastroName),
                          child: const Text('Faça parte da rede'),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(AppRoutes.homeName),
                      child: const Text('Voltar ao início'),
                    ),
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
