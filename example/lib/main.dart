import 'dart:developer';
import 'package:example/constant.dart';
import 'package:flutter/material.dart';
import 'package:stream_weather/stream_weather.dart';

void main() {
  StreamWeather.initClient(apiKey: WEATHER_API_KEY, unit: WeatherUnit.imperial);
  runApp(const WeatherExampleApp());
}

class WeatherExampleApp extends StatefulWidget {
  const WeatherExampleApp({super.key});

  @override
  State<WeatherExampleApp> createState() => _WeatherExampleAppState();
}

class _WeatherExampleAppState extends State<WeatherExampleApp> {
  WeatherUnit unit = WeatherUnit.metric;
  String cityName = 'Pune';
  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('StreamWeather Example'),
            actions: [
              // create a button that switches between metric and imperial
              TextButton(
                child: Text(
                  unit == WeatherUnit.metric ? '°C' : '°F',
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
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
                  padding: const EdgeInsets.all(10.0),
                  child: CurrentWeatherRowWidget(
                    showWeatherIcon: true,
                    unit: unit,
                    lat: kLat,
                    lon: kLon,
                    backgroundColor: const Color.fromARGB(255, 29, 28, 28),
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
                            setState(() {
                              cityName = _cityNameController.text;
                            });
                          },
                          icon: const Icon(Icons.search))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}


// ElevatedButton(
//               onPressed: () {
//                 StreamWeather.fetchCurrentWeatherByCityName(cityName: 'Pune')
//                     .then((value) {});
//                 StreamWeather.fetchCurrentWeatherByLocation(
//                         lat: kLat, lon: kLon)
//                     .then((value) {});
//               },
//               child: const Text('Fetch Weather'),
//             )