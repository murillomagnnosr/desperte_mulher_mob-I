import 'package:flutter/material.dart';

import 'custom_drawer.dart';
import 'custom_footer.dart';
import 'custom_navbar.dart';

/// Casca padrão das páginas institucionais: navbar no topo, conteúdo rolável
/// e rodapé. Mantém o layout consistente e elimina repetição entre telas.
///
/// O [child] normalmente é envolvido por [ContentContainer] para herdar a
/// largura máxima e o padding.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, this.showFooter = true});

  final Widget child;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavbar(),
            child,
            if (showFooter) const CustomFooter(),
          ],
        ),
      ),
    );
  }
}
