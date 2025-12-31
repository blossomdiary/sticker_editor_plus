import 'dart:async';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  final Color? activeColor;
  final List<Color> colors;
  final Function(Color) onColorPicked;
  final bool enableColorPicker;

  const ColorPalette({
    Key? key,
    this.activeColor,
    required this.onColorPicked,
    required this.colors,
    this.enableColorPicker = true,
  }) : super(key: key);

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  late Color _activeColor;

  @override
  void initState() {
    _activeColor = widget.activeColor ?? widget.colors[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _activeColor = Colors.transparent;
                    widget.onColorPicked(Colors.transparent);
                  });
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                          color: Theme.of(context).colorScheme.onSurface)),
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                          image: AssetImage('assets/disable.png',
                              package: 'stickereditor'))),
                  // child: const Icon(Icons.remove_circle),
                ),
              ),
            ),
          ),
          ...widget.colors
              .map(
                (color) => _ColorHolder(
                  color: color,
                  active: color == _activeColor,
                  onTap: (color) {
                    setState(() => _activeColor = color);
                    widget.onColorPicked(color);
                  },
                ),
              )
              .toList(),
          if (widget.enableColorPicker)
            _ColorPickerButton(
              isActive: _activeColor != Colors.transparent &&
                  !widget.colors.contains(_activeColor),
              onTap: _openColorPicker,
            ),
        ],
      ),
    );
  }

  Future<void> _openColorPicker() async {
    Timer? colorChangeDebounceTimer;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    Center(
                      child: Text(
                        'Pick a color',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Flexible(
                      child: SingleChildScrollView(
                        child: ColorPicker(
                          color: _activeColor == Colors.transparent
                              ? Colors.black
                              : _activeColor,
                          onColorChanged: (Color color) {
                            // debounce: apply color only after 300ms of last change
                            colorChangeDebounceTimer?.cancel();
                            colorChangeDebounceTimer = Timer(
                              const Duration(milliseconds: 300),
                              () {
                                this.setState(() => _activeColor = color);
                                widget.onColorPicked(color);
                              },
                            );
                          },
                          borderRadius: 4,
                          enableOpacity: true,
                          materialNameTextStyle: const TextStyle(fontSize: 12),
                          colorNameTextStyle: const TextStyle(fontSize: 12),
                          colorCodeTextStyle: const TextStyle(fontSize: 12),
                          pickersEnabled: const <ColorPickerType, bool>{
                            ColorPickerType.both: false,
                            ColorPickerType.primary: false,
                            ColorPickerType.accent: false,
                            ColorPickerType.bw: false,
                            ColorPickerType.custom: true,
                            ColorPickerType.wheel: true,
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ColorHolder extends StatelessWidget {
  final Color color;
  final Function(Color) onTap;
  final bool active;

  const _ColorHolder({
    required this.color,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: active
            ? Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.onSurface))
            : null,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => onTap(color),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Theme.of(context).colorScheme.onSurface)),
              borderRadius: BorderRadius.circular(50),
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPickerButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _ColorPickerButton({
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: isActive
            ? Border.fromBorderSide(
                BorderSide(color: Theme.of(context).colorScheme.onSurface))
            : null,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                  BorderSide(color: Theme.of(context).colorScheme.onSurface)),
              borderRadius: BorderRadius.circular(50),
              gradient: const SweepGradient(
                colors: [
                  Color(0xFFFF0000),
                  Color(0xFFFFA500),
                  Color(0xFFFFFF00),
                  Color(0xFF00FF00),
                  Color(0xFF00FFFF),
                  Color(0xFF0000FF),
                  Color(0xFF8A2BE2),
                  Color(0xFFFF0000),
                ],
              ),
            ),
            child: const Icon(Icons.color_lens, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
