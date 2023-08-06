import 'dart:math';

import 'constant.dart';

num Function(num) linear(num a, num d) {
  return (t) {
    return a + t * d;
  };
}

num Function(num) exponential(num a, num b, num y) {
  a = pow(a, y);
  b = pow(b, y) - a;
  y = 1 / y;
  return (t) {
    return pow(a + t * b, y);
  };
}

num Function(num) hue(num a, num b) {
  var d = b - a;
  return (d == 0 || d.isNaN
          ? constant(a.isNaN ? b : a)
          : linear(a, d > 180 || d < -180 ? d - 360 * (d / 360).round() : d))
      as num Function(num);
}

num Function(num) Function(num, num) gamma(num y) {
  return y == 1
      ? nogamma
      : (a, b) {
          var d = b - a;
          return (d == 0 || d.isNaN
              ? constant(a.isNaN ? b : a)
              : exponential(a, b, y)) as num Function(num);
        };
}

num Function(num) nogamma(num a, num b) {
  var d = b - a;
  return (d == 0 || d.isNaN ? constant(a.isNaN ? b : a) : linear(a, d)) as num
      Function(num);
}
