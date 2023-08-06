import 'dart:math';

import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/src/color.dart';

String Function(num) Function(Object?, Object?) Function(num) _cubehelixGamma(
    num Function(num) Function(num, num) hue) {
  return (y) {
    return (start, end) {
      var h = hue(
              (start = Cubehelix.from(start)).h, (end = Cubehelix.from(end)).h),
          s = nogamma((start as Cubehelix).s, (end as Cubehelix).s),
          l = nogamma(start.l, end.l),
          opacity = nogamma(start.opacity, end.opacity);
      return (t) {
        (start as Cubehelix).h = h(t);
        start.s = s(t);
        start.l = l(pow(t, y));
        start.opacity = opacity(t);
        return start.toString();
      };
    };
  };
}

/// Returns a new Cubehelix color space interpolator factory using the specified
/// [gamma].
///
/// For example, to interpolate from purple to orange with a gamma of 3.0 to
/// emphasize high-intensity values:
///
/// ```dart
/// final interpolator = interpolateCubehelixGamma(3.0)("purple", "orange");
/// ```
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/cubehelixGamma.png" width="100%" height="40" alt="cubehelixGamma">
///
/// See Eric Brasseur’s article,
/// [Gamma error in picture scaling](http://www.ericbrasseur.org/gamma.html),
/// for more on gamma correction.
String Function(num) Function(Object?, Object?) interpolateCubehelixGamma(
        num gamma) =>
    _cubehelixGamma(hue)(gamma);

/// Like [interpolateCubehelixGamma], but does not use the shortest path between
/// hues.
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/cubehelixGammaLong.png" width="100%" height="40" alt="cubehelixGammaLong">
String Function(num) Function(Object?, Object?) interpolateCubehelixGammaLong(
        num gamma) =>
    _cubehelixGamma(nogamma)(gamma);

/// Returns an Cubehelix color space interpolator between the two colors [a] and
/// [b] with a default gamma of 1.
///
/// The colors [a] and [b] need not be in Cubehelix; they will be converted to
/// Cubehelix using [Cubehelix.from]. If either color’s hue or saturation is
/// [double.nan], the opposing color’s channel value is used. The shortest path
/// between hues is used. The return value of the interpolator is an RGB string.
///
/// For example, to interpolate from purple to orange in Cubehelix space:
///
/// ```dart
/// final interpolator = interpolateCubehelix("purple", "orange");
/// ```
///
/// which is equivalent to:
///
/// ```dart
/// final interpolator = interpolateCubehelixGamma(1)("purple", "orange");
/// ```
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/cubehelix.png" width="100%" height="40" alt="cubehelix">
String Function(num) interpolateCubehelix(Object? a, Object? b) =>
    interpolateCubehelixGamma(1)(a, b);

/// Like [interpolateCubehelixGammaLong], but does not use the shortest path
/// between hues.
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/cubehelixLong.png" width="100%" height="40" alt="cubehelixLong">
String Function(num) interpolateCubehelixLong(Object? a, Object? b) =>
    interpolateCubehelixGammaLong(1)(a, b);
