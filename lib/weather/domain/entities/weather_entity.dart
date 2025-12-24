import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:angryflutter/weather/domain/entities/daily_forecast_entity.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final double temperature;
  final int weatherCode;
  final List<DailyForecastEntity> dailyForecasts;
  final double windSpeed;
  final int windDirection;
  final int humidity;
  final double feelsLike;
  final String sunrise;
  final String sunset;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.weatherCode,
    required this.dailyForecasts,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
  });

  String getWeatherDescription() {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Mainly clear, partly cloudy, and overcast';
      case 45:
      case 48:
        return 'Fog and depositing rime fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle: Light, moderate, and dense intensity';
      case 56:
      case 57:
        return 'Freezing Drizzle: Light and dense intensity';
      case 61:
      case 63:
      case 65:
        return 'Rain: Slight, moderate and heavy intensity';
      case 66:
      case 67:
        return 'Freezing Rain: Light and heavy intensity';
      case 71:
      case 73:
      case 75:
        return 'Snow fall: Slight, moderate, and heavy intensity';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers: Slight, moderate, and violent';
      case 85:
      case 86:
        return 'Snow showers slight and heavy';
      case 95:
        return 'Thunderstorm: Slight or moderate';
      case 96:
      case 99:
        return 'Thunderstorm with slight and heavy hail';
      default:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
        cityName,
        temperature,
        weatherCode,
        dailyForecasts,
        windSpeed,
        windDirection,
        humidity,
        feelsLike,
        sunrise,
        sunset,
      ];
}
