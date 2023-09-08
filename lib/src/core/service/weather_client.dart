/// A client for interacting with weather data using an API key.
/// Initialize the client with an API key using [WeatherClient.create]
/// before using any of its methods or Widgets.
class WeatherClient {
  /// Private constructor for the singleton pattern.
  const WeatherClient._({required this.apiKey, this.unit = WeatherUnit.metric})
      : isInitialized = true;

  /// The API key used for accessing weather data.
  final String apiKey;

  /// The unit of measurement to use for weather data.
  final WeatherUnit unit;

  /// A flag indicating whether the [WeatherClient] has been initialized
  /// with an API key.
  final bool isInitialized;

  /// The single instance of [WeatherClient].
  static WeatherClient? _instance;


  /// Create the singleton instance of [WeatherClient] and initialize it with
  /// an API key if not already done.
  static WeatherClient create(
      {required String apiKey, WeatherUnit unit = WeatherUnit.metric}) {
    _instance ??= WeatherClient._(apiKey: apiKey, unit: unit);
    return instance;
  }

  /// Returns `true` if the client has been initialized, otherwise `false`.
  bool isInitializedWithApiKey() {
    return isInitialized;
  }


  /// Get the singleton instance of WeatherClient if it exists, or throw
  /// an exception if it doesn't.
  static WeatherClient get instance {
    if (_instance == null) {
      throw Exception(
          '''StreamWeather not initialized. Call StreamWeather.initClient(apiKey: YOUR API KEY); in main() function and pass the API key as the parameter.''');
    }
    return _instance!;
  }
}

/// An enum representing the unit of measurement to use for weather data.
enum WeatherUnit {
  /// Metric units (e.g. Celsius).
  metric,

  /// Imperial units (e.g. Fahrenheit).
  imperial,
}
