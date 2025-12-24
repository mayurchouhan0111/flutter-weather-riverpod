import 'package:angryflutter/weather/domain/entities/daily_forecast_entity.dart';

class DailyForecastModel extends DailyForecastEntity {
  const DailyForecastModel({
    required DateTime date,
    required double maxTemperature,
    required double minTemperature,
    required int weatherCode,
  }) : super(
          date: date,
          maxTemperature: maxTemperature,
          minTemperature: minTemperature,
          weatherCode: weatherCode,
        );

  factory DailyForecastModel.fromJson(Map<String, dynamic> json, int index) {
    return DailyForecastModel(
      date: DateTime.parse(json['time'][index]),
      maxTemperature: json['temperature_2m_max'][index].toDouble(),
      minTemperature: json['temperature_2m_min'][index].toDouble(),
      weatherCode: json['weathercode'][index],
    );
  }
}
