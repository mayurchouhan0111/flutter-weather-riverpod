import 'dart:convert';
import 'package:angryflutter/weather/core/constants/constants.dart';
import 'package:angryflutter/weather/core/error/exceptions.dart';
import 'package:angryflutter/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
  Future<List<String>> getCitySuggestions(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    // 1. Get coordinates for the city
    final geocodingResponse = await client.get(
      Uri.parse("$GEOCODING_BASE_URL?name=$cityName&count=1"),
    );

    if (geocodingResponse.statusCode != 200) {
      throw ServerException();
    }

    final geocodingJson = json.decode(geocodingResponse.body);
    if (geocodingJson['results'] == null || geocodingJson['results'].isEmpty) {
      throw ServerException(); // Or a more specific CityNotFoundException
    }

    final lat = geocodingJson['results'][0]['latitude'];
    final lon = geocodingJson['results'][0]['longitude'];

    // 2. Get weather for the coordinates
    final weatherResponse = await client.get(
      Uri.parse(
          "$WEATHER_BASE_URL?latitude=$lat&longitude=$lon&current=temperature_2m,relativehumidity_2m,apparent_temperature,weathercode,windspeed_10m,winddirection_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto"),
    );

    if (weatherResponse.statusCode == 200) {
      final weatherJson = json.decode(weatherResponse.body);
      return WeatherModel.fromGeocodingAndWeatherJson(
          geocodingJson, weatherJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getCitySuggestions(String query) async {
    final response = await client.get(
      Uri.parse('$GEOCODING_BASE_URL?name=$query&count=5'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null) {
        return List<String>.from(
            data['results'].map((item) => item['name']));
      }
      return [];
    } else {
      throw ServerException();
    }
  }
}