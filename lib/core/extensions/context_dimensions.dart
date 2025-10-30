import 'package:flutter/material.dart';

extension ContextDimensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isVertical => width < height;

  bool get isHorizontal => width > height;
}
