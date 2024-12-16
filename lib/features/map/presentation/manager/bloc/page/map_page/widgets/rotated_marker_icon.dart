import 'package:flutter/material.dart';

class RotatedMarkerIcon extends StatelessWidget {
  final double angle; // Rotation angle in radians
  final Icon icon;

  const RotatedMarkerIcon({required this.angle, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: icon,
    );
  }
}
