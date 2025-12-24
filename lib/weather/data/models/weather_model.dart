import 'package:angryflutter/weather/data/models/daily_forecast_model.dart';
import 'package:angryflutter/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required String cityName,
    required double temperature,
    required int weatherCode,
    required List<DailyForecastModel> dailyForecasts,
    required double windSpeed,
    required int windDirection,
    required int humidity,
    required double feelsLike,
    required String sunrise,
    required String sunset,
  }) : super(
          cityName: cityName,
          temperature: temperature,
          weatherCode: weatherCode,
          dailyForecasts: dailyForecasts,
          windSpeed: windSpeed,
          windDirection: windDirection,
          humidity: humidity,
          feelsLike: feelsLike,
          sunrise: sunrise,
          sunset: sunset,
        );

  factory WeatherModel.fromGeocodingAndWeatherJson(
      Map<String, dynamic> geocodingJson, Map<String, dynamic> weatherJson) {
    final daily = weatherJson['daily'];
    final dailyForecasts = List<DailyForecastModel>.generate(
      daily['time'].length,
      (index) => DailyForecastModel.fromJson(daily, index),
    );

    return WeatherModel(
      cityName: geocodingJson['results'][0]['name'],
      temperature: weatherJson['current']['temperature_2m'].toDouble(),
      weatherCode: weatherJson['current']['weathercode'],
      dailyForecasts: dailyForecasts,
      windSpeed: weatherJson['current']['windspeed_10m'].toDouble(),
      windDirection: weatherJson['current']['winddirection_10m'],
      humidity: weatherJson['current']['relativehumidity_2m'],
      feelsLike: weatherJson['current']['apparent_temperature'].toDouble(),
      sunrise: weatherJson['daily']['sunrise'][0],
      sunset: weatherJson['daily']['sunset'][0],
    );
  }
}