import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cardholderController;

  const AppTextFormField({
    super.key,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cardholderController,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final _cardNumberFormatter = MaskTextInputFormatter(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '#### #### #### ####',
  );
  final _expiryDateFormatter = MaskTextInputFormatter(
    filter: {'#': RegExp(r'[0-9]')},
    mask: '##/##',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.cardNumberController, // ← QO'SHILDI
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
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.expiryDateController, // ← QO'SHILDI
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
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.cardholderController, // ← QO'SHILDI
          inputFormatters: [
            LengthLimitingTextInputFormatter(26),
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ']")),
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
