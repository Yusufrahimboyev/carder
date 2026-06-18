import 'package:card_scanner/card_scanner.dart';
import 'package:flutter/material.dart';

class CameraScan extends StatefulWidget {
  const CameraScan({super.key});

  @override
  State<CameraScan> createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> {
  CardDetails? _cardDetails;
  CardScanOptions scanOptions = CardScanOptions(
    scanCardHolderName: true,

    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
    ],
  );

  Future<void> scanCard() async {
    var cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
    if (!mounted) return;
    setState(() {
      _cardDetails = cardDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(_cardDetails?.cardNumber ?? ""),
          Text(_cardDetails?.cardHolderName ?? ""),
          Text(_cardDetails?.expiryDate ?? ""),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                scanCard();
              },
              child: const Text("Kartani skanerlash"),
            ),
          ),
          Text('$_cardDetails'),
        ],
      ),
    );
  }
}
