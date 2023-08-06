import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateHslLong(a, b) converts a and b to HSL colors", () {
    expect(interpolateHslLong("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateHslLong("steelblue", Hsl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateHslLong("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateHslLong(a, b) interpolates in HSL and returns an RGB string",
      () {
    expect(interpolateHslLong("steelblue", "#f00")(0.2), "rgb(56, 195, 162)");
    expect(
        interpolateHslLong("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(
            0.2),
        "rgba(56, 195, 162, 0.84)");
  });

  test(
      "interpolateHslLong(a, b) does not use the shortest path when interpolating hue",
      () {
    final i = interpolateHslLong("hsl(10,50%,50%)", "hsl(350,50%,50%)");
    expect(i(0.0), "rgb(191, 85, 64)");
    expect(i(0.2), "rgb(153, 191, 64)");
    expect(i(0.4), "rgb(64, 191, 119)");
    expect(i(0.6), "rgb(64, 119, 191)");
    expect(i(0.8), "rgb(153, 64, 191)");
    expect(i(1.0), "rgb(191, 64, 85)");
  });

  test("interpolateHslLong(a, b) uses a’s hue when b’s hue is undefined", () {
    expect(interpolateHslLong("#f60", "#000")(0.5), "rgb(128, 51, 0)");
    expect(interpolateHslLong("#6f0", "#fff")(0.5), "rgb(179, 255, 128)");
  });

  test("interpolateHslLong(a, b) uses b’s hue when a’s hue is undefined", () {
    expect(interpolateHslLong("#000", "#f60")(0.5), "rgb(128, 51, 0)");
    expect(interpolateHslLong("#fff", "#6f0")(0.5), "rgb(179, 255, 128)");
  });

  test(
      "interpolateHslLong(a, b) uses a’s saturation when b’s saturation is undefined",
      () {
    expect(interpolateHslLong("#ccc", "#000")(0.5), "rgb(102, 102, 102)");
    expect(interpolateHslLong("#f00", "#000")(0.5), "rgb(128, 0, 0)");
  });

  test(
      "interpolateHslLong(a, b) uses b’s saturation when a’s saturation is undefined",
      () {
    expect(interpolateHslLong("#000", "#ccc")(0.5), "rgb(102, 102, 102)");
    expect(interpolateHslLong("#000", "#f00")(0.5), "rgb(128, 0, 0)");
  });

  test(
      "interpolateHslLong(a, b) uses b’s lightness when a’s lightness is undefined",
      () {
    expect(interpolateHslLong(null, Hsl(20, 1.0, 0.5))(0.5), "rgb(255, 85, 0)");
  });

  test(
      "interpolateHslLong(a, b) uses a’s lightness when b’s lightness is undefined",
      () {
    expect(interpolateHslLong(Hsl(20, 1.0, 0.5), null)(0.5), "rgb(255, 85, 0)");
  });
}
