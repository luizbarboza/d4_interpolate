import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateHsl(a, b) converts a and b to HSL colors", () {
    expect(interpolateHsl("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateHsl("steelblue", Hsl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateHsl("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateHsl(a, b) interpolates in HSL and returns an RGB string",
      () {
    expect(interpolateHsl("steelblue", "#f00")(0.2), "rgb(56, 61, 195)");
    expect(interpolateHsl("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(0.2),
        "rgba(56, 61, 195, 0.84)");
  });

  test("interpolateHsl(a, b) uses the shortest path when interpolating hue",
      () {
    final i = interpolateHsl("hsl(10,50%,50%)", "hsl(350,50%,50%)");
    expect(i(0.0), "rgb(191, 85, 64)");
    expect(i(0.2), "rgb(191, 77, 64)");
    expect(i(0.4), "rgb(191, 68, 64)");
    expect(i(0.6), "rgb(191, 64, 68)");
    expect(i(0.8), "rgb(191, 64, 77)");
    expect(i(1.0), "rgb(191, 64, 85)");
  });

  test("interpolateHsl(a, b) uses a’s hue when b’s hue is undefined", () {
    expect(interpolateHsl("#f60", "#000")(0.5), "rgb(128, 51, 0)");
    expect(interpolateHsl("#6f0", "#fff")(0.5), "rgb(179, 255, 128)");
  });

  test("interpolateHsl(a, b) uses b’s hue when a’s hue is undefined", () {
    expect(interpolateHsl("#000", "#f60")(0.5), "rgb(128, 51, 0)");
    expect(interpolateHsl("#fff", "#6f0")(0.5), "rgb(179, 255, 128)");
  });

  test(
      "interpolateHsl(a, b) uses a’s saturation when b’s saturation is undefined",
      () {
    expect(interpolateHsl("#ccc", "#000")(0.5), "rgb(102, 102, 102)");
    expect(interpolateHsl("#f00", "#000")(0.5), "rgb(128, 0, 0)");
  });

  test(
      "interpolateHsl(a, b) uses b’s saturation when a’s saturation is undefined",
      () {
    expect(interpolateHsl("#000", "#ccc")(0.5), "rgb(102, 102, 102)");
    expect(interpolateHsl("#000", "#f00")(0.5), "rgb(128, 0, 0)");
  });

  test(
      "interpolateHsl(a, b) uses b’s lightness when a’s lightness is undefined",
      () {
    expect(interpolateHsl(null, Hsl(20, 1.0, 0.5))(0.5), "rgb(255, 85, 0)");
  });

  test(
      "interpolateHsl(a, b) uses a’s lightness when b’s lightness is undefined",
      () {
    expect(interpolateHsl(Hsl(20, 1.0, 0.5), null)(0.5), "rgb(255, 85, 0)");
  });
}
