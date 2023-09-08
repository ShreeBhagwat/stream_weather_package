import 'package:stream_weather/src/core/models/weather_model.dart';

/// A class representing a weather service.
abstract class ABWeatherService {
  /// Retrieves the current weather data.
  ///
  /// Returns a [Future] that resolves to a [WeatherModel] representing the
  /// current weather conditions.
  Future<WeatherModel> getCurrentWeatherByLocation(
      {required double lat, required double lon});

  /// Retrieves weather data for a specific city by its [cityName].
  ///
  /// - [cityName]: The name of the city for which weather data is requested.
  ///
  /// Returns a [Future] that resolves to a [WeatherModel] representing the
  /// weather conditions for the specified city.
  Future<WeatherModel> getCurrentWeatherByCityName({required String cityName});


  /// returns emoji weather Icon from the condition of the weather
  String getWeatherIcon(int condition);
}
