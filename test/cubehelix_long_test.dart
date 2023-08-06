import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateCubehelixLong(a, b) converts a and b to Cubehelix colors",
      () {
    expect(interpolateCubehelixLong("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateCubehelixLong("steelblue", Hcl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateCubehelixLong("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test(
      "interpolateCubehelixLong(a, b) interpolates in Cubehelix and returns an RGB string",
      () {
    expect(interpolateCubehelixLong("steelblue", "#f00")(0.2),
        "rgb(88, 100, 218)");
    expect(
        interpolateCubehelixLong(
            "rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(0.2),
        "rgba(88, 100, 218, 0.84)");
  });

  test("interpolateCubehelixLong.gamma(3)(a, b) returns the expected values",
      () {
    expect(interpolateCubehelixGammaLong(3)("steelblue", "#f00")(0.2),
        "rgb(96, 107, 228)");
  });

  test(
      "interpolateCubehelixLong(a, b) is equivalent to interpolateCubehelixLong.gamma(1)(a, b)",
      () {
    final i0 = interpolateCubehelixGammaLong(1)("purple", "orange"),
        i1 = interpolateCubehelixLong("purple", "orange");
    expect(i1(0.0), i0(0.0));
    expect(i1(0.2), i0(0.2));
    expect(i1(0.4), i0(0.4));
    expect(i1(0.6), i0(0.6));
    expect(i1(0.8), i0(0.8));
    expect(i1(1.0), i0(1.0));
  });
  test(
      "interpolateCubehelixLong(a, b) uses the longest path when interpolating hue difference greater than 180°",
      () {
    final i = interpolateCubehelixLong("purple", "orange");
    expect(i(0.0), "rgb(128, 0, 128)");
    expect(i(0.2), "rgb(63, 54, 234)");
    expect(i(0.4), "rgb(0, 151, 217)");
    expect(i(0.6), "rgb(0, 223, 83)");
    expect(i(0.8), "rgb(79, 219, 0)");
    expect(i(1.0), "rgb(255, 165, 0)");
  });

  test("interpolateCubehelixLong(a, b) uses a’s hue when b’s hue is undefined",
      () {
    expect(
        interpolateCubehelixLong("#f60", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(162, 41, 0)");
    expect(
        interpolateCubehelixLong("#6f0", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(3, 173, 0)");
  });

  test("interpolateCubehelixLong(a, b) uses b’s hue when a’s hue is undefined",
      () {
    expect(
        interpolateCubehelixLong(Hcl(double.nan, double.nan, 0), "#f60")(0.5),
        "rgb(162, 41, 0)");
    expect(
        interpolateCubehelixLong(Hcl(double.nan, double.nan, 0), "#6f0")(0.5),
        "rgb(3, 173, 0)");
  });

  test(
      "interpolateCubehelixLong(a, b) uses a’s chroma when b’s chroma is undefined",
      () {
    expect(
        interpolateCubehelixLong("#ccc", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(102, 102, 102)");
    expect(
        interpolateCubehelixLong("#f00", Hcl(double.nan, double.nan, 0))(0.5),
        "rgb(147, 0, 0)");
  });

  test(
      "interpolateCubehelixLong(a, b) uses b’s chroma when a’s chroma is undefined",
      () {
    expect(
        interpolateCubehelixLong(Hcl(double.nan, double.nan, 0), "#ccc")(0.5),
        "rgb(102, 102, 102)");
    expect(
        interpolateCubehelixLong(Hcl(double.nan, double.nan, 0), "#f00")(0.5),
        "rgb(147, 0, 0)");
  });

  test(
      "interpolateCubehelixLong(a, b) uses b’s luminance when a’s luminance is undefined",
      () {
    expect(interpolateCubehelixLong(null, Cubehelix(20, 1.5, 0.5))(0.5),
        "rgb(248, 93, 0)");
  });

  test(
      "interpolateCubehelixLong(a, b) uses a’s luminance when b’s luminance is undefined",
      () {
    expect(interpolateCubehelixLong(Cubehelix(20, 1.5, 0.5), null)(0.5),
        "rgb(248, 93, 0)");
  });
}
