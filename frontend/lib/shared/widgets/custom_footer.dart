import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'content_container.dart';

/// Rodapé reutilizável (CustomFooter — Etapa 9).
class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: AppColors.primaryDark,
      child: ContentContainer(
        vertical: AppSpacing.xl,
        child: Column(
          children: [
            Text(
              AppStrings.appName,
              style:
                  theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              AppStrings.tagline,
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.xs,
              alignment: WrapAlignment.center,
              children: [
                _FooterLink('Sobre', AppRoutes.sobreName),
                _FooterLink('Apoios', AppRoutes.apoiosName),
                _FooterLink('Termos de Uso', AppRoutes.termosName),
                _FooterLink('Denúncia Anônima', AppRoutes.denunciaName),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppStrings.emailContato,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              '© 2026 Desperte Mulher — Projeto acadêmico',
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink(this.label, this.routeName);
  final String label;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.goNamed(routeName),
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(label),
    );
  }
}
