import 'package:flutter/material.dart';
/// A Dart extension on the [BuildContext] class to provide convenient methods
/// for getting screen dimensions using [MediaQuery].
extension BuildContextExtension on BuildContext {
  
  /// Get the screen height multiplied by a specified factor.
  ///
  /// The [ofValue] parameter is an optional factor (default is 1) by which the
  /// screen height will be multiplied. It should be greater than 0 and less than
  /// or equal to 1.
  ///
  /// Returns the calculated screen height.
  double getHeight([double ofValue = 1.0]) {
    assert(ofValue > 0 && ofValue <= 1, 'ofValue must be greater than 0 and less than or equal to 1.');
    return MediaQuery.sizeOf(this).height * ofValue;
  }
  
  /// Get the screen width multiplied by a specified factor.
  ///
  /// The [ofValue] parameter is an optional factor (default is 1) by which the
  /// screen width will be multiplied. It should be greater than 0 and less than
  /// or equal to 1.
  ///
  /// Returns the calculated screen width.
  double getWidth([double ofValue = 1.0]) {
    assert(ofValue > 0 && ofValue <= 1, 'ofValue must be greater than 0 and less than or equal to 1.');
    return MediaQuery.sizeOf(this).width * ofValue;
  }
}