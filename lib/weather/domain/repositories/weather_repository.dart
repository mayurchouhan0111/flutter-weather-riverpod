import 'package:dartz/dartz.dart';
import 'package:angryflutter/weather/core/error/failures.dart';
import 'package:angryflutter/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
