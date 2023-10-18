import 'dart:math';
import 'dart:typed_data';

import 'package:d4_color/d4_color.dart';

import 'date.dart';
import 'map.dart';
import 'number.dart';
import 'number_list.dart';
import 'rgb.dart';
import 'value.dart';

/// Returns an interpolator between the two lists [a] and [b].
///
/// If [b] is a [TypedData] (e.g., [Float64List]), [interpolateNumberList] is
/// called instead.
///
/// Internally, an list template is created that is the same length as [b]. For
/// each element in [b], if there exists a corresponding element in [a], a
/// generic interpolator is created for the two elements using [interpolate]. If
/// there is no such element, the static value from [b] is used in the template.
/// Then, for the given parameter *t*, the template’s embedded interpolators are
/// evaluated. The updated list template is then returned.
///
/// For example, if [a] is the list `[0, 1]` and [b] is the list `[1, 10, 100]`,
/// then the result of the interpolator for *t* = 0.5 is the list
/// `[0.5, 5.5, 100]`.
///
/// Note: **no defensive copy** of the template list is created; modifications
/// of the returned list may adversely affect subsequent evaluation of the
/// interpolator. No copy is made for performance reasons; interpolators are
/// often part of the inner loop of animated transitions.
///
/// {@category Value interpolation}
List<Object?> Function(num) interpolateList<T>(List<T> a, List<T> b) {
  if (b is TypedData) {
    return interpolateNumberList(a as List<num>, b as List<num>);
  }

  var nb = b.length,
      na = min(nb, a.length),
      l = b is List<num>
          ? interpolateNumber
          : b is List<String>
              ? interpolateColorOrString
              : b is List<Color>
                  ? interpolateRgb
                  : b is List<DateTime>
                      ? interpolateDate
                      : b is List<List>
                          ? interpolateList
                          : b is List<Map>
                              ? interpolateMap
                              : interpolate,
      x = List<Object? Function(num)>.generate(na, (i) => l(a[i], b[i])),
      c = List<Object?>.generate(nb, (i) => b[i]),
      i = 0;

  return (t) {
    for (i = 0; i < na; ++i) {
      c[i] = x[i](t);
    }
    return c;
  };
}
