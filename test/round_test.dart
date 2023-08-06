import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test(
      "interpolateRound(a, b) interpolates between two numbers a and b, and then rounds",
      () {
    final i = interpolateRound(10, 42);
    expect(i(0.0), 10);
    expect(i(0.1), 13);
    expect(i(0.2), 16);
    expect(i(0.3), 20);
    expect(i(0.4), 23);
    expect(i(0.5), 26);
    expect(i(0.6), 29);
    expect(i(0.7), 32);
    expect(i(0.8), 36);
    expect(i(0.9), 39);
    expect(i(1.0), 42);
  });

  test("interpolateRound(a, b) does not pre-round a and b", () {
    final i = interpolateRound(2.6, 3.6);
    expect(i(0.6), 3);
  });

  test("interpolateRound(a, b) gives exact ends for t=0 and t=1", () {
    final a = 2e+42.round(), b = 335;
    expect(interpolateRound(a, b)(1), b);
    expect(interpolateRound(a, b)(0), a);
  });
}
