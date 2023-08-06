import 'package:d4_color/d4_color.dart';

import 'color.dart';

String Function(num) Function(Object?, Object?) _hcl(
    num Function(num) Function(num, num) hue) {
  return (start, end) {
    var h = hue((start = Hcl.from(start)).h, (end = Hcl.from(end)).h),
        c = nogamma((start as Hcl).c, (end as Hcl).c),
        l = nogamma(start.l, end.l),
        opacity = nogamma(start.opacity, end.opacity);
    return (t) {
      (start as Hcl).h = h(t);
      start.c = c(t);
      start.l = l(t);
      start.opacity = opacity(t);
      return start.toString();
    };
  };
}

/// Returns a
/// [CIELChab color space](https://en.wikipedia.org/wiki/CIELAB_color_space#Cylindrical_representation:_CIELCh_or_CIEHLC)
/// interpolator between the two colors [a] and [b].
///
/// The colors [a] and [b] need not be in CIELChab; they will be converted to
/// CIELChab using [Hcl.from]. If either color’s hue or chroma is [double.nan],
/// the opposing color’s channel value is used. The shortest path between hues
/// is used. The return value of the interpolator is an RGB string.
String Function(num) interpolateHcl(Object? a, Object? b) => _hcl(hue)(a, b);

/// Like [interpolateHcl], but does not use the shortest path between hues.
String Function(num) interpolateHclLong(Object? a, Object? b) =>
    _hcl(nogamma)(a, b);
