import 'package:d4_color/d4_color.dart';
import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test(
      "interpolate(a, b) interpolates strings if b is a string and not a color",
      () {
    expect(interpolate("foo", "bar")(0.5), "bar");
  });

  test(
      "interpolate(a, b) interpolates strings if b is a string and not a color, even if b is coercible to a number",
      () {
    expect(interpolate("1", "2")(0.5), "1.5");
    expect(interpolate(" 1", " 2")(0.5), " 1.5");
  });

  test("interpolate(a, b) interpolates RGB colors if b is a string and a color",
      () {
    expect(interpolate("red", "blue")(0.5), "rgb(128, 0, 128)");
    expect(interpolate("#ff0000", "#0000ff")(0.5), "rgb(128, 0, 128)");
    expect(interpolate("#f00", "#00f")(0.5), "rgb(128, 0, 128)");
    expect(interpolate("rgb(255, 0, 0)", "rgb(0, 0, 255)")(0.5),
        "rgb(128, 0, 128)");
    expect(interpolate("rgba(255, 0, 0, 1.0)", "rgba(0, 0, 255, 1.0)")(0.5),
        "rgb(128, 0, 128)");
    expect(interpolate("rgb(100%, 0%, 0%)", "rgb(0%, 0%, 100%)")(0.5),
        "rgb(128, 0, 128)");
    expect(
        interpolate("rgba(100%, 0%, 0%, 1.0)", "rgba(0%, 0%, 100%, 1.0)")(0.5),
        "rgb(128, 0, 128)");
    expect(
        interpolate("rgba(100%, 0%, 0%, 0.5)", "rgba(0%, 0%, 100%, 0.7)")(0.5),
        "rgba(128, 0, 128, 0.6)");
  });

  test("interpolate(a, b) interpolates RGB colors if b is a color", () {
    expect(interpolate("red", Rgb.from("blue"))(0.5), "rgb(128, 0, 128)");
    expect(interpolate("red", Hsl.from("blue"))(0.5), "rgb(128, 0, 128)");
  });

  test("interpolate(a, b) interpolates arrays if b is an array", () {
    expect(interpolate(["red"], ["blue"])(0.5), ["rgb(128, 0, 128)"]);
  });

  test(
      "interpolate(a, b) interpolates arrays if b is an array, even if b is coercible to a number",
      () {
    expect(interpolate([1], [2])(0.5), [1.5]);
  });

  test("interpolate(a, b) interpolates numbers if b is a number", () {
    expect(interpolate(1, 2)(0.5), 1.5);
    expect(interpolate(1, double.nan)(0.5), isNaN);
  });

  test(
      "interpolate(a, b) interpolates objects if b is an object that is not coercible to a number",
      () {
    expect(interpolate({"color": "red"}, {"color": "blue"})(0.5),
        {"color": "rgb(128, 0, 128)"});
  });

  test("interpolate(a, b) interpolates dates if b is a date", () {
    final i = interpolate(DateTime(2000, 0, 1), DateTime(2000, 0, 2));
    final d = i(0.5);
    expect(d, isA<DateTime>());
    expect((i(0.5) as DateTime).millisecondsSinceEpoch,
        DateTime(2000, 0, 1, 12).millisecondsSinceEpoch);
  });

  test("interpolate(a, b) returns the constant b if b is null or a boolean",
      () {
    expect(interpolate(0, null)(0.5), null);
    expect(interpolate(0, true)(0.5), true);
    expect(interpolate(0, false)(0.5), false);
  });

/*test("interpolate(a, b) interpolates objects without prototype", () {
  expect(interpolate(noproto({foo: 0}), noproto({foo: 2}))(0.5), {foo: 1});
});

test("interpolate(a, b) interpolates objects with numeric valueOf as numbers", () {
  const proto = {valueOf: foo};
  expect(interpolate(noproto({foo: 0}, proto), noproto({foo: 2}, proto))(0.5), 1);
});

test("interpolate(a, b) interpolates objects with string valueOf as numbers if valueOf result is coercible to number", () {
  const proto = {valueOf: fooString};
  expect(interpolate(noproto({foo: 0}, proto), noproto({foo: 2}, proto))(0.5), 1);
});

// valueOf appears here as object because:
// - we use for-in loop and it will ignore only fields coming from built-in prototypes;
// - we replace functions with objects.
test("interpolate(a, b) interpolates objects with string valueOf as objects if valueOf result is not coercible to number", () {
  const proto = {valueOf: fooString};
  expect(interpolate(noproto({foo: "bar"}, proto), noproto({foo: "baz"}, proto))(0.5), {foo: "baz", valueOf: {}});
});

test("interpolate(a, b) interpolates objects with toString as numbers if toString result is coercible to number", () {
  const proto = {toString: fooString};
  expect(interpolate(noproto({foo: 0}, proto), noproto({foo: 2}, proto))(0.5), 1);
});

// toString appears here as object because:
// - we use for-in loop and it will ignore only fields coming from built-in prototypes;
// - we replace functions with objects.
test("interpolate(a, b) interpolates objects with toString as objects if toString result is not coercible to number", () {
  const proto = {toString: fooString};
  expect(interpolate(noproto({foo: "bar"}, proto), noproto({foo: "baz"}, proto))(0.5), {foo: "baz", toString: {}});
});

test("interpolate(a, b) interpolates number arrays if b is a typed array", () {
  expect(interpolate([0, 0], Float64Array.of(-1, 1))(0.5), Float64Array.of(-0.5, 0.5));
  expect(interpolate([0, 0], Float64Array.of(-1, 1))(0.5) instanceof Float64Array);
  expect(interpolate([0, 0], Float32Array.of(-1, 1))(0.5), Float32Array.of(-0.5, 0.5));
  expect(interpolate([0, 0], Float32Array.of(-1, 1))(0.5) instanceof Float32Array);
  expect(interpolate([0, 0], Uint32Array.of(-2, 2))(0.5), Uint32Array.of(Math.pow(2, 31) - 1, 1));
  expect(interpolate([0, 0], Uint32Array.of(-1, 1))(0.5) instanceof Uint32Array);
  expect(interpolate([0, 0], Uint8Array.of(-2, 2))(0.5), Uint8Array.of(Math.pow(2, 7) - 1, 1));
  expect(interpolate([0, 0], Uint8Array.of(-1, 1))(0.5) instanceof Uint8Array);
});*/
}
