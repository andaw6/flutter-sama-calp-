import 'package:flutter/material.dart';

class PinDots extends StatelessWidget {
  final String currentPin;
  const PinDots({super.key, required this.currentPin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final bool isFilled = index < currentPin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? Colors.white : Colors.transparent,
            border: Border.all(
              color: Colors.white.withOpacity(isFilled ? 1 : 0.5),
              width: 2,
            ),
            boxShadow: isFilled
                ? [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              )
            ]
                : null,
          ),
        );
      }),
    );
  }
}
