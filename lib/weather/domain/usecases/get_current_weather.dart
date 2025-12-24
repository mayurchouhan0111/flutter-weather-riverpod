import 'package:dartz/dartz.dart';
import 'package:angryflutter/weather/core/error/failures.dart';
import 'package:angryflutter/weather/domain/entities/weather_entity.dart';
import 'package:angryflutter/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather(this.repository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return repository.getCurrentWeather(cityName);
  }
}
