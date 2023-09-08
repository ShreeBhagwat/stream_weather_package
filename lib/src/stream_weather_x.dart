import 'package:stream_weather/stream_weather.dart';

/// StreamWeather package helps to fetch you weather data on location basis
/// or by city name.
///
/// To use StreamWeather package please initialize StreamWeather with your
/// openweathermap API key in the main.dart file.
///
/// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
///
/// StreamWeather package has 2 functions:
///
/// 1. fetchCurrentWeatherByLocation() - Get the weather data based on the
/// current location.
/// 2. fetchCurrentWeatherByCityName() - Get the weather data based on the
/// city name.
/// To get weather data by cityName you will have pass **cityName** as an
/// agrument.
///
/// ```StreamWeather.fetchCurrentWeatherByCityName(cityName: 'Amsterdam');```
///
///

class StreamWeather {
  /// Initializes the WeatherClient with the provided API key.
  ///
  /// Parameters:
  /// - [apiKey]: The API key to use for initializing the WeatherClient.
  /// - [unit]: The unit of measurement to use for weather data.
  static void initClient(
      {required String apiKey, WeatherUnit unit = WeatherUnit.metric}) {
    WeatherClient.create(apiKey: apiKey, unit: unit);
  }

  /// Fetches the current weather data based on the Provided latitude and
  /// longitude.
  /// Parameters:
  /// - [lat]: Latitude of the location.
  /// - [lon]: Longitude of the location.
  /// Returns:
  /// A [WeatherModel] object representing the current weather data.

  static Future<WeatherModel> fetchCurrentWeatherByLocation(
      {required double lat, required double lon}) async {
    return WeatherService().getCurrentWeatherByLocation(lat: lat, lon: lon);
  }

  /// Fetches the current weather data for a specific city by its
  /// name asynchronously.
  ///
  /// Parameters:
  /// - [cityName]: The name of the city for which to fetch weather data.
  ///
  /// Returns:
  /// A [WeatherModel] object representing the current weather data for the specified city.
  static Future<WeatherModel> fetchCurrentWeatherByCityName({
    required String cityName,
  }) async {
    return WeatherService().getCurrentWeatherByCityName(cityName: cityName);
  }
}
