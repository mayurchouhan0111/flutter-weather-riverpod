import 'package:equatable/equatable.dart';

class DailyForecastEntity extends Equatable {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final int weatherCode;

  const DailyForecastEntity({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.weatherCode,
  });

  @override
  List<Object?> get props => [date, maxTemperature, minTemperature, weatherCode];
}
