import 'package:flutter/material.dart';

extension IntExtensions on num {
  //Screen Utils
  /// Leaves given height of space
  Widget get spaceHeight => SizedBox(height: toDouble());

  /// Leaves given width of space
  Widget get spaceWidth => SizedBox(width: toDouble());
}
