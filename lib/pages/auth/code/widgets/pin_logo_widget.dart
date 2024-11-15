import 'package:flutter/material.dart';
import 'dart:math' as math;

class PinLogo extends StatelessWidget {

  const PinLogo({super.key, });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1500),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(value * math.pi * 2) * 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              Icons.lock_rounded,
              size: 80,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        );
      },
    );
  }
}
