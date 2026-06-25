import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/session/session_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/content_container.dart';
import '../../../../shared/widgets/custom_text_field.dart';

/// Tela "Perfil" do profissional logado (rota protegida).
class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nome;
  final _telefone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nome = TextEditingController(text: sl<SessionController>().userName ?? '');
  }

  @override
  void dispose() {
    _nome.dispose();
    _telefone.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRoutes.painelAdminName),
        ),
      ),
      body: SingleChildScrollView(
        child: ContentContainer(
          vertical: AppSpacing.lg,
          maxWidth: AppSpacing.maxFormWidth,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primaryContainer,
                  child: Icon(Icons.person, size: 36, color: AppColors.primary),
                ),
                const SizedBox(height: AppSpacing.lg),
                CustomTextField(
                  label: 'Nome',
                  controller: _nome,
                  prefixIcon: Icons.person_outline,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                ),
                CustomTextField(
                  label: 'Telefone',
                  controller: _telefone,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar alterações'),),
                const SizedBox(height: AppSpacing.sm),
                Text('Função e permissões são definidas pela rede (Etapa 11).',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
