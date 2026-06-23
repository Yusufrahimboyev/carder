part of 'homebloc.dart';

class HomeState extends Equatable {
  final Status status;
  final String cardNumber;
  final String name;
  final String date;
  final bool fillForm;

  const HomeState({
    this.status = Status.initial,
    this.cardNumber = '',
    this.name = '',
    this.date = '',
    this.fillForm = false,
  });

  HomeState copyWith({
    Status? status,
    String? cardNumber,
    String? name,
    String? date,
    bool? fillForm,
  }) {
    return HomeState(
      status: status ?? this.status,
      cardNumber: cardNumber ?? this.cardNumber,
      name: name ?? this.name,
      date: date ?? this.date,
      fillForm: fillForm ?? this.fillForm,
    );
  }

  @override
  List<Object?> get props => [status, cardNumber, name, date, fillForm];
}
