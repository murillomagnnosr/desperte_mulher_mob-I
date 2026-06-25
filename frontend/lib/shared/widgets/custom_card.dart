import 'package:flutter/material.dart';

import '../../core/theme/app_border_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_spacing.dart';

/// Cartão reutilizável com o visual do design system (borda suave + sombra).
/// Vira clicável quando [onTap] é informado.
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.brLg,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: AppShadows.sm,
      ),
      child: child,
    );

    if (onTap == null) return content;
    return InkWell(
      borderRadius: AppRadius.brLg,
      onTap: onTap,
      child: content,
    );
  }
}
