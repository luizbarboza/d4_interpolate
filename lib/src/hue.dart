import 'color.dart';

/// Returns an interpolator between the two hue angles [a] and [b].
///
/// If either hue is [double.nan], the opposing value is used. The shortest path
/// between hues is used. The return value of the interpolator is a number in
/// \[0, 360).
num Function(num) interpolateHue(num a, num b) {
  var i = hue(a, b);
  return (t) {
    var x = i(t);
    return x - 360 * (x / 360).floorToDouble();
  };
}
