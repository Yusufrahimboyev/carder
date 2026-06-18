import 'package:carder/src/common/constants/app_icons.dart';
import 'package:carder/src/common/utils/context_extension.dart';
import 'package:carder/src/features/home/presentation/widgets/circle_w.dart';
import 'package:carder/src/features/home/presentation/widgets/date_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCard extends StatefulWidget {
  final List<int> number;

  final String brand;
  final String date;
  final String name;
  const HomeCard({
    super.key,
    required this.number,
    required this.brand,
    required this.date,
    required this.name,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.4),

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.cardNfc),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: switch (widget.brand.toLowerCase().trim()) {
                    "humo" => Image.asset(
                      AppIcons.humoLogo,
                      height: 30,
                      width: 40,
                    ),

                    _ => Text(
                      "Brand",
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 1,
                runSpacing: 1,
                children: List.generate(
                  16,
                  (index) => CircleWidget(
                    color: context.colorScheme.onPrimary,
                    number: widget.number,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name.isNotEmpty
                      ? widget.name.toUpperCase()
                      : "ISM FAMILYA",
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                  ),
                ),
                DateCircle(
                  color: context.colorScheme.onPrimary,
                  date: widget.date,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
