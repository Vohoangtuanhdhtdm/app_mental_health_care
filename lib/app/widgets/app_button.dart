import 'package:flutter/material.dart';

enum AppButtonType { filled, tonal, outline }

class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    this.onPressed,
    this.icon,
    this.type = AppButtonType.filled,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final AppButtonType type;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nếu icon không null thì trải toàn bộ phần tử trong mảng
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(label),
      ],
    );

    switch (type) {
      case AppButtonType.filled:
        return FilledButton(onPressed: onPressed, child: child);
      case AppButtonType.tonal:
        return FilledButton.tonal(onPressed: onPressed, child: child);
      case AppButtonType.outline:
        return OutlinedButton(onPressed: onPressed, child: child);
    }
  }
}
