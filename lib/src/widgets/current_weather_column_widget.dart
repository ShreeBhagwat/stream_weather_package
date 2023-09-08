import 'package:flutter/material.dart';
import 'package:stream_weather/src/widgets/current_weather_base_widget.dart';
import 'package:stream_weather/stream_weather.dart';

/// This widget fetches weather data using the provided [weatherClient] and
/// displays it in a Column format. It allows customization of various visual
/// aspects such as text styles, icon size, background color, and more.
class CurrentWeatherColumnWidget extends CurrentWeatherBaseWidget {
  /// Make sure StreamWeather is initialised with API key.
  ///
  /// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
  ///
  /// A widget that displays the current weather information in a ```Column``` Widget.
  /// Get the latest Weather based on the current location or by city name.
  /// Pass ```cityName``` as a parameter to get the weather of that city
  ///
  ///
  /// Parameters:
  /// - [weatherClient]: The weather client used to fetch weather data.
  /// - [height]: The height of the widget (default is 50).
  /// - [width]: The width of the widget (default is [double.infinity]).
  /// - [backgroundColor]: The background color of the widget (default is Colors.black87).
  /// - [temparatureTextStyle]: The text style for temperature information (default is white color and font size 20).
  /// - [weatherTextStyle]: The text style for weather description (default is white color, font size 20, and bold).
  /// - [showWeatherIcon]: Whether to show the weather icon (default is true).
  /// - [iconSize]: The size of the weather icon (default is 30) Should be less than Height.
  /// - [refreshIconColor]: The color of the refresh icon (default is white).
  /// - [cityName]: The name of the city for which to fetch weather data.
  /// - [lat]: The latitude of the location for which to fetch weather data.
  /// - [lon]: The longitude of the location for which to fetch weather data.
  /// - [unit]: The unit of measurement to use for weather data.
  /// - [dateTime]: The date and time for which to fetch weather data. ** Curently not in use**
  CurrentWeatherColumnWidget({
    super.key,
    super.showWeatherIcon,
    super.iconSize,
    super.refreshIconColor,
    super.cityName,
    super.lat,
    super.lon,
    WeatherUnit? unit,
    super.dateTime,
    super.height,
    super.width,
    super.backgroundColor,
    super.weatherTextStyle,
    super.temperatureTextStyle,
  })  : assert(
          height == null || height > 250,
          'The height must be greater than 250.',
        ),
        assert(
          width == null || width > 149,
          'The minimum width must be 150. Use CurrentWeatherRowWidget for larger Widths.',
        ),
        assert(
          iconSize != null || iconSize! < height!,
          'The icon size must be greater than 0 and less than height',
        ),
        assert(cityName != null || lat != null && lon != null,
            'Please provide either cityName or lat and lon arguments to fetch weather data.'),
        unit = unit ?? WeatherClient.instance.unit;

  /// The unit of measurement to use for weather data.
  final WeatherUnit unit;
  @override
  State<CurrentWeatherColumnWidget> createState() =>
      _CurrentWeatherColumnWidgetState();
}

class _CurrentWeatherColumnWidgetState
    extends CurrentWeatherBaseWidgetState<CurrentWeatherColumnWidget> {
  /// Builds the weather information widget.
  @override
  Widget buildWeatherWidget() {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  weatherModel!.name!,
                  style: widget.weatherTextStyle,
                ),
                if (widget.showWeatherIcon)
                  Text(
                    weatherService.getWeatherIcon(
                      weatherModel!.weather![0].id!,
                    ),
                    style: TextStyle(fontSize: widget.iconSize),
                  ),
                Text(
                  weatherModel!.weather![0].main!,
                  style: widget.weatherTextStyle,
                ),
                Text(
                  switchTemparatureAsPerUnit(
                      weatherModel!.main!.temp!, widget.unit),
                  style: widget.temperatureTextStyle,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: refreshWeather,
            icon: Icon(
              Icons.refresh,
              color: widget.refreshIconColor,
            ),
          ),
        ),
      ],
    );
  }
}
