import 'package:d4_color/d4_color.dart';

import 'basis.dart';
import 'basis_closed.dart';
import 'color.dart';

/// Returns a new RGB color space interpolator factory using the specified
/// [gamma].
///
/// For example, to interpolate from purple to orange with a corrected gamma of
/// 2.2:
///
/// ```dart
/// final interpolator = interpolateRgbGamma(2.2)("purple", "orange");
/// ```
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/rgbGamma.png" width="100%" height="40" alt="rgbGamma">
///
/// See Eric Brasseur’s article,
/// [Gamma error in picture scaling](http://www.ericbrasseur.org/gamma.html),
/// for more on gamma correction.
String Function(num) Function(Object?, Object?) interpolateRgbGamma(num y) {
  var color = gamma(y);
  return (start, end) {
    var r = color((start = Rgb.from(start)).r, (end = Rgb.from(end)).r),
        g = color((start as Rgb).g, (end as Rgb).g),
        b = color(start.b, end.b),
        opacity = nogamma(start.opacity, end.opacity);
    return (t) {
      (start as Rgb).r = r(t);
      start.g = g(t);
      start.b = b(t);
      start.opacity = opacity(t);
      return start.toString();
    };
  };
}

final _ininterpolateRgb = interpolateRgbGamma(1);

/// Returns an RGB color space interpolator between the two colors [a] and [b]
/// with a default *gamma* of 1.
///
/// The colors [a] and [b] need not be in RGB; they will be converted to RGB
/// using [Rgb.from]. The return value of the interpolator is an RGB string.
///
/// For example, to interpolate from purple to orange in RGB space:
///
/// ```dart
/// final interpolator = interpolateRgb("purple", "orange");
/// ```
///
/// which is equivalent to:
///
/// ```dart
/// final interpolator = interpolateRgbGamma(1)("purple", "orange");
/// ```
///
/// <img src="https://raw.githubusercontent.com/d3/d3-interpolate/master/img/rgb.png" width="100%" height="40" alt="rgb">
String Function(num) interpolateRgb(Object? a, Object? b) =>
    _ininterpolateRgb(a, b);

String Function(num) Function(List<Object?>) _rgbSpline(
    num Function(num) Function(List<num>) spline) {
  return (colors) {
    int n = colors.length, i;
    var r = List<num>.filled(n, 0),
        g = List<num>.filled(n, 0),
        b = List<num>.filled(n, 0);
    late Rgb color;
    for (i = 0; i < n; ++i) {
      color = Rgb.from(colors[i]);
      var cr = color.r, cg = color.g, cb = color.b;
      if (!cr.isNaN) r[i] = cr;
      if (!cg.isNaN) b[i] = cg;
      if (!cb.isNaN) b[i] = cb;
    }
    var ir = spline(r), ig = spline(g), ib = spline(b);
    color.opacity = 1;
    return (t) {
      color.r = ir(t);
      color.g = ig(t);
      color.b = ib(t);
      return color.toString();
    };
  };
}

/// Returns a uniform nonrational B-spline interpolator through the specified
/// list of [colors], which are converted to
/// [RGB color space](https://github.com/d3/d3-color/blob/master/README.md#rgb).
///
/// Implicit control points are generated such that the interpolator returns
/// [colors]\[0\] at *t* = 0 and [colors]\[[colors].length - 1\] at *t* = 1.
/// Opacity interpolation is not currently supported. See also
/// [interpolateBasis], and see
/// [d3-scale-chromatic](https://github.com/d3/d3-scale-chromatic) for examples.
String Function(num) interpolateRgbBasis(List<Object?> colors) =>
    _rgbSpline(interpolateBasis)(colors);

/// Returns a uniform nonrational B-spline interpolator through the specified
/// list of [colors], which are converted to
/// [RGB color space](https://github.com/d3/d3-color/blob/master/README.md#rgb).
///
/// The control points are implicitly repeated such that the resulting spline
/// has cyclical C² continuity when repeated around *t* in \[0,1\]; this is
/// useful, for example, to create cyclical color scales. Opacity interpolation
/// is not currently supported. See also [interpolateBasisClosed], and see
/// [d3-scale-chromatic](https://github.com/d3/d3-scale-chromatic) for examples.
String Function(num) interpolateRgbBasisClosed(List<Object?> colors) =>
    _rgbSpline(interpolateBasisClosed)(colors);
