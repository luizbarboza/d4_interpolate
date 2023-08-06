import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateHclLong(a, b) converts a and b to HCL colors", () {
    expect(interpolateHclLong("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateHclLong("steelblue", Hcl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateHclLong("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateHclLong(a, b) interpolates in HCL and returns an RGB string",
      () {
    expect(interpolateHclLong("steelblue", "#f00")(0.2), "rgb(0, 144, 169)");
    expect(
        interpolateHclLong("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(
            0.2),
        "rgba(0, 144, 169, 0.84)");
  });

  test(
      "interpolateHclLong(a, b) does not use the shortest path when interpolating hue",
      () {
    final i = interpolateHclLong(Hcl(10, 50, 50), Hcl(350, 50, 50));
    expect(i(0.0), "rgb(194, 78, 107)");
    expect(i(0.2), "rgb(151, 111, 28)");
    expect(i(0.4), "rgb(35, 136, 68)");
    expect(i(0.6), "rgb(0, 138, 165)");
    expect(i(0.8), "rgb(91, 116, 203)");
    expect(i(1.0), "rgb(189, 79, 136)");
  });

  test("interpolateHclLong(a, b) uses a’s hue when b’s hue is undefined", () {
    expect(interpolateHclLong("#f60", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(155, 0, 0)");
    expect(interpolateHclLong("#6f0", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(0, 129, 0)");
  });

  test("interpolateHclLong(a, b) uses b’s hue when a’s hue is undefined", () {
    expect(interpolateHclLong(Hcl(double.nan, double.nan, 0), "#f60")(0.5),
        "rgb(155, 0, 0)");
    expect(interpolateHclLong(Hcl(double.nan, double.nan, 0), "#6f0")(0.5),
        "rgb(0, 129, 0)");
  });

  test("interpolateHclLong(a, b) uses a’s chroma when b’s chroma is undefined",
      () {
    expect(interpolateHclLong("#ccc", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(97, 97, 97)");
    expect(interpolateHclLong("#f00", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(166, 0, 0)");
  });

  test("interpolateHclLong(a, b) uses b’s chroma when a’s chroma is undefined",
      () {
    expect(interpolateHclLong(Hcl(double.nan, double.nan, 0), "#ccc")(0.5),
        "rgb(97, 97, 97)");
    expect(interpolateHclLong(Hcl(double.nan, double.nan, 0), "#f00")(0.5),
        "rgb(166, 0, 0)");
  });

  test(
      "interpolateHclLong(a, b) uses b’s luminance when a’s luminance is undefined",
      () {
    expect(interpolateHclLong(null, Hcl(20, 80, 50))(0.5), "rgb(230, 13, 79)");
  });

  test(
      "interpolateHclLong(a, b) uses a’s luminance when b’s luminance is undefined",
      () {
    expect(interpolateHclLong(Hcl(20, 80, 50), null)(0.5), "rgb(230, 13, 79)");
  });
}
