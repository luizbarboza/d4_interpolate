import 'dart:math';

import 'value.dart';

/// Returns a piecewise interpolator, composing interpolators for each adjacent
/// pair of [values].
///
/// The returned interpolator maps *t* in \[0, 1 / (*n* - 1)\] to
/// [interpolatorFactory]([values]\[0\], [values]\[1\]), *t* in \[1 / (*n* - 1),
/// 2 / (*n* - 1)\] to [interpolatorFactory]([values]\[1\], [values]\[2\]), and
/// so on, where *n* = [values].length. In effect, this is a lightweight linear
/// scale. For example, to blend through red, green and blue:
///
/// ```dart
/// final interpolate = piecewise(["red", "green", "blue"], interpolateRgbGamma(2.2));
/// ```
///
/// If [interpolatorFactory] is not specified, defaults to [interpolate].
///
/// {@category Value interpolation}
Object? Function(num) piecewise<T>(List<T> values,
    [Object? Function(num) Function(T, T) interpolatorFactory = interpolate]) {
  var n = values.length - 1,
      v = values[0],
      I = List.generate(
          n < 0 ? 0 : n, (i) => interpolatorFactory(v, (v = values[++i])));
  return (t) {
    var i = max(0, min(n - 1, (t *= n).floor()));
    return I[i](t - i);
  };
}
