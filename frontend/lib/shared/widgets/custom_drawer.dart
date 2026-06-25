import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

/// Drawer de navegação reutilizável (mobile). Espelha os links da navbar.
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static const _items = <(String, IconData, String)>[
    ('Início', Icons.home_outlined, AppRoutes.homeName),
    ('Sobre', Icons.info_outline, AppRoutes.sobreName),
    ('Análise de Risco', Icons.fact_check_outlined, AppRoutes.analiseInfoName),
    ('Observatório', Icons.insights_outlined, AppRoutes.observatorioName),
    ('Contato', Icons.mail_outline, AppRoutes.contatoName),
    ('Denúncia Anônima', Icons.report_outlined, AppRoutes.denunciaName),
    ('Login do Acolhe', Icons.login, AppRoutes.loginName),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(gradient: AppColors.heroGradient),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppStrings.appName,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            for (final (label, icon, route) in _items)
              ListTile(
                leading: Icon(icon),
                title: Text(label),
                onTap: () {
                  Navigator.of(context).pop();
                  context.goNamed(route);
                },
              ),
          ],
        ),
      ),
    );
  }
}
