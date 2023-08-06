/// Returns an interpolator between the two numbers [a] and [b].
///
/// The returned interpolator is equivalent to:
///
/// ```dart
/// interpolator(t) {
///   return a * (1 - t) + b * t;
/// }
/// ```
///
/// Caution: avoid interpolating to or from the number zero when the
/// interpolator is used to generate a string. When very small values are
/// stringified, they may be converted to scientific notation, which is an
/// invalid attribute or style property value in older browsers. For example,
/// the number `0.0000001` is converted to the string `"1e-7"`. This is
/// particularly noticeable with interpolating opacity. To avoid scientific
/// notation, start or end the transition at 1e-6: the smallest value that is
/// not stringified in scientific notation.
num Function(num) interpolateNumber(num a, num b) {
  return (t) {
    return a * (1 - t) + b * t;
  };
}

num test() {
  return 0.000001;
}

void main() {
  print(test());
}
