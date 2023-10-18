num basis(num t1, num v0, num v1, num v2, num v3) {
  var t2 = t1 * t1, t3 = t2 * t1;
  return ((1 - 3 * t1 + 3 * t2 - t3) * v0 +
          (4 - 6 * t2 + 3 * t3) * v1 +
          (1 + 3 * t1 + 3 * t2 - 3 * t3) * v2 +
          t3 * v3) /
      6;
}

/// Returns a uniform nonrational B-spline interpolator through the specified
/// list of [values], which must be numbers.
///
/// Implicit control points are generated such that the interpolator returns
/// [values]\[0\] at *t* = 0 and [values]\[[values].length - 1\] at *t* = 1. See
/// also
/// [d3.curveBasis](https://github.com/d3/d3-shape/blob/master/README.md#curveBasis).
///
/// {@category Value interpolation}
num Function(num) interpolateBasis(List<num> values) {
  var n = values.length - 1;
  return (num t) {
    int i;
    if (t <= 0) {
      t = 0;
      i = 0;
    } else if (t >= 1) {
      t = 1;
      i = n - 1;
    } else {
      t = t * n;
      i = t.floor();
    }
    var v1 = values[i],
        v2 = values[i + 1],
        v0 = i > 0 ? values[i - 1] : 2 * v1 - v2,
        v3 = i < n - 1 ? values[i + 2] : 2 * v2 - v1;
    return basis((t - i / n) * n, v0, v1, v2, v3);
  };
}
