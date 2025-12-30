import 'dart:ui';

class StickerPlacement {
  final Offset position;
  final double scale;
  final double rotation;

  const StickerPlacement({
    required this.position,
    this.scale = 1,
    this.rotation = 0,
  });

  static StickerPlacement defaultPlacement() {
    return const StickerPlacement(
      position: Offset(50, 50),
      scale: 1,
      rotation: 0,
    );
  }
}
