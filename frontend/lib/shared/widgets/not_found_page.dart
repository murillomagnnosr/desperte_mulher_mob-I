import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_spacing.dart';

/// Tela 404 — exibida pelo `errorBuilder` do GoRouter para rotas inexistentes.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('404', style: theme.textTheme.displayLarge),
              const SizedBox(height: AppSpacing.xs),
              Text('Página não encontrada',
                  style: theme.textTheme.headlineSmall,),
              const SizedBox(height: AppSpacing.xs),
              Text(uri,
                  style: theme.textTheme.bodySmall, textAlign: TextAlign.center,),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () => context.goNamed(AppRoutes.homeName),
                child: const Text('Voltar ao início'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
