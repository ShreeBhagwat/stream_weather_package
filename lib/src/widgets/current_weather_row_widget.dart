import 'package:flutter/material.dart';
import 'package:stream_weather/src/widgets/constants.dart';
import 'package:stream_weather/stream_weather.dart';

///
/// This widget fetches weather data using the provided [weatherClient] and
/// displays it in a row format. It allows customization of various visual
/// aspects such as text styles, icon size, background color, and more.
class CurrentWeatherRowWidget extends StatefulWidget {
  /// Make sure StreamWeather is initialised with API key.
  ///
  /// ```StreamWeather.initClient(apiKey: YOUR API KEY);```
  ///
  /// A widget that displays the current weather information in a ```ROW``` Widget.
  /// Get the latest Weather based on the current location or by city name.
  /// Pass ```cityName``` as a parameter to get the weather of that city
  ///

  ///
  /// Parameters:
  /// - [weatherClient]: The weather client used to fetch weather data.
  /// - [height]: The height of the widget (default is 200).
  /// - [width]: The width of the widget (default is [double.infinity]).
  /// - [backgroundColor]: The background color of the widget.
  /// - [temparatureTextStyle]: The text style for temperature information (default is white color and font size 20).
  /// - [weatherTextStyle]: The text style for weather description (default is white color, font size 20, and bold).
  /// - [showWeatherIcon]: Whether to show the weather icon (default is true).
  /// - [iconSize]: The size of the weather icon (default is 30) Should be less than Height.
  /// - [refreshIconColor]: The color of the refresh icon (default is white).
  /// - [cityName]: The name of the city for which to fetch weather data.
  /// - [lat]: The latitude of the location for which to fetch weather data.
  /// - [lon]: The longitude of the location for which to fetch weather data.
  /// - [unit]: The unit of measurement to use for weather data.
  /// - [dateTime]: The date and time for which to fetch weather data. **Currently not in use**
  ///
  CurrentWeatherRowWidget({
    Key? key,
    double? height,
    double? width,
    Color? backgroundColor,
    TextStyle? weatherTextStyle,
    bool showWeatherIcon = true,
    double? iconSize,
    Color? refreshIconColor,
    String? cityName,
    TextStyle? temparatureTextStyle,
    double? lat,
    double? lon,
    WeatherUnit? unit,
    DateTime? dateTime,
  }) : this._internal(
          key: key,
          height: height ?? kHeight,
          width: width ?? double.infinity,
          backgroundColor: backgroundColor ?? kBackgroundColor,
          weatherTextStyle: weatherTextStyle ?? kWeatherTextStyle,
          showWeatherIcon: showWeatherIcon,
          iconSize: iconSize ?? kIconSize,
          refreshIconColor: refreshIconColor ?? kRefreshIconColor,
          cityName: cityName,
          temparatureTextStyle: temparatureTextStyle ?? kTemparatureTextStyle,
          lat: lat,
          lon: lon,
          unit: unit,
          dateTime: dateTime,
        );

   CurrentWeatherRowWidget._internal({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.weatherTextStyle,
    this.showWeatherIcon = true,
    this.iconSize,
    this.refreshIconColor,
    this.cityName,
    this.temparatureTextStyle,
    this.lat,
    this.lon,
    WeatherUnit? unit = WeatherUnit.metric,
    this.dateTime,
  })  : assert(
          height == null || height > 0,
          'The height must be greater than 0.',
        ),
        assert(
          width == null || width > 399,
          'The minimum width must be 400. Use CurrentWeatherCubeInstead for Smaller Widths.',
        ),
        assert(
          iconSize != null || iconSize! < height!,
          'The icon size must be greater than 0.',
        ),
        assert(cityName != null || lat != null && lon != null, 'Please provide either cityName or lat and lon arguments to fetch weather data.'),
        unit = unit ?? WeatherClient.instance.unit;

  /// The height of the widget.
  final double? height;

  /// The width of the widget.
  final double? width;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// The text style for temperature information.
  final TextStyle? temparatureTextStyle;

  /// The text style for weather description.
  final TextStyle? weatherTextStyle;

  /// Whether to show the weather icon.
  final bool showWeatherIcon;

  /// The size of the weather icon.
  final double? iconSize;

  /// The color of the refresh icon.
  final Color? refreshIconColor;

  /// The name of the city for which to fetch weather data.
  final String? cityName;

  /// The latitude of the location for which to fetch weather data.
  final double? lat;

  /// The longitude of the location for which to fetch weather data.
  final double? lon;

  /// The unit of measurement to use for weather data.
  final WeatherUnit? unit;

  /// The date and time for which to fetch weather data. **Currently not in use**
  final DateTime? dateTime;

  @override
  State<CurrentWeatherRowWidget> createState() =>
      _CurrentWeatherRowWidgetState();
}

class _CurrentWeatherRowWidgetState extends State<CurrentWeatherRowWidget> {
  late WeatherService _weatherService;
  WeatherModel? _weatherModel;

  @override
  void initState() {
    _weatherService = WeatherService();
    super.initState();
  }

  /// Refreshes the weather data by making a new request to the API.
  Future<void> _refreshWeather() async {
    if (widget.cityName != null) {
      final weather = await _weatherService.getCurrentWeatherByCityName(
          cityName: widget.cityName!);
      setState(() {
        _weatherModel = weather;
      });
    } else {
      final weather = await _weatherService.getCurrentWeatherByLocation(
          lat: widget.lat!, lon: widget.lon!);
      setState(() {
        _weatherModel = weather;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: widget.width,
      height: widget.height,
      child: FutureBuilder<WeatherModel>(
        future: widget.cityName != null
            ? _weatherService.getCurrentWeatherByCityName(
                cityName: widget.cityName!)
            : _weatherService.getCurrentWeatherByLocation(
                lat: widget.lat!, lon: widget.lon!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data.
            return _buildLoadingIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if an error occurs.
            return _buildErrorWidget(snapshot.error.toString());
          } else if (snapshot.hasData) {
            _weatherModel = snapshot.data;
            // Display the weather widget with data.
            return _buildWeatherWidget();
          } else {
            // Display a message if no data is available.
            return _buildErrorWidget('No data available');
          }
        },
      ),
    );
  }

  /// Builds a loading indicator widget.
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  /// Builds an error widget with the specified [errorMessage].
  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }

  /// Builds the weather information widget.
  Widget _buildWeatherWidget() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showWeatherIcon)
                  Text(
                    _weatherService.getWeatherIcon(
                      _weatherModel!.weather![0].id!,
                    ),
                    style: TextStyle(fontSize: widget.iconSize),
                  ),
                Text(
                  _weatherModel!.weather![0].main!,
                  style: widget.weatherTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _weatherModel!.name!,
                  style: widget.weatherTextStyle,
                ),
                Text(
                  switchTemparatureAsPerUnit(
                      _weatherModel!.main!.temp!, widget.unit!),
                  style: widget.temparatureTextStyle,
                ),
              ],
            ),
          ],
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: _refreshWeather,
            icon: Icon(
              Icons.refresh,
              color: widget.refreshIconColor,
            ),
          ),
        ),
      ],
    );
  }

  /// Switches the temperature as per the specified [unit].
  static String switchTemparatureAsPerUnit(double temp, WeatherUnit unit) {
    if (unit == WeatherUnit.imperial &&
        WeatherClient.instance.unit == WeatherUnit.metric) {
      return '${temp.celsiusToFahrenheit.toStringAsFixed(0)} °F';
    } else if (unit == WeatherUnit.metric &&
        WeatherClient.instance.unit == WeatherUnit.imperial) {
      return '${temp.fahrenheitToCelsius.toStringAsFixed(0)} °C';
    } else if (unit == WeatherUnit.metric &&
        WeatherClient.instance.unit == WeatherUnit.metric) {
      return '${temp.toStringAsFixed(0)} °C';
    } else {
      return '${temp.toStringAsFixed(0)} °F';
    }
  }
}
