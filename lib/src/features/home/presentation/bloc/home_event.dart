part of 'homebloc.dart';

sealed class HomeEvent {}

class SaveCardEvent extends HomeEvent {
  final String cardNumber;
  final String name;
  final String date;

  SaveCardEvent({
    required this.cardNumber,
    required this.name,
    required this.date,
  });
}

class LoadCardEvent extends HomeEvent {}

class ScanCardEvent extends HomeEvent {}

class NfcReadEvent extends HomeEvent {
  final String cardNumber;
  final String date;

  NfcReadEvent({required this.cardNumber, required this.date});
}
