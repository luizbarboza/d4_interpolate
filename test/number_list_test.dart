import 'dart:typed_data';

import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateNumberList(a, b) interpolates defined elements in a and b",
      () {
    expect(
        interpolateNumberList(
            Float64List.fromList([2, 12]), Float64List.fromList([4, 24]))(0.5),
        Float64List.fromList([3, 18]));
  });

  test("interpolateNumberList(a, b) ignores elements in a that are not in b",
      () {
    expect(
        interpolateNumberList(Float64List.fromList([2, 12, 12]),
            Float64List.fromList([4, 24]))(0.5),
        Float64List.fromList([3, 18]));
  });

  test(
      "interpolateNumberList(a, b) uses constant elements in b that are not in a",
      () {
    expect(
        interpolateNumberList(Float64List.fromList([2, 12]),
            Float64List.fromList([4, 24, 12]))(0.5),
        Float64List.fromList([3, 18, 12]));
  });

  test("interpolateNumberList(a, b) uses b’s array type", () {
    expect(
        interpolateNumberList(Float64List.fromList([2, 12]),
            Float64List.fromList([4, 24, 12]))(0.5),
        isA<Float64List>());
    expect(
        interpolateNumberList(Float64List.fromList([2, 12]),
            Float32List.fromList([4, 24, 12]))(0.5),
        isA<Float32List>());
    expect(
        interpolateNumberList(Float64List.fromList([2, 12]),
            Uint8List.fromList([4, 24, 12]))(0.5),
        isA<Uint8List>());
    expect(
        interpolateNumberList(Float64List.fromList([2, 12]),
            Uint16List.fromList([4, 24, 12]))(0.5),
        isA<Uint16List>());
  });

  test("interpolateNumberList(a, b) works with unsigned data", () {
    expect(
        interpolateNumberList(
            Uint8List.fromList([1, 12]), Uint8List.fromList([255, 0]))(0.5),
        Uint8List.fromList([128, 6]));
  });

  test("interpolateNumberList(a, b) gives exact ends", () {
    final i = interpolateNumberList(
        Float64List.fromList([2e42]), Float64List.fromList([355]));
    expect(i(0), Float64List.fromList([2e42]));
    expect(i(1), Float64List.fromList([355]));
  });
}
