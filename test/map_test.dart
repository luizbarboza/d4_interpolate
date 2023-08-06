import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateMap(a, b) interpolates defined properties in a and b", () {
    expect(interpolateMap({"a": 2, "b": 12}, {"a": 4, "b": 24})(0.5),
        {"a": 3, "b": 18});
  });

  test("interpolateMap(a, b) interpolates color properties as rgb", () {
    expect(interpolateMap({"background": "red"}, {"background": "green"})(0.5),
        {"background": "rgb(128, 64, 0)"});
    expect(interpolateMap({"fill": "red"}, {"fill": "green"})(0.5),
        {"fill": "rgb(128, 64, 0)"});
    expect(interpolateMap({"stroke": "red"}, {"stroke": "green"})(0.5),
        {"stroke": "rgb(128, 64, 0)"});
    expect(interpolateMap({"color": "red"}, {"color": "green"})(0.5),
        {"color": "rgb(128, 64, 0)"});
  });

  test("interpolateMap(a, b) interpolates nested objects and arrays", () {
    expect(
        interpolateMap({
          "foo": [2, 12]
        }, {
          "foo": [4, 24]
        })(0.5),
        {
          "foo": [3, 18]
        });
    expect(
        interpolateMap({
          "foo": {
            "bar": [2, 12]
          }
        }, {
          "foo": {
            "bar": [4, 24]
          }
        })(0.5),
        {
          "foo": {
            "bar": [3, 18]
          }
        });
  });

  test("interpolateMap(a, b) ignores properties in a that are not in b", () {
    expect(interpolateMap({"foo": 2, "bar": 12}, {"foo": 4})(0.5), {"foo": 3});
  });

  test("interpolateMap(a, b) uses constant properties in b that are not in a",
      () {
    expect(interpolateMap({"foo": 2}, {"foo": 4, "bar": 12})(0.5),
        {"foo": 3, "bar": 12});
  });
}
