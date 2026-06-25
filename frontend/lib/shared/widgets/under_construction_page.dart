import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';

/// Placeholder temporário das telas que serão implementadas na Etapa 8.
///
/// Mantém o app navegável e demonstra a navegação (GoRouter) ponta a ponta
/// já nesta fase. Será substituído pela tela real de cada rota.
class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.construction_rounded,
                  size: 56, color: theme.colorScheme.primary,),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Tela em construção (Etapa 8).',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: () => context.goNamed(AppRoutes.homeName),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Voltar ao início'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
