import 'package:flutter/material.dart';
import 'package:stream_weather/src/widgets/constants.dart';
import 'package:stream_weather/stream_weather.dart';

/// An abstract base class for creating customizable current weather widgets.
 /// Consider using [CurrentWeatherColumnWidget] or [CurrentWeatherRowWidget] instead.
@protected
abstract class CurrentWeatherBaseWidget extends StatefulWidget {
 /// An abstract base class for creating customizable current weather widgets.
 /// Consider using [CurrentWeatherColumnWidget] or [CurrentWeatherRowWidget] instead.
 /// Common parameters:
 /// - [key]: The key to use for the widget.
 /// - [height]: The height of the widget (default is 50).
 /// - [width]: The width of the widget (default is [double.infinity]).
 /// - [backgroundColor]: The background color of the widget (default is Colors.black87).
 /// - [weatherTextStyle]: The text style for weather description (default is white color, font size 20, and bold).
 /// - [showWeatherIcon]: Whether to show the weather icon (default is true).
 /// - [iconSize]: The size of the weather icon (default is 30) Should be less than Height.
 /// - [refreshIconColor]: The color of the refresh icon (default is white).
 /// - [cityName]: The name of the city for which to fetch weather data.
 /// - [lat]: The latitude of the location for which to fetch weather data.
 /// - [lon]: The longitude of the location for which to fetch weather data.
 /// - [unit]: The unit of measurement to use for weather data.
 /// - [dateTime]: The date and time for which to fetch weather data. ** Curently not in use**
 /// 
 @protected
  const CurrentWeatherBaseWidget({
    super.key,
    this.height = kHeight,
    this.width,
    this.backgroundColor = kBackgroundColor,
    this.weatherTextStyle = kWeatherTextStyle,
    this.showWeatherIcon = true,
    this.iconSize = kIconSize,
    this.refreshIconColor = kRefreshIconColor,
    this.cityName = 'Pune',
    this.lat = 18.5204,
    this.lon = 73.8567,
    this.dateTime,
    this.temperatureTextStyle = kTemperatureTextStyle,
  });
 
  /// The height of the widget.
  final double? height;

  /// The width of the widget.
  final double? width;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// The text style for temperature information.
  final TextStyle? temperatureTextStyle;

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

  /// The date and time for which to fetch weather data. **Currently not in use**
  final DateTime? dateTime;


  @override
  State<CurrentWeatherBaseWidget> createState();
}

///
/// The state for the [CurrentWeatherBaseWidget] class.
/// 
abstract class CurrentWeatherBaseWidgetState<T extends CurrentWeatherBaseWidget>
    extends State<T> {

   /// An instance of the WeatherService class responsible for fetching weather data.
  late WeatherService weatherService;

  /// A variable that holds the weather data model, representing the current weather information.
  WeatherModel? weatherModel;

  /// A Future object representing the asynchronous task for fetching weather data.
  Future<WeatherModel>? weatherFuture;



  @override
  void initState() {
    weatherService = WeatherService();
    weatherFuture = _fetchWeatherData(false);
    super.initState();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cityName != widget.cityName ||
        oldWidget.lat != widget.lat ||
        oldWidget.lon != widget.lon) {
      // If the widget properties (cityName, lat, lon) have changed, fetch new weather data.

      setState(() {
        weatherFuture = _fetchWeatherData(false);
      });
    }
  }

  /// Fetches the weather data by making a new request to the API.
  @protected
  Future<WeatherModel> _fetchWeatherData(bool refreshdata) async {
    if (widget.cityName != null) {
      return weatherService.getCurrentWeatherByCityName(
          cityName: widget.cityName!, refreshData: refreshdata);
    } else {
      return weatherService.getCurrentWeatherByLocation(
          lat: widget.lat!, lon: widget.lon!, refreshData: refreshdata);
    }
  }

  /// Refreshes the weather data by making a new request to the API.
  @protected
  Future<void> refreshWeather() async {
    setState(() {
      weatherFuture = _fetchWeatherData(true);
    });
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
        future: weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data.
            return _buildLoadingIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if an error occurs.
            return _buildErrorWidget(snapshot.error.toString());
          } else if (snapshot.hasData) {
            weatherModel = snapshot.data;
            // Display the weather widget with data.
            return buildWeatherWidget();
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

  /// Switches the temperature as per the unit. 
 String switchTemparatureAsPerUnit(double temp, WeatherUnit unit) {
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

  /// Builds the weather widget with the weather data.
  /// Should be implemented by the subclasses.
  Widget buildWeatherWidget();
}
