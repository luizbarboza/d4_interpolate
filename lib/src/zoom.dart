import 'dart:math';

const _epsilon2 = 1e-12;

num _cosh(num x) {
  return ((x = exp(x)) + 1 / x) / 2;
}

num _sinh(num x) {
  return ((x = exp(x)) - 1 / x) / 2;
}

num _tanh(num x) {
  return ((x = exp(2 * x)) - 1) / (x + 1);
}

typedef View = (num, num, num);

abstract class ZoomInterpolator {
  final num _rho, _s;

  late num duration = _s * 1000 * _rho / sqrt2;

  ZoomInterpolator(this._rho, this._s);

  View call(num t);
}

class _EspecialZoomInterpolator extends ZoomInterpolator {
  final num _ux0, _uy0, _w0, _dx, _dy;

  _EspecialZoomInterpolator(
      super.rho, super._s, this._ux0, this._uy0, this._w0, this._dx, this._dy);

  @override
  call(t) => (_ux0 + t * _dx, _uy0 + t * _dy, _w0 * exp(_rho * t * _s));
}

class _GeneralZoomInterpolator extends ZoomInterpolator {
  final num _rho2, _ux0, _uy0, _w0, _dx, _dy, _d1, _r0;

  _GeneralZoomInterpolator(super.rho, this._rho2, super._s, this._ux0,
      this._uy0, this._w0, this._dx, this._dy, this._d1, this._r0);

  @override
  call(t) {
    var s = t * _s,
        coshr0 = _cosh(_r0),
        u = _w0 / (_rho2 * _d1) * (coshr0 * _tanh(_rho * s + _r0) - _sinh(_r0));
    return (
      _ux0 + u * _dx,
      _uy0 + u * _dy,
      _w0 * coshr0 / _cosh(_rho * s + _r0)
    );
  }
}

/// Returns a new zoom interpolator using the specified curvature [rho].
///
/// When [rho] is close to 0, the interpolator is almost linear. The default
/// curvature is sqrt(2).
ZoomInterpolator Function(View, View) interpolateZoomRho(num rho) {
  var rho_ = max(1e-3, rho), rho2 = rho_ * rho_, rho4 = rho2 * rho2;

  return (a, b) {
    var (ux0, uy0, w0) = a;
    var (ux1, uy1, w1) = b;

    num dx = ux1 - ux0, dy = uy1 - uy0, d2 = dx * dx + dy * dy, S;

    // Special case for u0 ≅ u1.
    if (d2 < _epsilon2) {
      print("test");
      S = log(w1 / w0) / rho_;
      return _EspecialZoomInterpolator(rho_, S, ux0, uy0, w0, dx, dy);
    }

    // General case.
    else {
      var d1 = sqrt(d2),
          b0 = (w1 * w1 - w0 * w0 + rho4 * d2) / (2 * w0 * rho2 * d1),
          b1 = (w1 * w1 - w0 * w0 - rho4 * d2) / (2 * w1 * rho2 * d1),
          r0 = log(sqrt(b0 * b0 + 1) - b0),
          r1 = log(sqrt(b1 * b1 + 1) - b1);
      S = (r1 - r0) / rho_;
      return _GeneralZoomInterpolator(
          rho_, rho2, S, ux0, uy0, w0, dx, dy, d1, r0);
    }
  };
}

var _interpolateZoom = interpolateZoomRho(sqrt2);

/// Returns an interpolator between the two views [a] and [b] of a
/// two-dimensional plane, based on
/// [“Smooth and efficient zooming and panning”](http://www.win.tue.nl/~vanwijk/zoompan.pdf)
/// by Jarke J. van Wijk and Wim A.A. Nuij.
///
/// Each view is defined as an record of three numbers: *cx*, *cy* and *width*.
/// The first two coordinates *cx*, *cy* represent the center of the viewport;
/// the last coordinate *width* represents the size of the viewport.
///
/// The returned interpolator exposes a [ZoomInterpolator.duration] property
/// which encodes the recommended transition duration in milliseconds. This
/// duration is based on the path length of the curved trajectory through
/// *x*,*y* space. If you want a slower or faster transition, multiply this by
/// an arbitrary scale factor (*V* as described in the original paper).
ZoomInterpolator interpolateZoom(View a, View b) => _interpolateZoom(a, b);
