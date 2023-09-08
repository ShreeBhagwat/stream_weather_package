import 'package:stream_weather/src/core/dio/dio_client.dart';
import 'package:stream_weather/src/core/models/weather_model.dart';
import 'package:stream_weather/src/core/service/ab_weather_service.dart';
import 'package:stream_weather/src/core/service/weather_client.dart';

/// A service for fetching weather data using the OpenWeatherMap API.
class WeatherService extends ABWeatherService {
  /// Make sure StreamWeather is initialised with API key.
  ///
  /// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
  ///
  /// Weather Service has functions to get the weather data.
  /// It has two functions:
  /// 1. getCurrentWeather() - Get the weather data based on the
  /// current location.
  /// 2. getWeatherByCityName() - Get the weather data based on
  /// the city name.
  /// To get weather data by cityName you will have pass **cityName**
  /// as an agrument.
  ///
  WeatherService();

  /// The [DioClient] used for making HTTP requests.
  DioClient dioClient = DioClient();

  /// The instace [WeatherClient] used for authenticating with the OpenWeatherMap API.
  final weatherClient = WeatherClient.instance;

  /// Returns the weather data for a specific city by its [cityName].
  /// Make sure StreamWeather is initialised with API key.
  ///
  /// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
  ///
  @override
  Future<WeatherModel> getCurrentWeatherByCityName(
      {String cityName = 'Amsterdam'}) async {
    /// Retrieves the weather data for a specific city by its [cityName].
    ///
    /// Throws an exception if the [StreamWeather] is not initialized
    /// with an API key.
    /// please initialise StreamWeather
    ///  ```StreamWeather.initClient(apiKey: YOUR API KEY);```

    if (!weatherClient.isInitializedWithApiKey()) {
      throw Exception(
          '''StreamWeather not initialized. Please initialize StreamWeather  with API key.''');
    } else {
      final response = await dioClient.get('/data/2.5/weather',
          queryParameters: {
            'q': cityName,
            'appid': weatherClient.apiKey,
            'units': weatherClient.unit.name
          });
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    }
  }

  /// Returns the current weather data for the user's location.
  /// Pass the latitude and longitude as an argument.
  /// You can use ```Geolocator``` package  to get the current location.
  /// Make sure StreamWeather is initialised with API key.
  ///
  /// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
  ///
  @override
  Future<WeatherModel> getCurrentWeatherByLocation(
      {required double lat, required double lon}) async {
    /// Retrieves the current weather data for the user's location.
    ///
    /// Throws an exception if the [_weatherClient] is not initialized with an API key.
    if (!weatherClient.isInitializedWithApiKey()) {
      throw Exception(
          '''StreamWeather not initialized. Please initialize StreamWeather  with API key.''');
    } else {
      final response =
          await dioClient.get('/data/2.5/weather', queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': weatherClient.apiKey,
        'units': weatherClient.unit.name
      });
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    }
  }


  /// Returns an emoji representing the weather condition based on the 
  /// provided [condition] code.
  ///
  /// - If [condition] is less than 300, returns '🌩' for thunderstorms.
  /// - If [condition] is between 300 and 399, returns '🌧' for drizzle.
  /// - If [condition] is between 400 and 599, returns '☔️' for rain.
  /// - If [condition] is between 600 and 699, returns '☃️' for snow.
  /// - If [condition] is between 700 and 799, returns '🌫' for fog.
  /// - If [condition] is 800, returns '☀️' for clear sky.
  /// - If [condition] is between 801 and 804, returns '☁️' for clouds.
  /// - Otherwise, returns '🤷‍' for unknown conditions.
  @override
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
