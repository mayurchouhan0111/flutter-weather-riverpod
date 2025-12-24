import 'package:angryflutter/weather/core/error/exceptions.dart';
import 'package:angryflutter/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel weatherToCache);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  @override
  Future<WeatherModel> getLastWeather() {
    // For now, we'll just throw a CacheException to simulate no data in cache.
    throw CacheException();
  }

  @override
  Future<void> cacheWeather(WeatherModel weatherToCache) {
    // For now, we'll just return a completed future.
    return Future.value();
  }
}
