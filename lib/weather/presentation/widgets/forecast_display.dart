import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:angryflutter/weather/domain/entities/daily_forecast_entity.dart';
import 'package:angryflutter/weather/presentation/widgets/glassmorphic_card.dart';

class ForecastDisplay extends StatelessWidget {
  final List<DailyForecastEntity> forecasts;

  const ForecastDisplay({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7-Day Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecasts.length,
            itemBuilder: (context, index) {
              final forecast = forecasts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GlassmorphicCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormat.E().format(forecast.date),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          _getWeatherIcon(forecast.weatherCode),
                          size: 30,
                        ),
                        Text(
                          '${forecast.maxTemperature.toStringAsFixed(0)}° / ${forecast.minTemperature.toStringAsFixed(0)}°',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return Icons.wb_sunny;
      case 1:
      case 2:
      case 3:
        return Icons.cloud;
      case 45:
      case 48:
        return Icons.foggy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return Icons.grain;
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
        return Icons.water_drop;
      case 71:
      case 73:
      case 75:
      case 77:
        return Icons.ac_unit;
      case 80:
      case 81:
      case 82:
      case 85:
      case 86:
        return Icons.shower;
      case 95:
      case 96:
      case 99:
        return Icons.thunderstorm;
      default:
        return Icons.help;
    }
  }
}
