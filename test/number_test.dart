import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateNumber(a, b) interpolates between two numbers a and b", () {
    final i = interpolateNumber(10, 42);
    expect(i(0.0), closeTo(10.0, 1e-6));
    expect(i(0.1), closeTo(13.2, 1e-6));
    expect(i(0.2), closeTo(16.4, 1e-6));
    expect(i(0.3), closeTo(19.6, 1e-6));
    expect(i(0.4), closeTo(22.8, 1e-6));
    expect(i(0.5), closeTo(26.0, 1e-6));
    expect(i(0.6), closeTo(29.2, 1e-6));
    expect(i(0.7), closeTo(32.4, 1e-6));
    expect(i(0.8), closeTo(35.6, 1e-6));
    expect(i(0.9), closeTo(38.8, 1e-6));
    expect(i(1.0), closeTo(42.0, 1e-6));
  });

  test("interpolateNumber(a, b) gives exact ends for t=0 and t=1", () {
    final a = 2e+42, b = 335;
    expect(interpolateNumber(a, b)(1), b);
    expect(interpolateNumber(a, b)(0), a);
  });
}
