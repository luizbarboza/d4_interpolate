import 'package:d4_color/d4_color.dart';

import 'color.dart';

String Function(num) Function(Object?, Object?) _hsl(
    num Function(num) Function(num, num) hue) {
  return (start, end) {
    var h = hue((start = Hsl.from(start)).h, (end = Hsl.from(end)).h),
        s = nogamma((start as Hsl).s, (end as Hsl).s),
        l = nogamma(start.l, end.l),
        opacity = nogamma(start.opacity, end.opacity);
    return (t) {
      (start as Hsl).h = h(t);
      start.s = s(t);
      start.l = l(t);
      start.opacity = opacity(t);
      return start.toString();
    };
  };
}

/// Returns an HSL color space interpolator between the two colors [a] and [b].
///
/// The colors [a] and [b] need not be in HSL; they will be converted to HSL
/// using [Hsl.from]. If either color’s hue or saturation is [double.nan], the
/// opposing color’s channel value is used. The shortest path between hues is
/// used. The return value of the interpolator is an RGB string.
///
/// {@category Color interpolation}
String Function(num) interpolateHsl(Object? a, Object? b) => _hsl(hue)(a, b);

/// Like [interpolateHsl], but does not use the shortest path between hues.
///
/// {@category Color interpolation}
String Function(num) interpolateHslLong(Object? a, Object? b) =>
    _hsl(nogamma)(a, b);
