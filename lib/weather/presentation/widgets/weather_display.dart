import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:angryflutter/weather/domain/entities/weather_entity.dart';
import 'package:angryflutter/weather/presentation/widgets/glassmorphic_card.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              weather.getWeatherDescription(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),
            _WeatherDetailRow(
              label: 'Feels Like',
              value: '${weather.feelsLike.toStringAsFixed(1)}°C',
            ),
            _WeatherDetailRow(
              label: 'Wind',
              value: '${weather.windSpeed} km/h',
            ),
            _WeatherDetailRow(
              label: 'Humidity',
              value: '${weather.humidity}%',
            ),
            _WeatherDetailRow(
              label: 'Sunrise',
              value: DateFormat.jm().format(DateTime.parse(weather.sunrise)),
            ),
            _WeatherDetailRow(
              label: 'Sunset',
              value: DateFormat.jm().format(DateTime.parse(weather.sunset)),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _WeatherDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
