import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateHue(a, b) interpolate numbers", () {
    final i = interpolateHue(10, 20);
    expect(i(0.0), 10);
    expect(i(0.2), 12);
    expect(i(0.4), 14);
    expect(i(0.6), 16);
    expect(i(0.8), 18);
    expect(i(1.0), 20);
  });

  test("interpolateHue(a, b) returns a if b is NaN", () {
    final i = interpolateHue(10, double.nan);
    expect(i(0.0), 10);
    expect(i(0.5), 10);
    expect(i(1.0), 10);
  });

  test("interpolateHue(a, b) returns b if a is NaN", () {
    final i = interpolateHue(double.nan, 20);
    expect(i(0.0), 20);
    expect(i(0.5), 20);
    expect(i(1.0), 20);
  });

  test("interpolateHue(a, b) returns NaN if both a and b are NaN", () {
    final i = interpolateHue(double.nan, double.nan);
    expect(i(0.0), isNaN);
    expect(i(0.5), isNaN);
    expect(i(1.0), isNaN);
  });

  test("interpolateHue(a, b) uses the shortest path", () {
    final i = interpolateHue(10, 350);
    expect(i(0.0), 10);
    expect(i(0.2), 6);
    expect(i(0.4), 2);
    expect(i(0.6), 358);
    expect(i(0.8), 354);
    expect(i(1.0), 350);
  });
}
