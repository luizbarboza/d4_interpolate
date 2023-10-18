/// Returns an interpolator between the two dates [a] and [b].
///
/// Note: A new Date instance is always returned for every evaluation of the
/// interpolator, even though this has a known impact on performance.
///
/// {@category Value interpolation}
DateTime Function(num) interpolateDate(DateTime a, DateTime b) {
  return (t) {
    return DateTime.fromMillisecondsSinceEpoch(
        (a.millisecondsSinceEpoch * (1 - t) + b.millisecondsSinceEpoch * t)
            .truncate());
  };
}
