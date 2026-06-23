import 'dart:typed_data';
import 'package:carder/src/common/constants/app_icons.dart';
import 'package:carder/src/common/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_android.dart';

class MyNfc extends StatefulWidget {
  const MyNfc({super.key});

  @override
  State<MyNfc> createState() => _MyNfcState();
}

class _MyNfcState extends State<MyNfc> {
  late String statusMessage = context.localizations.humo_uzcard;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _startNfcSession();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession().catchError((_) {});
    super.dispose();
  }

  Future<void> _startNfcSession() async {
    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        try {
          if (mounted) {
            setState(() {
              isProcessing = true;
              statusMessage = context.localizations.karta_oqilmoqda;
            });
          }
          final iso = IsoDepAndroid.from(tag);
          if (iso == null) {
            await NfcManager.instance.stopSession();
            if (mounted) Navigator.pop(context);
            return;
          }
          var resp = await iso.transceive(
            Uint8List.fromList([
              0x00,
              0xA4,
              0x04,
              0x00,
              0x0E,
              0x32,
              0x50,
              0x41,
              0x59,
              0x2E,
              0x53,
              0x59,
              0x53,
              0x2E,
              0x44,
              0x44,
              0x46,
              0x30,
              0x31,
              0x00,
            ]),
          );

          final aid = _findTag(resp, [0x4F]);
          if (aid == null) {
            await NfcManager.instance.stopSession();
            if (mounted) Navigator.pop(context);
            return;
          }
          resp = await iso.transceive(
            Uint8List.fromList([
              0x00,
              0xA4,
              0x04,
              0x00,
              aid.length,
              ...aid,
              0x00,
            ]),
          );
          String? pan, expiry, holderName;
          for (
            int sfi = 1;
            sfi <= 10 && (pan == null || holderName == null);
            sfi++
          ) {
            for (
              int rec = 1;
              rec <= 10 && (pan == null || holderName == null);
              rec++
            ) {
              final p2 = (sfi << 3) | 0x04;
              try {
                final read = await iso.transceive(
                  Uint8List.fromList([0x00, 0xB2, rec, p2, 0x00]),
                );
                if (read.length > 2 &&
                    read[read.length - 2] == 0x90 &&
                    read[read.length - 1] == 0x00) {
                  debugPrint("📄 SFI$sfi REC$rec: ${_hex(read)}");
                  final panB = _findTag(read, [0x5A]);
                  if (panB != null && pan == null) {
                    pan = _bcdToString(panB);
                    debugPrint("💳 PAN: $pan");
                  }
                  final expB = _findTag(read, [0x5F, 0x24]);
                  if (expB != null && expB.length >= 2 && expiry == null) {
                    expiry = "${_bcd(expB[1])}/${_bcd(expB[0])}";
                    debugPrint("📅 MUDDAT: $expiry");
                  }

                  final nameB = _findTag(read, [0x5F, 0x20]);
                  if (nameB != null && holderName == null) {
                    holderName = _asciiToString(nameB);
                    debugPrint("👤 ISM: $holderName");
                  }
                }
              } catch (_) {}
            }
          }
          await NfcManager.instance.stopSession();

          if (pan != null) {
            debugPrint("✅ NATIJA: $pan / $expiry / $holderName");
            if (mounted) {
              Navigator.pop(context, {
                'pan': pan,
                'expiry': expiry ?? '',
                'name': holderName ?? '',
              });
            }
          } else {
            debugPrint("🔴 PAN topilmadi");
            if (mounted) {
              setState(() {
                statusMessage = "Karta raqami o'qilmadi";
                isProcessing = false;
              });
            }
          }
        } catch (e) {
          debugPrint("🔴 xato: $e");
          await NfcManager.instance.stopSession().catchError((_) {});
          if (mounted) {
            setState(() {

              if (e.toString().contains('TagLost')) {
                statusMessage = "Kartani uzoqroq ushlab turing";
              } else {
                statusMessage = "Xatolik yuz berdi, qayta urining";
              }
              isProcessing = false;
            });
          }
        }
      },
    );
  }

  String _hex(Uint8List d) =>
      d.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');

  String _bcd(int b) => b.toRadixString(16).padLeft(2, '0');

  String _bcdToString(Uint8List d) => d
      .map((e) => e.toRadixString(16).padLeft(2, '0'))
      .join()
      .replaceAll(RegExp(r'[fF]'), '');

  String _asciiToString(Uint8List d) =>
      String.fromCharCodes(d).replaceAll('/', ' ').trim();

  Uint8List? _findTag(Uint8List data, List<int> tag) {
    for (int i = 0; i < data.length - tag.length; i++) {
      bool m = true;
      for (int j = 0; j < tag.length; j++) {
        if (data[i + j] != tag[j]) {
          m = false;
          break;
        }
      }
      if (m) {
        final li = i + tag.length;
        if (li >= data.length) continue;
        final len = data[li];
        final s = li + 1;
        if (s + len <= data.length) {
          return Uint8List.fromList(data.sublist(s, s + len));
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,

        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(AppIcons.nfcAnimationArea),
            const SizedBox(height: 30),
            Text(
              context.localizations.kartani_yaqin,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                statusMessage,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            if (isProcessing)
              const CircularProgressIndicator()
            else
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await NfcManager.instance.stopSession().catchError((_) {});
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: Text(context.localizations.bekor),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
