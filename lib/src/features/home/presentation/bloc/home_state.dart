part of 'homebloc.dart';

class HomeState extends Equatable {
  final Status status;
  final String cardNumber;
  final String name;
  final String date;

  const HomeState({
    this.status = Status.initial,
    this.cardNumber = '',
    this.name = '',
    this.date = '',
  });

  HomeState copyWith({
    Status? status,
    String? cardNumber,
    String? name,
    String? date,
    String? brand,
  }) {
    return HomeState(
      status: status ?? this.status,
      cardNumber: cardNumber ?? this.cardNumber,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [status, cardNumber, name, date];
}
