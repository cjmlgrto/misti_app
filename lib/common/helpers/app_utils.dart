import 'dart:math';

import 'package:flame/input.dart';

class AppUtils {
  // Calculates the angle (in degrees) between the center point and the touch point
  // `center`: the center of the object (e.g., a reference point)
  // `initAngle`: the initial angle offset
  // `touch`: the coordinates where the user touched
  static int getAngleOfTouchPont({
    required Vector2 center,
    required double initAngle,
    required Vector2 touch,
  }) {
    final touchPoint = touch - center; // Calculate vector from center to touch point

    double angle = atan2(touchPoint.y, touchPoint.x); // Calculate angle in radians

    angle -= initAngle; // Adjust the angle by the initial offset
    angle %= 2 * pi; // Normalize the angle to the range [0, 2π]

    return radiansToDegrees(angle).toInt(); // Convert radians to degrees and return as an integer
  }

  // Helper method to convert radians to degrees
  static double radiansToDegrees(double angle) => angle * 180 / pi;
}
