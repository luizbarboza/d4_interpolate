[![Dart CI](https://github.com/luizbarboza/d4_interpolate/actions/workflows/ci.yml/badge.svg)](https://github.com/luizbarboza/d4_interpolate/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/d4_interpolate.svg)](https://pub.dev/packages/d4_interpolate)
[![package publisher](https://img.shields.io/pub/publisher/d4_interpolate.svg)](https://pub.dev/packages/d4_interpolate/publisher)

Interpolate numbers, colors, strings, arrays, objects, whatever!

This package provides a variety of interpolation methods for blending
between two values. Values may be numbers, colors, strings, lists, or even
deeply-nested maps. For example:

```dart
final i = interpolateNumber(10, 20);
i(0.0); // 10
i(0.2); // 12
i(0.5); // 15
i(1.0); // 20
```

The returned function `i` is called an interpolator. Given a starting value
*a* and an ending value *b*, it takes a parameter *t* in the domain \[0, 1\]
and returns the corresponding interpolated value between *a* and *b*. An
interpolator typically returns a value equivalent to *a* at *t* = 0 and a
value equivalent to *b* at *t* = 1.

You can interpolate more than just numbers. To find the perceptual midpoint
between steelblue and brown:

```dart
interpolateLab("steelblue", "brown")(0.5); // "rgb(142, 92, 109)"
```

Here’s a more elaborate example demonstrating type inference used by
[interpolate](https://pub.dev/documentation/d4_interpolate/latest/d4_interpolate/interpolate.html):

```dart
final i = interpolate({"colors": ["red", "blue"]}, {"colors": ["white", "black"]});
i(0.0); // {colors: [rgb(255, 0, 0), rgb(0, 0, 255)]}
i(0.5); // {colors: [rgb(255, 128, 128), rgb(0, 0, 128)]}
i(1.0); // {colors: [rgb(255, 255, 255), rgb(0, 0, 0)]}
```

Note that the generic value interpolator detects not only nested maps and
lists, but also color strings and numbers embedded in strings!

See one of:

* [Value interpolation](https://pub.dev/documentation/d4_array/latest/topics/Value%20interpolation-topic.html) - These are the most general interpolators, suitable for most values.
* [Color interpolation](https://pub.dev/documentation/d4_array/latest/topics/Color%20interpolation-topic.html) - Interpolators for colors in various color spaces.
* [Zoom interpolation](https://pub.dev/documentation/d4_array/latest/topics/Zoom%20interpolation-topic.html) - An interpolator for zooming smoothly between two views of a two-dimensional plane based on [“Smooth and efficient zooming and panning”](https://www.win.tue.nl/~vanwijk/zoompan.pdf) by Jarke J. van Wijk and Wim A.A. Nuij.