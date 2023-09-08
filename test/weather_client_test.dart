import 'package:stream_weather/stream_weather.dart';
import 'package:test/test.dart';

void main() {
  group('WeatherClient', () {
    late WeatherClient weatherClient;

    setUp(() {
      weatherClient = WeatherClient.create(apiKey: 'YOUR_API_KEY');
    });

  

    test('WeatherClient instance is singleton', () {
      final instance1 = WeatherClient.create(apiKey: 'API_KEY_1');
      final instance2 = WeatherClient.create(apiKey: 'API_KEY_2');

      expect(instance1, equals(instance2));
    });

    test('WeatherClient instance throws exception if not initialized', () {
      WeatherClient? uninitializedInstance;

      expect(() {
        uninitializedInstance = WeatherClient.instance;
      }, throwsA(isA<Exception>()));

      expect(uninitializedInstance, isNull);
    });


    test('WeatherClient instance has correct unit', () {
      expect(weatherClient.unit, equals(WeatherUnit.metric));
    });


  });
}
