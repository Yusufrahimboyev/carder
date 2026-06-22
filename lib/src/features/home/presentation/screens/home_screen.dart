import 'package:card_scanner/card_scanner.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cardholderController = TextEditingController();

  CardScanOptions scanOptions = CardScanOptions(
    scanCardHolderName: false,
    validCardsToScanBeforeFinishingScan: 2,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );
  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cardholderController.dispose();
    super.dispose();
  }

  // Future<void> scanCard() async {
  //   try {
  //     var cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
  //
  //     if (!mounted) return;
  //     cardNumberController.text = cardDetails?.cardNumber ?? '';
  //     expiryDateController.text = cardDetails?.expiryDate ?? '';
  //
  //   } catch (e) {
  //     debugPrint('Scanner bug ');
  //   }
  // }

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
        child: BlocBuilder<HomeBloc, HomeState>(
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
                          if (isAvailable == NfcAvailability.enabled) {
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
                              cardNumberController.text=result['pan'];
                              expiryDateController.text=result['expiry'];
                              context.read<HomeBloc>().add(NfcResultEvent(
                                cardNumber: result['pan'] ?? '',
                                date: result['expiry'] ?? '',
                              ));
                            }
                          } else {
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.localizations.notsupport,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    SizedBox(height: 20),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      CardButton(
                        iconPath: AppIcons.camera,
                        label: context.localizations.kamera_orqali_skanerlash,
                        onTap: scanCard,
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
                      context.read<HomeBloc>().add(
                        SaveCardEvent(
                          cardNumber: cardNumberController.text,
                          name: cardholderController.text,
                          date: expiryDateController.text,
                        ),
                      );
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

