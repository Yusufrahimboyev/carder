import 'package:card_scanner/card_scanner.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carder/src/features/home/data/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/utils/status_enum.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final SharedPreferences _shp;

  HomeBloc({required this.repository, required this._shp})
    : super(const HomeState()) {
    on<SaveCardEvent>(_onSave);
    on<LoadCardEvent>(_onLoad);
    on<ScanCardEvent>(_onScan);
    on<NfcReadEvent>(_onNfcRead);
  }

  Future<void> _onSave(SaveCardEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await repository.saveData(
        cardNumber: event.cardNumber,
        cardDate: event.date,
        cardName: event.name,
      );
      emit(
        state.copyWith(
          status: Status.success,
          cardNumber: event.cardNumber,
          name: event.name,
          date: event.date,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  void _onLoad(LoadCardEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        status: Status.loading,
        cardNumber: repository.getSavedData().number,
        name: repository.getSavedData().name,
        date: repository.getSavedData().date,
      ),
    );
  }

  Future<void> _onScan(ScanCardEvent event, Emitter<HomeState> emit) async {
    try {
      const options = CardScanOptions(
        scanCardHolderName: false,
        validCardsToScanBeforeFinishingScan: 2,
      );
      final card = await CardScanner.scanCard(scanOptions: options);
      if (card == null) return;
      emit(state.copyWith(cardNumber: card.cardNumber, date: card.expiryDate));
    } catch (_) {
      emit(state.copyWith(status: Status.error));
    }
  }

  void _onNfcRead(NfcReadEvent event, Emitter<HomeState> emit) {
    state.copyWith(cardNumber: state.cardNumber, date: state.date);
  }
}
