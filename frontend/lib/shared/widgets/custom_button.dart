import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, text }

/// Botão padronizado do app, com variantes e estado de carregamento.
///
/// Encapsula Elevated/Outlined/Text button para garantir consistência e
/// evitar repetição. Mostra um spinner quando [isLoading] e desabilita o toque.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    final onTap = isLoading ? null : onPressed;

    final Widget button = switch (variant) {
      ButtonVariant.primary => icon != null && !isLoading
          ? ElevatedButton.icon(
              onPressed: onTap, icon: Icon(icon), label: Text(label),)
          : ElevatedButton(onPressed: onTap, child: child),
      ButtonVariant.secondary => icon != null && !isLoading
          ? OutlinedButton.icon(
              onPressed: onTap, icon: Icon(icon), label: Text(label),)
          : OutlinedButton(onPressed: onTap, child: child),
      ButtonVariant.text => TextButton(onPressed: onTap, child: child),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
