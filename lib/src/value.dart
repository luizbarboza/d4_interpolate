import 'dart:typed_data';

import 'package:d4_color/d4_color.dart';

import 'constant.dart';
import 'date.dart';
import 'list.dart';
import 'map.dart';
import 'number.dart';
import 'number_list.dart';
import 'rgb.dart';
import 'string.dart';

/// Returns an interpolator between the two arbitrary values [a] and [b].
///
/// The interpolator implementation is based on the type of the end value [b],
/// using the following algorithm:
///
/// 1. If [b] is a number, use [interpolateNumber].
/// 2. If [b] is a [Color] or a string that can be converted to a [Color], use
/// [interpolateRgb].
/// 3. If [b] is a [DateTime], use [interpolateDate].
/// 4. If [b] is a string, use [interpolateString].
/// 6. If [b] is a [TypedData], use [interpolateNumberList].
/// 5. If [b] is a [List], use [interpolateList].
/// 6. Otherwise, it uses the constant [b].
///
/// It's important to note that, unless the chosen interpolator allows
/// otherwise, [a] and [b] must be of the same type.
Object? Function(num) interpolate(Object? a, Object? b) {
  return (b is num
      ? interpolateNumber
      : b is String
          ? interpolateColorOrString
          : b is Color
              ? interpolateRgb
              : b is DateTime
                  ? interpolateDate
                  : b is List
                      ? interpolateList
                      : b is Map
                          ? interpolateMap
                          : _object)(a, b);
}

String Function(num) interpolateColorOrString(String a, String b) {
  var c = Color.tryParse(b);
  return c != null ? interpolateRgb(a, c) : interpolateString(a, b);
}

T Function(num) _object<T>(T a, T b) => constant(b);
