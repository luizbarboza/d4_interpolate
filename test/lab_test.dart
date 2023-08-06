import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateLab(a, b) converts a and b to Lab colors", () {
    expect(interpolateLab("steelblue", "brown")(0),
        Rgb.from("steelblue").toString());
    expect(interpolateLab("steelblue", Hsl.from("brown"))(1),
        Rgb.from("brown").toString());
    expect(interpolateLab("steelblue", Rgb.from("brown"))(1),
        Rgb.from("brown").toString());
  });

  test("interpolateLab(a, b) interpolates in Lab and returns an RGB string",
      () {
    expect(interpolateLab("steelblue", "#f00")(0.2), "rgb(134, 120, 146)");
    expect(interpolateLab("rgba(70, 130, 180, 1)", "rgba(255, 0, 0, 0.2)")(0.2),
        "rgba(134, 120, 146, 0.84)");
  });

  test(
      "interpolateLab(a, b) uses b’s channel value when a’s channel value is undefined",
      () {
    expect(
        interpolateLab(null, Lab(20, 40, 60))(0.5), Lab(20, 40, 60).toString());
    expect(interpolateLab(Lab(double.nan, 20, 40), Lab(60, 80, 100))(0.5),
        Lab(60, 50, 70).toString());
    expect(interpolateLab(Lab(20, double.nan, 40), Lab(60, 80, 100))(0.5),
        Lab(40, 80, 70).toString());
    expect(interpolateLab(Lab(20, 40, double.nan), Lab(60, 80, 100))(0.5),
        Lab(40, 60, 100).toString());
  });

  test(
      "interpolateLab(a, b) uses a’s channel value when b’s channel value is undefined",
      () {
    expect(
        interpolateLab(Lab(20, 40, 60), null)(0.5), Lab(20, 40, 60).toString());
    expect(interpolateLab(Lab(60, 80, 100), Lab(double.nan, 20, 40))(0.5),
        Lab(60, 50, 70).toString());
    expect(interpolateLab(Lab(60, 80, 100), Lab(20, double.nan, 40))(0.5),
        Lab(40, 80, 70).toString());
    expect(interpolateLab(Lab(60, 80, 100), Lab(20, 40, double.nan))(0.5),
        Lab(40, 60, 100).toString());
  });
}
