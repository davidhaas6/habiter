import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

typedef void NeumorphicCheckboxListener<T>(T value);

class NeumorphicParentCheckbox extends StatelessWidget {
  final bool value;
  final NeumorphicCheckboxStyle style;
  final NeumorphicCheckboxListener onChanged;
  final isEnabled;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Duration duration;
  final Curve curve;
  final Widget child;

  NeumorphicParentCheckbox({
    this.style = const NeumorphicCheckboxStyle(),
    required this.value,
    required this.onChanged,
    required this.child,
    this.curve = Neumorphic.DEFAULT_CURVE,
    this.duration = Neumorphic.DEFAULT_DURATION,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(0),
    this.isEnabled = true,
  });

  bool get isSelected => this.value;

  void _onClick() {
    this.onChanged(!this.value);
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    final selectedColor = this.style.selectedColor ?? theme.accentColor;

    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (this.style.unselectedDepth ?? theme.depth).abs();
    final double selectedIntensity =
        (this.style.selectedIntensity ?? theme.intensity)
            .abs()
            .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);
    final double unselectedIntensity = this
        .style
        .unselectedIntensity
        .clamp(Neumorphic.MIN_INTENSITY, Neumorphic.MAX_INTENSITY);

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0;
    }

    Color? color = isSelected ? selectedColor : null;
    if (!this.isEnabled) {
      color = null;
    }

    Color iconColor = isSelected ? theme.baseColor : selectedColor;
    if (!this.isEnabled) {
      iconColor = theme.disabledColor;
    }

    return NeumorphicButton(
      padding: this.padding,
      pressed: isSelected,
      margin: this.margin,
      duration: this.duration,
      curve: this.curve,
      onPressed: () {
        if (this.isEnabled) {
          _onClick();
        }
      },
      drawSurfaceAboveChild: true,
      minDistance: selectedDepth.abs(),
      child: child,
      style: NeumorphicStyle(
        boxShape: this.style.boxShape,
        border: this.style.border,
        color: color,
        depth: depth,
        lightSource: this.style.lightSource ?? theme.lightSource,
        disableDepth: this.style.disableDepth,
        intensity: isSelected ? selectedIntensity : unselectedIntensity,
        shape: NeumorphicShape.convex,
      ),
    );
  }
}
