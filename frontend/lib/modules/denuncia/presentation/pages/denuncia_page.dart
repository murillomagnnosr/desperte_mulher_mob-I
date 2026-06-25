import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/content_container.dart';
import '../../../../shared/widgets/custom_text_field.dart';

/// Tela de Denúncia Anônima (campos preservados do site original).
///
/// Submissão simulada — na Etapa 12 chama `POST /reports`. Nenhum dado de
/// identificação é solicitado (anonimato).
class DenunciaPage extends StatefulWidget {
  const DenunciaPage({super.key});

  @override
  State<DenunciaPage> createState() => _DenunciaPageState();
}

class _DenunciaPageState extends State<DenunciaPage> {
  final _formKey = GlobalKey<FormState>();
  final _endereco = TextEditingController();
  final _referencia = TextEditingController();
  final _texto = TextEditingController();
  String? _tipo;
  String? _municipio;

  static const _tipos = <String>[
    'Violência física',
    'Violência psicológica',
    'Violência moral',
    'Violência patrimonial',
    'Violência sexual',
    'Ameaça',
  ];

  static const _municipios = <String>[
    'Palmas',
    'Araguaína',
    'Gurupi',
    'Porto Nacional',
    'Paraíso do Tocantins',
    'Colinas do Tocantins',
    'Tocantinópolis',
    'Guaraí',
    'Outro município',
  ];

  @override
  void dispose() {
    _endereco.dispose();
    _referencia.dispose();
    _texto.dispose();
    super.dispose();
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          icon: const Icon(Icons.verified_outlined,
              color: AppColors.success, size: 40,),
          title: const Text('Denúncia registrada'),
          content: const Text(
              'Sua denúncia anônima foi registrada. Obrigado por ajudar a '
              'proteger outras mulheres.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.goNamed(AppRoutes.homeName);
              },
              child: const Text('Fechar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.ctaDenunciaAnonima)),
      body: SingleChildScrollView(
        child: ContentContainer(
          vertical: AppSpacing.lg,
          maxWidth: AppSpacing.maxFormWidth,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '100% anônima. Não pedimos seus dados.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.secondary),
                ),
                const SizedBox(height: AppSpacing.lg),
                CustomDropdownField<String>(
                  label: 'Tipo de violência',
                  value: _tipo,
                  hint: 'Selecione',
                  items: [
                    for (final t in _tipos)
                      DropdownMenuItem(value: t, child: Text(t)),
                  ],
                  onChanged: (v) => setState(() => _tipo = v),
                  validator: (v) => v == null ? 'Selecione o tipo' : null,
                ),
                CustomDropdownField<String>(
                  label: 'Município onde ocorre o fato',
                  value: _municipio,
                  hint: 'Selecione',
                  items: [
                    for (final m in _municipios)
                      DropdownMenuItem(value: m, child: Text(m)),
                  ],
                  onChanged: (v) => setState(() => _municipio = v),
                  validator: (v) => v == null ? 'Selecione o município' : null,
                ),
                CustomTextField(
                  label: 'Endereço do fato',
                  controller: _endereco,
                  prefixIcon: Icons.place_outlined,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o endereço' : null,
                ),
                CustomTextField(
                  label: 'Ponto de referência',
                  controller: _referencia,
                  prefixIcon: Icons.signpost_outlined,
                ),
                CustomTextField(
                  label: 'Digite aqui a sua denúncia',
                  controller: _texto,
                  maxLines: 5,
                  validator: (v) => (v == null || v.trim().length < 10)
                      ? 'Descreva o ocorrido'
                      : null,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.goNamed(AppRoutes.homeName),
                        child: const Text(AppStrings.denunciaFechar),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _enviar,
                        child: const Text(AppStrings.denunciaEnviar),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
