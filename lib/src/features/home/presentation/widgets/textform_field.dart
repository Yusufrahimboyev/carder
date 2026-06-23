import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cardholderController;
  final GlobalKey<FormState> formKey;

  const AppTextFormField({
    super.key,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cardholderController,
    required this.formKey,
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
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (v) {
              final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
              if (digits.isEmpty) {
                return context.localizations.maydonlarni_toldiring;
              }
              if (digits.length != 16)
                return context.localizations.karta_raqami;
              return null;
            },
            controller: widget.cardNumberController,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            validator: (v) {
              if ((v ?? '').trim().isEmpty) {
                return context.localizations.maydonlarni_toldiring;
              }
              if ((v ?? '').length != 5) {
                return context.localizations.maydonlarni_toldiring;
              }
              return null;
            },
            controller: widget.expiryDateController,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return context.localizations.maydonlarni_toldiring;
              }
              return null;
            },
            controller: widget.cardholderController,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
