import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_weather/src/utils/cache_service.dart';
import 'package:stream_weather/stream_weather.dart';
import 'package:test/test.dart';

class MockDioClient extends Mock implements DioClient {}

class MockCacheManager extends Mock implements CacheService {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StreamWeather.initClient(apiKey: 'test');
  group('WeatherService', () {
    late WeatherService weatherService;
    late MockDioClient mockDioClient;

    // Read and parse the JSON file
    final jsonFile = File('test/dymmy_data/dummy_weather_json.json');
    final jsonString = jsonFile.readAsStringSync();
    final jsonData = json.decode(jsonString);

    setUp(() {
      mockDioClient = MockDioClient();
      weatherService = WeatherService()..dioClient = mockDioClient;
    });

    test('getCurrentWeatherByCityName returns WeatherModel', () async {
      const name = 'Pune';

      when(() => mockDioClient.get(
                any(),
                queryParameters: any(named: 'queryParameters'),
              ))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              data: jsonData,
              statusCode: 200));

      final result =
          await weatherService.getCurrentWeatherByCityName(cityName: name);

      expect(result, isA<WeatherModel>());
    });

    test('getCurrentWeatherByLocation returns WeatherModel', () async {
      const lat = 52.4;
      const lon = 4.9;

      when(() => mockDioClient.get(
                any(),
                queryParameters: any(named: 'queryParameters'),
              ))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              data: jsonData,
              statusCode: 200));

      final result =
          await weatherService.getCurrentWeatherByLocation(lat: lat, lon: lon);

      expect(result, isA<WeatherModel>());
    });

    test('getWeatherIcon returns the correct emoji', () {
      expect(weatherService.getWeatherIcon(200), '🌩');
      expect(weatherService.getWeatherIcon(350), '🌧');
      expect(weatherService.getWeatherIcon(500), '☔️');
      expect(weatherService.getWeatherIcon(600), '☃️');
      expect(weatherService.getWeatherIcon(700), '🌫');
      expect(weatherService.getWeatherIcon(800), '☀️');
      expect(weatherService.getWeatherIcon(801), '☁️');
      expect(weatherService.getWeatherIcon(805), '🤷‍');
    });
  });
}
