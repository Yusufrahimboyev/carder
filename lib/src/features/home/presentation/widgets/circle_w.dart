import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final Color color;
  final int? number;
  const CircleWidget({super.key, required this.color, this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: number != null
          ? Text(
        number.toString(),
        style: context.textTheme.titleSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      )
          : DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: const SizedBox.square(dimension: 8),
      ),
    );
  }
}