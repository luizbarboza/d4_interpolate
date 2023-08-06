import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateRgb(a, b) converts a and b to RGB colors", () {
    expect(interpolateRgb("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateRgb("steelblue", Hsl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateRgb("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateRgb(a, b) interpolates in RGB and returns an RGB string",
      () {
    expect(interpolateRgb("steelblue", "#f00")(0.2), "rgb(107, 104, 144)");
    expect(interpolateRgb("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(0.2),
        "rgba(107, 104, 144, 0.84)");
  });

  test(
      "interpolateRgb(a, b) uses b’s channel value when a’s channel value is undefined",
      () {
    expect(
        interpolateRgb(null, Rgb(20, 40, 60))(0.5), Rgb(20, 40, 60).toString());
    expect(interpolateRgb(Rgb(double.nan, 20, 40), Rgb(60, 80, 100))(0.5),
        Rgb(60, 50, 70).toString());
    expect(interpolateRgb(Rgb(20, double.nan, 40), Rgb(60, 80, 100))(0.5),
        Rgb(40, 80, 70).toString());
    expect(interpolateRgb(Rgb(20, 40, double.nan), Rgb(60, 80, 100))(0.5),
        Rgb(40, 60, 100).toString());
  });

  test(
      "interpolateRgb(a, b) uses a’s channel value when b’s channel value is undefined",
      () {
    expect(
        interpolateRgb(Rgb(20, 40, 60), null)(0.5), Rgb(20, 40, 60).toString());
    expect(interpolateRgb(Rgb(60, 80, 100), Rgb(double.nan, 20, 40))(0.5),
        Rgb(60, 50, 70).toString());
    expect(interpolateRgb(Rgb(60, 80, 100), Rgb(20, double.nan, 40))(0.5),
        Rgb(40, 80, 70).toString());
    expect(interpolateRgb(Rgb(60, 80, 100), Rgb(20, 40, double.nan))(0.5),
        Rgb(40, 60, 100).toString());
  });

  test("interpolateRgb.gamma(3)(a, b) returns the expected values", () {
    expect(
        interpolateRgbGamma(3)("steelblue", "#f00")(0.2), "rgb(153, 121, 167)");
  });

  test("interpolateRgb.gamma(3)(a, b) uses linear interpolation for opacity",
      () {
    expect(interpolateRgbGamma(3)("transparent", "#f00")(0.2),
        "rgba(255, 0, 0, 0.2)");
  });

  test("interpolateRgb(a, b) is equivalent to interpolateRgb.gamma(1)(a, b)",
      () {
    final i0 = interpolateRgbGamma(1)("purple", "orange");
    final i1 = interpolateRgb("purple", "orange");
    expect(i1(0.0), i0(0.0));
    expect(i1(0.2), i0(0.2));
    expect(i1(0.4), i0(0.4));
    expect(i1(0.6), i0(0.6));
    expect(i1(0.8), i0(0.8));
    expect(i1(1.0), i0(1.0));
  });
}
