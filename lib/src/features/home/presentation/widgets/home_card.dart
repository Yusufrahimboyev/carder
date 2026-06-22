import 'package:carder/src/common/constants/app_icons.dart';
import 'package:carder/src/common/utils/context_extension.dart';
import 'package:carder/src/features/home/presentation/widgets/circle_w.dart';
import 'package:carder/src/features/home/presentation/widgets/date_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeCard extends StatefulWidget {
  final String number;
  final String date;
  final String name;
  const HomeCard({
    super.key,
    required this.number,
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
                  child: Builder(
                    builder: (context) {
                      final digits = widget.number.replaceAll(RegExp(r'\D'), '');
                      if (digits.startsWith('9860')) {
                        return Image.asset(AppIcons.humoLogo, height: 30, width: 40);
                      } else if (digits.startsWith('8600')) {
                        return Image.asset(AppIcons.uzcardLogo, height: 50, width: 50);
                      } else if (digits.startsWith('4')) {
                        return SvgPicture.asset(AppIcons.visa, height: 30, width: 40);
                      } else if (digits.startsWith(RegExp(r'5[1-5]')) ||
                          digits.startsWith(RegExp(r'2[2-7]'))) {
                        return SvgPicture.asset(AppIcons.mastercard
                            , height: 30, width: 40);
                      } else {
                        return Text(
                          "Brand",
                          style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 1,
                runSpacing: 1,
                  children: List.generate(16, (index) {
                final digits = widget.number.replaceAll(RegExp(r'\D'), '');
                final hasDigit = index < digits.length;
                return CircleWidget(
                  color: context.colorScheme.onPrimary,
                  number: hasDigit ? int.parse(digits[index]) : null,
                );
              }),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name.isNotEmpty
                      ? widget.name.toUpperCase()
                      : context.localizations.ism_familya,
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
