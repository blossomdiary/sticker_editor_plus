import 'package:flutter/material.dart';

typedef TextAddRequest = Future<TextAddResult?> Function(
  BuildContext context,
  TextAddPayload payload,
);

typedef StickerPickRequest = Future<String?> Function(
  BuildContext context,
  StickerPickPayload payload,
);

class TextAddPayload {
  final String defaultText;
  final TextStyle defaultTextStyle;
  final TextAlign defaultTextAlign;
  final List<String> fonts;
  final List<Color>? paletteColors;
  final bool useColorPicker;

  const TextAddPayload({
    required this.defaultText,
    required this.defaultTextStyle,
    required this.defaultTextAlign,
    required this.fonts,
    required this.paletteColors,
    this.useColorPicker = true,
  });
}

class TextAddResult {
  final String text;

  const TextAddResult(this.text);
}

class StickerPickPayload {
  final List<String> assets;

  const StickerPickPayload({required this.assets});
}
