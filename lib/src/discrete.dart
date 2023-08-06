import 'dart:math';

/// Returns a discrete interpolator for the given list of [values].
///
/// The returned interpolator maps *t* in \[0, 1 / *n*) to [values]\[0\], *t* in
/// \[1 / *n*, 2 / *n*) to [values]\[1\], and so on, where *n* =
/// [values].length. In effect, this is a lightweight
/// [quantize scale](https://github.com/d3/d3-scale/blob/master/README.md#quantize-scales)
/// with a fixed domain of \[0, 1\].
Object? Function(num) interpolateDiscrete(List<Object?> values) {
  var n = values.length;
  return (t) {
    if (t.isNaN) return null;
    return values.elementAtOrNull(max(0, min(n - 1, (t * n).floor())));
  };
}
