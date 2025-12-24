import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';

import 'package:angryflutter/weather/data/datasources/remote/weather_remote_datasource.dart';
import 'package:angryflutter/weather/presentation/providers/weather_provider.dart';
import 'package:angryflutter/weather/presentation/providers/weather_state.dart';
import 'package:angryflutter/weather/presentation/widgets/forecast_display.dart';
import 'package:angryflutter/weather/presentation/widgets/loading_widget.dart';
import 'package:angryflutter/weather/presentation/widgets/weather_display.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();

  bool get isDayTime {
    return false; // Force night animation
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(
              isDayTime
                  ? 'assets/lotti/Happy SUN.json'
                  : 'assets/lotti/Cold Mountain Background.json',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Weather',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TypeAheadField<String>(
                    builder: (context, controller, focusNode) {
                      return TextField(
                        controller: _controller,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter City Name',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                ref
                                    .read(weatherNotifierProvider.notifier)
                                    .getWeather(_controller.text);
                              }
                            },
                          ),
                        ),
                      );
                    },
                    suggestionsCallback: (pattern) async {
                      if (pattern.isEmpty) return [];
                      final remoteDataSource = ref.read(weatherRemoteDataSourceProvider);
                      return await remoteDataSource.getCitySuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                        tileColor: Colors.white.withOpacity(0.1),
                        textColor: Colors.white,
                      );
                    },
                    onSelected: (suggestion) {
                      _controller.text = suggestion;
                      ref.read(weatherNotifierProvider.notifier).getWeather(suggestion);
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          if (weatherState is WeatherInitial) {
                            return const Text(
                              'Enter a city to get the weather',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            );
                          } else if (weatherState is WeatherLoading) {
                            return const LoadingWidget();
                          } else if (weatherState is WeatherLoaded) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  WeatherDisplay(weather: weatherState.weather),
                                  const SizedBox(height: 20),
                                  ForecastDisplay(
                                    forecasts: weatherState.weather.dailyForecasts,
                                  ),
                                ],
                              ),
                            );
                          } else if (weatherState is WeatherError) {
                            return Text(
                              weatherState.message,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
