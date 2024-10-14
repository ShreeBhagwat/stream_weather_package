import 'dart:developer'; // Import the 'developer' library to use the 'log' function.
import 'package:example/constant.dart'; // Import constants, including your Weather API key.
import 'package:flutter/material.dart'; // Import the Flutter Material package.
import 'package:stream_weather/stream_weather.dart'; // Import the StreamWeather package.

void main() {
  // Initialize the StreamWeather client with your API key and unit of measurement.
  // Use openweathermap.org to get your API key.
  // Use WeatherUnit.metric for metric units or WeatherUnit.imperial for imperial units.
  StreamWeather.initClient(apiKey: WEATHER_API_KEY, unit: WeatherUnit.imperial);
  runApp(
      const WeatherExampleApp()); // Run the WeatherExampleApp as the main widget.
}

// Define the WeatherExampleApp class as a StatefulWidget.
class WeatherExampleApp extends StatefulWidget {
  const WeatherExampleApp({super.key});

  @override
  State<WeatherExampleApp> createState() => _WeatherExampleAppState();
}

// Define the _WeatherExampleAppState class as the app's state.
class _WeatherExampleAppState extends State<WeatherExampleApp> {
  WeatherUnit unit =
      WeatherUnit.metric; // Initialize the unit of measurement to metric.
  String cityName = 'Pune'; // Initialize the default city name.
  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StreamWeather Example'), // Set the app's title.
          actions: [
            // Create a button that switches between metric and imperial units.
            TextButton(
              child: Text(
                unit == WeatherUnit.metric ? '°C' : '°F',
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // Toggle between metric and imperial units when the button is pressed.
                if (unit == WeatherUnit.metric) {
                  setState(() {
                    unit = WeatherUnit.imperial;
                  });
                } else {
                  setState(() {
                    unit = WeatherUnit.metric;
                  });
                }
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CurrentWeatherRowWidget(
                  showWeatherIcon: true,
                  unit: unit,
                  lat: kLat,
                  lon: kLon,
                  backgroundColor: const Color.fromARGB(255, 29, 28, 28),
                  weatherTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  temperatureTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  iconSize: 80,
                  height: 200,
                  refreshIconColor: Colors.white,
                  dateTime: DateTime
                      .now(), // We can pass the date time but it is not in use
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _cityNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter city name',
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          log('Button Pressed'); // Log a message when the button is pressed.
                          setState(() {
                            cityName = _cityNameController
                                .text; // Update the city name.
                          });
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
              ),
              CurrentWeatherColumnWidget(
                showWeatherIcon: true,
                unit: unit,
                cityName: cityName,
                backgroundColor: const Color.fromARGB(255, 29, 28, 28),
                weatherTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                temperatureTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
                iconSize: 80,
                height: 300,
                width: 150,
                refreshIconColor: Colors.white,
                dateTime: DateTime
                    .now(), // We can pass the date time but it is not in use
              ),
            ],
          ),
        ),
      ),
    );
  }
}
