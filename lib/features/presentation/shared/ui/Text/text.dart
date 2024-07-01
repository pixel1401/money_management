import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_management/config/theme/theme.dart';

enum TextMyVariant { titleX , title1, title2, title3, regular1 , regular2, regular3, small , tiny }

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
      this.variant = TextMyVariant.regular2,
      this.style,
      this.type = TextMyType.info});

  TextStyle getStyle(BuildContext context) {
    late TextStyle res;

    TextTheme textTheme = Theme.of(context).textTheme;

    switch (variant) {
      // BOLD
      case TextMyVariant.titleX:
        res = const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, );
        break;
      case TextMyVariant.title1:
        res = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
        break;

      case TextMyVariant.title2:
        res = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
        break;
      case TextMyVariant.title3:
        res = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
        break;

      // REGULAR
      case TextMyVariant.regular1:
        res = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
        break;
      case TextMyVariant.regular2:
        res = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
        break;
      case TextMyVariant.regular3:
        res = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
        break;
      
      // small
      case TextMyVariant.small:
        res = const TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
        break;
      case TextMyVariant.tiny:
        res = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
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
