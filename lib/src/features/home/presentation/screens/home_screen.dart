import 'package:carder/src/common/constants/app_icons.dart';
import 'package:carder/src/common/utils/context_extension.dart';
import 'package:carder/src/features/home/presentation/bloc/homebloc.dart';
import 'package:carder/src/features/home/presentation/widgets/card_button.dart';
import 'package:carder/src/features/home/presentation/widgets/home_card.dart';
import 'package:carder/src/features/home/presentation/widgets/my_nfc.dart';
import 'package:carder/src/features/home/presentation/widgets/textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../../common/utils/status_enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController cardNumberController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cardholderController;
  final formKey = GlobalKey<FormState>();

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

  void customDialog(String str, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              str,
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: Text(
          context.localizations.Cardscanner,
          style: context.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == Status.success && !state.fillForm) {
              cardNumberController.clear();
              expiryDateController.clear();
              cardholderController.clear();
              return;
            }

            if (state.fillForm) {
              cardNumberController.text = state.cardNumber;
              expiryDateController.text = state.date;
            }
          },
          listenWhen: (prev, curr) =>
              prev.cardNumber != curr.cardNumber ||
              prev.date != curr.date ||
              prev.status != curr.status,
          builder: (context, state) {
            return ListView(
              children: [
                HomeCard(
                  number: state.cardNumber,
                  date: state.date,
                  name: state.name,
                ),
                SizedBox(height: 24),
                AppTextFormField(
                  cardNumberController: cardNumberController,
                  expiryDateController: expiryDateController,
                  cardholderController: cardholderController,
                  formKey: formKey,
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardButton(
                        iconPath: AppIcons.cardNfc,
                        label: context.localizations.nfc_bilan_skanerlash,
                        onTap: () async {
                          NfcAvailability isAvailable = await NfcManager
                              .instance
                              .checkAvailability();
                          if (isAvailable == NfcAvailability.enabled &&
                              isAvailable != NfcAvailability.unsupported) {
                            if (!context.mounted) return;
                            final result = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (context) => const MyNfc(),
                            );
                            if (result is Map && context.mounted) {
                              context.read<HomeBloc>().add(
                                NfcReadEvent(
                                  cardNumber: result['pan'] ?? '',
                                  date: result['expiry'] ?? '',
                                ),
                              );
                            }
                          } else {
                            if (!context.mounted) return;
                            customDialog(
                              context.localizations.notsupport,
                              context,
                            );
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      CardButton(
                        iconPath: AppIcons.camera,
                        label: context.localizations.kamera_orqali_skanerlash,
                        onTap: () {
                          context.read<HomeBloc>().add(ScanCardEvent());
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<HomeBloc>().add(
                          SaveCardEvent(
                            cardNumber: cardNumberController.text,
                            name: cardholderController.text,
                            date: expiryDateController.text,
                          ),
                        );
                      } else {
                        customDialog(
                          context.localizations.maydonlarni_toldiring,
                          context,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        context.localizations.saqlash,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
