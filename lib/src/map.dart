import 'package:d4_color/d4_color.dart';

import 'date.dart';
import 'list.dart';
import 'number.dart';
import 'rgb.dart';
import 'value.dart';

/// Returns an interpolator between the two objects [a] and [b].
///
/// Internally, an map template is created that has the same properties as [b].
/// For each property in [b], if there exists a corresponding property in [a], a
/// generic interpolator is created for the two elements using [interpolate]. If
/// there is no such property, the static value from [b] is used in the
/// template. Then, for the given parameter *t*, the template's embedded
/// interpolators are evaluated and the updated map template is then returned.
///
/// For example, if [a] is the map `{"x": 0, "y": 1}` and [b] is the map
/// `{x: 1, y: 10, z: 100}`, the result of the interpolator for *t* = 0.5 is the
/// map `{x: 0.5, y: 5.5, z: 100}`.
///
/// Map interpolation is particularly useful for dataspace interpolation, where
/// data is interpolated rather than attribute values.
///
/// Note: **no defensive copy** of the template map is created; modifications of
/// the returned map may adversely affect subsequent evaluation of the
/// interpolator. No copy is made for performance reasons; interpolators are
/// often part of the inner loop of animated transitions.
///
/// {@category Value interpolation}
Map<K, Object?> Function(num) interpolateMap<K, V>(Map<K, V> a, Map<K, V> b) {
  var i = <K, Object? Function(num)>{},
      c = <K, Object?>{},
      l = b is Map<K, num>
          ? interpolateNumber
          : b is Map<K, String>
              ? interpolateColorOrString
              : b is Map<K, Color>
                  ? interpolateRgb
                  : b is Map<K, DateTime>
                      ? interpolateDate
                      : b is Map<K, List>
                          ? interpolateList
                          : b is Map<K, Map>
                              ? interpolateMap
                              : interpolate;

  for (var MapEntry(:key, :value) in b.entries) {
    if (a.containsKey(key)) {
      i[key] = l(a[key]!, value);
    } else {
      c[key] = value;
    }
  }

  return (t) {
    for (var MapEntry(:key, :value) in i.entries) {
      c[key] = value(t);
    }
    return c;
  };
}
