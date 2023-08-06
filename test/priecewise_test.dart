import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("piecewise(interpolate, values)(t) returns the expected values", () {
    final i = piecewise([0, 2, 10], interpolate);
    expect(i(-1), -4);
    expect(i(0), 0);
    expect(i(0.19), 0.76);
    expect(i(0.21), 0.84);
    expect(i(0.5), 2);
    expect(i(0.75), 6);
    expect(i(1), 10);
  });

  test("piecewise(values) uses the default interpolator", () {
    final i = piecewise([0, 2, 10]);
    expect(i(-1), -4);
    expect(i(0), 0);
    expect(i(0.19), 0.76);
    expect(i(0.21), 0.84);
    expect(i(0.5), 2);
    expect(i(0.75), 6);
    expect(i(1), 10);
  });

  test("piecewise(values) uses the default interpolator/2", () {
    final i = piecewise(["a0", "a2", "a10"]);
    expect(i(-1), "a-4");
    expect(i(0), "a0");
    expect(i(0.19), "a0.76");
    expect(i(0.21), "a0.84");
    expect(i(0.5), "a2.0");
    expect(i(0.75), "a6.0");
    expect(i(1), "a10");
  });
}
