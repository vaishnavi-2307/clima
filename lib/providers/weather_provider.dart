import 'package:clima_flutter_app/models/weather_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clima_flutter_app/services/api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_provider.dart';

final weatherProvider = FutureProvider.autoDispose((ref) async {
  final connectivityResult = ref.watch(connectivityProvider);

  if (connectivityResult.value == ConnectivityResult.none) {
    throw 'No internet connection available.';
  }

  final apiService = ApiService();
  final data = await apiService.getLocationWeather();

  final temperature = data['main']['temp'].toInt();
  final condition = data['weather'][0]['id'];
  final weatherIcon = apiService.getWeatherIcon(condition);
  final weatherMessage = apiService.getMessage(temperature);
  final cityName = data['name'];

  return WeatherData(
    temperature: temperature,
    condition: condition,
    weatherIcon: weatherIcon,
    weatherMessage: weatherMessage,
    cityName: cityName,
  );
});
