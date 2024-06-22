import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/config/theme/theme.dart';

enum TextMyVariant { h1, h2, h3, h4, h5, h6, p }

enum TextMyType {
  danger,
  success,
  warning,
  info, // default
  primary,
  secondary,
  disabled
}

class TextMy extends StatelessWidget {
  final String text;
  final TextMyVariant variant;
  final TextStyle? style;
  final TextMyType? type;
  const TextMy(this.text,
      {super.key,
      this.variant = TextMyVariant.p,
      this.style,
      this.type = TextMyType.info});

  TextStyle getStyle(BuildContext context) {
    late TextStyle res;

    TextTheme textTheme = Theme.of(context).textTheme;

    switch (variant) {
      // BOLD
      case TextMyVariant.h1:
        res = textTheme.headlineMedium!.copyWith(color: textPrimary);
        break;
      case TextMyVariant.h2:
        res = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
        break;

      // SEMIBOLD
      case TextMyVariant.h4:
        res = const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
        break;
      case TextMyVariant.h3:
        res = textTheme.titleMedium!;
        break;

      // REGULAR
      case TextMyVariant.h5:
        res = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
        break;
      case TextMyVariant.h6:
        res = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
        break;
      case TextMyVariant.p:
        res = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
        break;
    }

    switch (type) {
      case TextMyType.danger:
        res = res.copyWith(color: Colors.red);
        break;
      case TextMyType.secondary:
        res = res.copyWith(color: textSecondary);
        break;
      case TextMyType.disabled:
        res = res.copyWith(color: textDisabled);
        break;
      case TextMyType.success:
        res = res.copyWith(color: successColor);
        break;
      default:
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: getStyle(context).merge(style));
  }
}
