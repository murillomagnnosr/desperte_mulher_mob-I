import 'package:flutter/widgets.dart';

import '../../core/theme/app_spacing.dart';

/// Limita a largura do conteúdo e o centraliza em telas largas (web/desktop),
/// aplicando o padding horizontal padrão. Evita linhas de texto longas demais
/// e mantém a leitura confortável — usado por todas as páginas.
class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.vertical = AppSpacing.xxl,
    this.maxWidth = AppSpacing.maxContentWidth,
  });

  final Widget child;
  final double vertical;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontalMobile,
            vertical: vertical,
          ),
          child: child,
        ),
      ),
    );
  }
}
