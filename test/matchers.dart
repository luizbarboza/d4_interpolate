import 'package:d4_interpolate/src/zoom.dart';
import 'package:test/test.dart';

class CloseToView extends CustomMatcher {
  CloseToView(matcher, [num delta = 1e-6])
      : super(
            "View which when represented as [cx, cy, width] is approximately equal to",
            "a representation",
            [matcher.$1, matcher.$2, matcher.$3]
                .map((v) => closeTo(v, delta))
                .toList());

  @override
  featureValueOf(actual) => [(actual as View).$1, actual.$2, actual.$3];
}
