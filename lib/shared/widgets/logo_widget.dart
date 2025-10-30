import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  const LogoWidget({super.key, this.width = 192});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/logo.png", width: width);
  }
}
