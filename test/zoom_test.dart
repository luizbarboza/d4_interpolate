import 'dart:math';

import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

import 'matchers.dart';

void main() {
  test("interpolateZoom(a, b) handles nearly-coincident points", () {
    expect(
        interpolateZoom(
            (324.68721096803614, 59.43501602433761, 1.8827137399562621),
            (324.6872108946794, 59.43501601062763, 7.399052110984391))(0.5),
        (324.68721093135775, 59.43501601748262, 3.7323313186268305));
  });

  test("interpolateZoom returns the expected duration", () {
    expect(interpolateZoom((0, 0, 1), (0, 0, 1.1)).duration, closeTo(67, 1));
    expect(interpolateZoom((0, 0, 1), (0, 0, 2)).duration, closeTo(490, 1));
    expect(interpolateZoom((0, 0, 1), (10, 0, 8)).duration, closeTo(2872.5, 1));
  });

  test("interpolateZoom parameter rho() defaults to sqrt(2)", () {
    expect(interpolateZoom((0, 0, 1), (10, 10, 5))(0.5),
        CloseToView(interpolateZoomRho(sqrt(2))((0, 0, 1), (10, 10, 5))(0.5)));
  });

  test("interpolateZoomRho(0) is (almost) linear", () {
    final interp = interpolateZoomRho(0)((0, 0, 1), (10, 0, 8));
    expect(interp(0.5), CloseToView((1.111, 0, sqrt(8)), 1e-3));
    expect(interp.duration.round(), 1470);
  });

  test("interpolateZoomRho(2) has a high curvature and takes more time", () {
    final interp = interpolateZoomRho(2)((0, 0, 1), (10, 0, 8));
    expect(interp(0.5), CloseToView((1.111, 0, 12.885), 1e-3));
    expect(interp.duration.round(), 3775);
  });
}
