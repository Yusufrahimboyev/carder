import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardButton extends StatefulWidget {
  final String iconPath;
  final String label;
  final Function onTap;
  const CardButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colorScheme.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                SvgPicture.asset(
                  widget.iconPath,
                  height: 20,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.label,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
