import 'dart:math';

import 'number.dart';

/// Returns an interpolator between the two list of numbers [a] and [b].
///
/// Internally, an list template is created that is the same type and length as
/// [b]. For each element in [b], if there exists a corresponding element in
/// [a], the values are directly interpolated in the list template. If there is
/// no such element, the static value from [b] is copied. The updated list
/// template is then returned.
///
/// Note: For performance reasons, **no defensive copy** is made of the template
/// list and the arguments [a] and [b]; modifications of these lists may affect
/// subsequent evaluation of the interpolator.
///
/// {@category Value interpolation}
List<T> Function(num) interpolateNumberList<T extends num>(
    List<T> a, List<T> b) {
  var n = min(b.length, a.length),
      l = (b is List<int>
          ? _interpolateToInt
          : b is List<double>
              ? _interpolateToDouble
              : interpolateNumber) as T Function(num) Function(num, num),
      x = List<T Function(num)>.generate(n, (i) => l(a[i], b[i])),
      c = b.sublist(0),
      i = 0;

  return (t) {
    for (i = 0; i < n; ++i) {
      c[i] = x[i](t);
    }
    return c;
  };
}

int Function(num) _interpolateToInt(num a, num b) {
  return (t) {
    return (a * (1 - t) + b * t).toInt();
  };
}

double Function(num) _interpolateToDouble(num a, num b) {
  return (t) {
    return (a * (1 - t) + b * t).toDouble();
  };
}
