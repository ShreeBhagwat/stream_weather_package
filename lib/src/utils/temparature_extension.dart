/// Dart extension for temperature conversion.
///
/// This extension adds methods to convert temperature values between
/// Celsius and Fahrenheit for a double value.
extension TemperatureConversion on double {
  /// Converts temperature from Celsius to Fahrenheit.
  ///
  /// This method takes a temperature value in Celsius and returns the
  /// equivalent temperature in Fahrenheit.
  double get celsiusToFahrenheit => (this * 9/5) + 32;

  /// Converts temperature from Fahrenheit to Celsius.
  ///
  /// This method takes a temperature value in Fahrenheit and returns the
  /// equivalent temperature in Celsius.
  double get fahrenheitToCelsius => (this - 32) * (5/9);
}