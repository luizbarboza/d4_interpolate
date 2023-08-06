import 'dart:typed_data';

import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateList(a, b) interpolates defined elements in a and b", () {
    expect(interpolateList([2, 12], [4, 24])(0.5), [3, 18]);
  });

  test("interpolateList(a, b) interpolates nested objects and arrays", () {
    expect(
        interpolateList([
          [2, 12]
        ], [
          [4, 24]
        ])(0.5),
        [
          [3, 18]
        ]);
    expect(
        interpolateList([
          {
            "foo": [2, 12]
          }
        ], [
          {
            "foo": [4, 24]
          }
        ])(0.5),
        [
          {
            "foo": [3, 18]
          }
        ]);
  });

  test("interpolateList(a, b) ignores elements in a that are not in b", () {
    expect(interpolateList([2, 12, 12], [4, 24])(0.5), [3, 18]);
  });

  test("interpolateList(a, b) uses constant elements in b that are not in a",
      () {
    expect(interpolateList([2, 12], [4, 24, 12])(0.5), [3, 18, 12]);
  });

  test("interpolateList(a, b) interpolates array-like objects", () {
    final array = Float64List(2);
    array[0] = 2;
    array[1] = 12;
    expect(interpolateList(array, [4, 24])(0.5), [3, 18]);
  });

  test("interpolateList(a, b) gives exact ends for t=0 and t=1", () {
    const a = [2e+42], b = [335];
    expect(interpolateList(a, b)(1), b);
    expect(interpolateList(a, b)(0), a);
  });
}
