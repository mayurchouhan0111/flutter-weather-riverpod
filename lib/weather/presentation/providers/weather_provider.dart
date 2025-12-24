import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:angryflutter/weather/data/datasources/local/weather_local_datasource.dart';
import 'package:angryflutter/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:angryflutter/weather/data/repositories/weather_repository_impl.dart';
import 'package:angryflutter/weather/domain/repositories/weather_repository.dart';
import 'package:angryflutter/weather/domain/usecases/get_current_weather.dart';
import 'package:angryflutter/weather/presentation/providers/weather_state.dart';

// Data Sources
final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSourceImpl(client: http.Client());
});

final weatherLocalDataSourceProvider = Provider<WeatherLocalDataSource>((ref) {
  return WeatherLocalDataSourceImpl();
});

// Repository
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final remoteDataSource = ref.watch(weatherRemoteDataSourceProvider);
  final localDataSource = ref.watch(weatherLocalDataSourceProvider);
  return WeatherRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

// Use Case
final getCurrentWeatherProvider = Provider<GetCurrentWeather>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  return GetCurrentWeather(repository);
});

// State Notifier
final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  final getCurrentWeather = ref.watch(getCurrentWeatherProvider);
  return WeatherNotifier(getCurrentWeather);
});

class WeatherNotifier extends StateNotifier<WeatherState> {
  final GetCurrentWeather _getCurrentWeather;

  WeatherNotifier(this._getCurrentWeather) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    state = WeatherLoading();
    final result = await _getCurrentWeather(cityName);
    result.fold(
      (failure) => state = WeatherError('Failed to fetch weather data.'),
      (weather) => state = WeatherLoaded(weather),
    );
  }
}
