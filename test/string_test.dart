import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateString(a, b) interpolates matching numbers in a and b", () {
    expect(
        interpolateString(" 10/20 30", "50/10 100 ")(0.2), "18.0/18.0 44.0 ");
    expect(
        interpolateString(" 10/20 30", "50/10 100 ")(0.4), "26.0/16.0 58.0 ");
  });

  test("interpolateString(a, b) preserves non-numbers in string b", () {
    expect(interpolateString(" 10/20 30", "50/10 foo ")(0.2), "18.0/18.0 foo ");
    expect(interpolateString(" 10/20 30", "50/10 foo ")(0.4), "26.0/16.0 foo ");
  });

  test("interpolateString(a, b) preserves non-matching numbers in string b",
      () {
    expect(interpolateString(" 10.0/20.0 foo", "50/10 100 ")(0.2),
        "18.0/18.0 100 ");
    expect(interpolateString(" 10.0/20.0 bar", "50/10 100 ")(0.4),
        "26.0/16.0 100 ");
  });

  test("interpolateString(a, b) preserves equal-value numbers in both strings",
      () {
    expect(interpolateString(" 10/20 100 20", "50/10 100, 20 ")(0.2),
        "18.0/18.0 100, 20 ");
    expect(interpolateString(" 10/20 100 20", "50/10 100, 20 ")(0.4),
        "26.0/16.0 100, 20 ");
  });

  test("interpolateString(a, b) interpolates decimal notation correctly", () {
    expect(interpolateString("1.", "2.")(0.5), "1.5");
  });

  test("interpolateString(a, b) interpolates exponent notation correctly", () {
    expect(interpolateString("1e+3", "1e+4")(0.5), "5500.0");
    expect(interpolateString("1e-3", "1e-4")(0.5), "0.00055");
    expect(interpolateString("1.e-3", "1.e-4")(0.5), "0.00055");
    expect(interpolateString("-1.e-3", "-1.e-4")(0.5), "-0.00055");
    expect(interpolateString("+1.e-3", "+1.e-4")(0.5), "0.00055");
    expect(interpolateString(".1e-2", ".1e-3")(0.5), "0.00055");
  });

  test("interpolateString(a, b) with no numbers, returns the target string",
      () {
    expect(interpolateString("foo", "bar")(0.5), "bar");
    expect(interpolateString("foo", "")(0.5), "");
    expect(interpolateString("", "bar")(0.5), "bar");
    expect(interpolateString("", "")(0.5), "");
  });

  test(
      "interpolateString(a, b) with two numerically-equivalent numbers, returns the default format",
      () {
    expect(interpolateString("top: 1000px;", "top: 1e3px;")(0.5),
        "top: 1000.0px;");
    expect(interpolateString("top: 1e3px;", "top: 1000px;")(0.5),
        "top: 1000.0px;");
  });
}
