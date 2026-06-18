import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';

class DateCircle extends StatefulWidget {
  final Color color;
  final String date;

  const DateCircle({super.key, required this.color, required this.date});

  @override
  State<DateCircle> createState() => _DateCircleState();
}

class _DateCircleState extends State<DateCircle> {
  @override
  Widget build(BuildContext context) {
    return widget.date.isEmpty
        ? Row(
            spacing: 4,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.square(dimension: 8),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.square(dimension: 8),
              ),
              Text("/", style: context.textTheme.titleSmall?.copyWith()),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.square(dimension: 8),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.square(dimension: 8),
              ),
            ],
          )
        : Text(
            widget.date,
            style: context.textTheme.titleSmall?.copyWith(color: widget.color),
          );
  }
}
