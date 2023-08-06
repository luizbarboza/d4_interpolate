import 'basis.dart';

/// Returns a uniform nonrational B-spline interpolator through the specified
/// list of [values], which must be numbers.
///
/// The control points are implicitly repeated such that the resulting
/// one-dimensional spline has cyclical C² continuity when repeated around *t*
/// in \[0,1\]. See also
/// [d3.curveBasisClosed](https://github.com/d3/d3-shape/blob/master/README.md#curveBasisClosed).
num Function(num) interpolateBasisClosed(List<num> values) {
  var n = values.length;
  return (num t) {
    var i = (((t %= 1) < 0 ? ++t : t) * n).floor(),
        v0 = values[(i + n - 1) % n],
        v1 = values[i % n],
        v2 = values[(i + 1) % n],
        v3 = values[(i + 2) % n];
    return basis((t - i / n) * n, v0, v1, v2, v3);
  };
}
