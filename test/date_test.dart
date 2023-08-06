import 'package:d4_interpolate/d4_interpolate.dart';
import 'package:test/test.dart';

void main() {
  test("interpolateDate(a, b) interpolates between two dates a and b", () {
    final i = interpolateDate(DateTime(2000, 0, 1), DateTime(2000, 0, 2));
    expect(i(0.0), isA<DateTime>());
    expect(i(0.5), isA<DateTime>());
    expect(i(1.0), isA<DateTime>());
    expect(i(0.2).millisecondsSinceEpoch,
        DateTime(2000, 0, 1, 4, 48).millisecondsSinceEpoch);
    expect(i(0.4).millisecondsSinceEpoch,
        DateTime(2000, 0, 1, 9, 36).millisecondsSinceEpoch);
  });

  test("interpolateDate(a, b) does not reuses the output datea", () {
    final i = interpolateDate(DateTime(2000, 0, 1), DateTime(2000, 0, 2));
    expect(i(0.2), isNot(i(0.4)));
  });

  test("interpolateDate(a, b) gives exact ends for t=0 and t=1", () {
    final a = DateTime((1e8 * 24 * 60 * 60 * 1000).truncate()),
        b = DateTime((-1e8 * 24 * 60 * 60 * 1000 + 1).truncate());
    expect(interpolateDate(a, b)(1).millisecondsSinceEpoch,
        b.millisecondsSinceEpoch);
    expect(interpolateDate(a, b)(0).millisecondsSinceEpoch,
        a.millisecondsSinceEpoch);
  });
}
