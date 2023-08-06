import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateHcl(a, b) converts a and b to HCL colors", () {
    expect(interpolateHcl("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateHcl("steelblue", Hcl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateHcl("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateHcl(a, b) interpolates in HCL and returns an RGB string",
      () {
    expect(interpolateHcl("steelblue", "#f00")(0.2), "rgb(106, 121, 206)");
    expect(interpolateHcl("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(0.2),
        "rgba(106, 121, 206, 0.84)");
  });

  test(
      "interpolateHcl(a, b) uses the shortest path when interpolating hue difference greater than 180°",
      () {
    final i = interpolateHcl(Hcl(10, 50, 50), Hcl(350, 50, 50));
    expect(i(0.0), "rgb(194, 78, 107)");
    expect(i(0.2), "rgb(194, 78, 113)");
    expect(i(0.4), "rgb(193, 78, 118)");
    expect(i(0.6), "rgb(192, 78, 124)");
    expect(i(0.8), "rgb(191, 78, 130)");
    expect(i(1.0), "rgb(189, 79, 136)");
  });

  test(
      "interpolateHcl(a, b) uses the shortest path when interpolating hue difference greater than 360°",
      () {
    final i = interpolateHcl(Hcl(10, 50, 50), Hcl(380, 50, 50));
    expect(i(0.0), "rgb(194, 78, 107)");
    expect(i(0.2), "rgb(194, 78, 104)");
    expect(i(0.4), "rgb(194, 79, 101)");
    expect(i(0.6), "rgb(194, 79, 98)");
    expect(i(0.8), "rgb(194, 80, 96)");
    expect(i(1.0), "rgb(194, 80, 93)");
  });

  test(
      "interpolateHcl(a, b) uses the shortest path when interpolating hue difference greater than 540°",
      () {
    final i = interpolateHcl(Hcl(10, 50, 50), Hcl(710, 50, 50));
    expect(i(0.0), "rgb(194, 78, 107)");
    expect(i(0.2), "rgb(194, 78, 113)");
    expect(i(0.4), "rgb(193, 78, 118)");
    expect(i(0.6), "rgb(192, 78, 124)");
    expect(i(0.8), "rgb(191, 78, 130)");
    expect(i(1.0), "rgb(189, 79, 136)");
  });

  test(
      "interpolateHcl(a, b) uses the shortest path when interpolating hue difference greater than 720°",
      () {
    final i = interpolateHcl(Hcl(10, 50, 50), Hcl(740, 50, 50));
    expect(i(0.0), "rgb(194, 78, 107)");
    expect(i(0.2), "rgb(194, 78, 104)");
    expect(i(0.4), "rgb(194, 79, 101)");
    expect(i(0.6), "rgb(194, 79, 98)");
    expect(i(0.8), "rgb(194, 80, 96)");
    expect(i(1.0), "rgb(194, 80, 93)");
  });

  test("interpolateHcl(a, b) uses a’s hue when b’s hue is undefined", () {
    expect(interpolateHcl("#f60", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(155, 0, 0)");
    expect(interpolateHcl("#6f0", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(0, 129, 0)");
  });

  test("interpolateHcl(a, b) uses b’s hue when a’s hue is undefined", () {
    expect(interpolateHcl(Hcl(double.nan, double.nan, 0), "#f60")(0.5),
        "rgb(155, 0, 0)");
    expect(interpolateHcl(Hcl(double.nan, double.nan, 0), "#6f0")(0.5),
        "rgb(0, 129, 0)");
  });

  test("interpolateHcl(a, b) uses a’s chroma when b’s chroma is undefined", () {
    expect(interpolateHcl("#ccc", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(97, 97, 97)");
    expect(interpolateHcl("#f00", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(166, 0, 0)");
  });

  test("interpolateHcl(a, b) uses b’s chroma when a’s chroma is undefined", () {
    expect(interpolateHcl(Hcl(double.nan, double.nan, 0), "#ccc")(0.5),
        "rgb(97, 97, 97)");
    expect(interpolateHcl(Hcl(double.nan, double.nan, 0), "#f00")(0.5),
        "rgb(166, 0, 0)");
  });

  test(
      "interpolateHcl(a, b) uses b’s luminance when a’s lumidouble.nance is undefined",
      () {
    expect(interpolateHcl(null, Hcl(20, 80, 50))(0.5), "rgb(230, 13, 79)");
  });

  test(
      "interpolateHcl(a, b) uses a’s luminance when b’s lumidouble.nance is undefined",
      () {
    expect(interpolateHcl(Hcl(20, 80, 50), null)(0.5), "rgb(230, 13, 79)");
  });
}
