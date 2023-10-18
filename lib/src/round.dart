import 'number.dart';

/// Returns an interpolator between the two numbers [a] and [b]; the
/// interpolator is similar to [interpolateNumber], except it will round the
/// resulting value to the nearest integer.
///
/// {@category Value interpolation}
int Function(num) interpolateRound(num a, num b) {
  return (t) {
    return (a * (1 - t) + b * t).round();
  };
}
