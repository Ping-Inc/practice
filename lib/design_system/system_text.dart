import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/enums/text_size_enum.dart';
import 'package:practice/extensions/text_size_enum_extensions.dart';

class SystemText extends ConsumerWidget {
  const SystemText(
      {super.key,
      required this.text,
      this.size = TextSizeEnum.fifteen,
      this.color,
      this.maxLines,
      this.align = TextAlign.left,
      this.underline = false,
      this.light = false,
      this.overflow = TextOverflow.ellipsis,
      this.weight = FontWeight.normal});

  final String text;
  final TextSizeEnum size;
  final Color? color;

  final int? maxLines;
  final TextAlign align;
  final bool underline;
  final bool light;
  final TextOverflow overflow;
  final FontWeight weight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(text,
        maxLines: maxLines ?? 999,
        textAlign: align,
        style: TextStyle(
            fontWeight: weight,
            decoration: underline ? TextDecoration.underline : null,
            inherit: false,
            height: 1.6,
            fontSize: size.toFontSize(),
            color: color ?? Theme.of(context).colorScheme.primary,
            overflow: overflow));
  }
}
