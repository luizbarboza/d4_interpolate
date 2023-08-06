import 'number.dart';

final _re = RegExp(r"[-+]?(?:\d+\.?\d*|\.?\d+)(?:[eE][-+]?\d+)?");

String Function(num) _zero(String b) {
  return (_) {
    return b;
  };
}

String Function(num) _one(num Function(num) b) {
  return (t) {
    return b(t).toString();
  };
}

/// Returns an interpolator between the two strings [a] and [b].
///
/// The string interpolator finds numbers embedded in [a] and [b], where each
/// number is of the form understood by Dart. A few examples of numbers that
/// will be detected within a string: `-1`, `42`, `3.14159`, and
/// `6.0221413e+23`.
///
/// For each number embedded in [b], the interpolator will attempt to find a
/// corresponding number in [a]. If a corresponding number is found, a numeric
/// interpolator is created using [interpolateNumber]. The remaining parts of
/// the string [b] are used as a template: the static parts of the string [b]
/// remain constant for the interpolation, with the interpolated numeric values
/// embedded in the template.
///
/// For example, if [a] is `"300 12px sans-serif"`, and [b] is
/// `"500 36px Comic-Sans"`, two embedded numbers are found. The remaining
/// static parts (of string [b]) are a space between the two numbers (`" "`),
/// and the suffix (`"px Comic-Sans"`). The result of the interpolator at *t* =
/// 0.5 is `"400 24px Comic-Sans"`.
String Function(num) interpolateString(String a, String b) {
  var bi = 0,
      am = _re.allMatches(a).iterator,
      bm = _re.allMatches(b).iterator,
      i = -1,
      s = <String?>[],
      q = <(int, num Function(num))>[];
  late String bs;

  while (am.moveNext() && bm.moveNext()) {
    var ami = am.current, bmi = bm.current;
    if (bmi.start > bi) {
      bs = b.substring(bi, bmi.start);
      if (_elementAtOrNull(s, i) != null) {
        s[i] = s[i]! + bs; // coalesce with previous string
      } else {
        i++;
        s.add(bs);
      }
    }
    String ams, bms;
    if ((ams = ami[0]!) == (bms = bmi[0]!)) {
      if (_elementAtOrNull(s, i) != null) {
        s[i] = s[i]! + bms; // coalesce with previous string
      } else {
        i++;
        s.add(bms);
      }
    } else {
      // interpolate non-matching numbers
      i++;
      s.add(null);
      q.add((i, interpolateNumber(num.parse(ams), num.parse(bms))));
    }
    bi = bmi.end;
  }

  // Add remains of b.
  if (bi < b.length) {
    bs = b.substring(bi);
    if (_elementAtOrNull(s, i) != null) {
      s[i] = s[i]! + bs; // coalesce with previous string
    } else {
      i++;
      s.add(bs);
    }
  }

  // Special optimization for only a single match.
  // Otherwise, interpolate each of the numbers and rejoin the string.
  return s.length < 2
      ? (q.isNotEmpty ? _one(q[0].$2) : _zero(b))
      : (t) {
          (int, num Function(num)) o;
          for (int i = 0; i < q.length; ++i) {
            s[(o = q[i]).$1] = o.$2(t).toString();
          }
          return s.join("");
        };
}

T? _elementAtOrNull<T>(List<T> s, int i) => i > 0 && i < s.length ? s[i] : null;
