import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({super.key});

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final TextEditingController cardNumberController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cardholderController;
  final _cardNumberFormatter = MaskTextInputFormatter(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '#### #### #### ####',
  );
  final _expiryDateFormatter = MaskTextInputFormatter(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '##/##',
  );

  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    expiryDateController = TextEditingController();
    cardholderController = TextEditingController();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cardholderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            _cardNumberFormatter,
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: Text(
              context.localizations.karta_raqami,
              style: context.textTheme.bodyMedium,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          inputFormatters: [
            _expiryDateFormatter,
            LengthLimitingTextInputFormatter(5),
          ],
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            label: Text(
              context.localizations.amal_qilish_muddati_mm_yy,
              style: context.textTheme.bodyMedium,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 20),
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: Text(
              context.localizations.ism_familya,
              style: context.textTheme.bodyMedium,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
