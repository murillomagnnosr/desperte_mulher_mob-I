import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_border_radius.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'content_container.dart';

/// Barra de navegação superior reutilizável (CustomNavbar — Etapa 9).
///
/// Em telas largas mostra os links e o botão "Login do Acolhe"; em telas
/// estreitas abre o [CustomDrawer] (registrado no [AppShell]).
class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  static const _links = <(String, String)>[
    ('Início', AppRoutes.homeName),
    ('Sobre', AppRoutes.sobreName),
    ('Análise de Risco', AppRoutes.analiseInfoName),
    ('Observatório', AppRoutes.observatorioName),
    ('Contato', AppRoutes.contatoName),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Material(
      color: theme.scaffoldBackgroundColor,
      elevation: 0.5,
      child: ContentContainer(
        vertical: AppSpacing.md,
        child: Row(
          children: [
            InkWell(
              onTap: () => context.goNamed(AppRoutes.homeName),
              child: const _Logo(),
            ),
            const Spacer(),
            if (!isMobile) ...[
              for (final (label, route) in _links)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
                  child: TextButton(
                    onPressed: () => context.goNamed(route),
                    child: Text(label),
                  ),
                ),
              const SizedBox(width: AppSpacing.sm),
              OutlinedButton(
                onPressed: () => context.goNamed(AppRoutes.loginName),
                child: const Text('Login do Acolhe'),
              ),
            ] else
              Builder(
                builder: (innerContext) => IconButton(
                  onPressed: () => Scaffold.of(innerContext).openDrawer(),
                  icon: const Icon(Icons.menu_rounded),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: const BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: AppRadius.brMd,
          ),
          child: const Icon(Icons.favorite_rounded,
              color: Colors.white, size: 22,),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          AppStrings.appName,
          style: theme.textTheme.titleLarge
              ?.copyWith(color: AppColors.primaryDark),
        ),
      ],
    );
  }
}
