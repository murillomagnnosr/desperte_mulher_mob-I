import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/content_container.dart';

/// Tela "Configurações" (rota protegida).
///
/// Preferências de UI. A persistência (shared_preferences) e a troca real de
/// tema/idioma serão ligadas a um controlador de app em etapa posterior.
class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool _temaEscuro = false;
  bool _notificacoes = true;
  String _idioma = 'pt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed(AppRoutes.painelAdminName),
        ),
      ),
      body: SingleChildScrollView(
        child: ContentContainer(
          vertical: AppSpacing.lg,
          maxWidth: AppSpacing.maxFormWidth,
          child: Column(
            children: [
              SwitchListTile(
                value: _temaEscuro,
                onChanged: (v) => setState(() => _temaEscuro = v),
                title: const Text('Tema escuro'),
                secondary: const Icon(Icons.dark_mode_outlined),
              ),
              SwitchListTile(
                value: _notificacoes,
                onChanged: (v) => setState(() => _notificacoes = v),
                title: const Text('Notificações'),
                secondary: const Icon(Icons.notifications_outlined),
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text('Idioma'),
                trailing: DropdownButton<String>(
                  value: _idioma,
                  onChanged: (v) => setState(() => _idioma = v ?? 'pt'),
                  items: const [
                    DropdownMenuItem(value: 'pt', child: Text('Português')),
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
