import 'list.dart';
import 'map.dart';

/// Returns [n] uniformly-spaced samples from the specified [interpolator],
/// where [n] is an integer greater than one.
///
/// The first sample is always at *t* = 0, and the last sample is always at *t*
/// = 1. This can be useful in generating a fixed number of samples from a given
/// interpolator, such as to derive the range of a
/// [quantize scale](https://github.com/d3/d3-scale/blob/master/README.md#quantize-scales)
/// from a [continuous interpolator](https://github.com/d3/d3-scale-chromatic/blob/master/README.md#interpolateWarm).
///
/// Caution: this method will not work with interpolators that do not return
/// defensive copies of their output, such as [interpolateList] and
/// [interpolateMap]. For those interpolators, you must wrap the interpolator
/// and create a copy for each returned value.
List<T> quantize<T>(T Function(num) interpolator, int n) {
  return List.generate(n, (i) => interpolator(i / (n - 1)));
}
