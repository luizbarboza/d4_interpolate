import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateDiscrete(values)(t) returns the expected values", () {
    final i = interpolateDiscrete("abcde".split(""));
    expect(i(-1), "a");
    expect(i(0), "a");
    expect(i(0.19), "a");
    expect(i(0.21), "b");
    expect(i(1), "e");
  });

  test("interpolateDiscrete([0, 1]) is equivalent to similar to .round", () {
    final i = interpolateDiscrete([0, 1]);
    expect(i(-1), 0);
    expect(i(0), 0);
    expect(i(0.49), 0);
    expect(i(0.51), 1);
    expect(i(1), 1);
    expect(i(2), 1);
  });

  test("interpolateDiscrete(…)(double.nan) returned null", () {
    final i = interpolateDiscrete([0, 1]);
    expect(i(double.nan), null);
  });
}
