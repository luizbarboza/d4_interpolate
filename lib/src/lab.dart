import 'package:d4_color/d4_color.dart';

import 'color.dart';

/// Returns a
/// [CIELAB color space](https://en.wikipedia.org/wiki/Lab_color_space#CIELAB)
/// interpolator between the two colors [a] and [b].
///
/// The colors [a] and [b] need not be in CIELAB; they will be converted to
/// CIELAB using [Lab.from]. The return value of the interpolator is an RGB
/// string.
String Function(num) interpolateLab(Object? a, Object? b) {
  var l = nogamma((a = Lab.from(a)).l, (b = Lab.from(b)).l),
      a_ = nogamma((a as Lab).a, (b as Lab).a),
      b_ = nogamma(a.b, b.b),
      opacity = nogamma(a.opacity, b.opacity);
  return (t) {
    (a as Lab).l = l(t);
    a.a = a_(t);
    a.b = b_(t);
    a.opacity = opacity(t);
    return a.toString();
  };
}
