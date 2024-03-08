/// Interpolate numbers, colors, strings, lists, maps, whatever!
///
/// This package provides a variety of interpolation methods for blending
/// between two values. Values may be numbers, colors, strings, lists, or even
/// deeply-nested maps. For example:
///
/// ```dart
/// final i = interpolateNumber(10, 20);
/// i(0.0); // 10
/// i(0.2); // 12
/// i(0.5); // 15
/// i(1.0); // 20
/// ```
///
/// The returned function `i` is called an *interpolator*. Given a starting
/// value *a* and an ending value *b*, it takes a parameter *t* in the domain
/// \[0, 1\] and returns the corresponding interpolated value. An interpolator
/// typically returns a value equivalent to *a* at *t* = 0 and a value
/// equivalent to *b* at *t* = 1.
///
/// You can interpolate more than just numbers. To find the perceptual midpoint
/// between steelblue and brown:
///
/// ```dart
/// interpolateLab("steelblue", "brown")(0.5); // rgb(142, 92, 109)
/// ```
///
/// Or, as a color ramp from *t* = 0 to *t* = 1:
///
/// {@inject-html}
/// <div id="obs">
///     <div id="in"></div>
///     <div id="out"></div>
/// </div>
///
/// <script type="module">
///
///     import { Runtime, Inspector, Library } from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@5/dist/runtime.js";
///     import * as d3 from "https://cdn.jsdelivr.net/npm/d3@7/+esm";
///
///     const obs = d3.select("#obs");
///
///     const runtime = new Runtime();
///     const module = runtime.module();
///     const inspector = new Inspector(obs.select("#out").node());
///
///     module.define("color", [], () => d3.interpolateLab("steelblue", "brown"));
///     module.define("n", 256);
///     module.variable(inspector).define("out", ["color", "n"], definition);
///
///     function definition(color, n) {
///         const canvas = d3.create("canvas")
///             .style("width", "100%")
///             .style("height", "40px")
///             .style("image-rendering", "-moz-crisp-edges")
///             .style("image-rendering", "pixelated")
///             .node();
///
///         canvas.width = n;
///         canvas.height = 1;
///         const context = canvas.getContext("2d");
///         for (let i = 0; i < n; ++i) {
///           context.fillStyle = color(i / (n - 1));
///           context.fillRect(i, 0, 1, 1);
///         }
///
///         return canvas;
///     }
/// </script>
/// {@end-inject-html}
///
/// Here’s a more elaborate example demonstrating type inference used by
/// [interpolate](https://pub.dev/documentation/d4_interpolate/latest/d4_interpolate/interpolate.html):
///
/// ```dart
/// final i = interpolate({"colors": ["red", "blue"]}, {"colors": ["white", "black"]});
/// i(0.0); // {colors: [rgb(255, 0, 0), rgb(0, 0, 255)]}
/// i(0.5); // {colors: [rgb(255, 128, 128), rgb(0, 0, 128)]}
/// i(1.0); // {colors: [rgb(255, 255, 255), rgb(0, 0, 0)]}
/// ```
///
/// Note that the generic value interpolator detects not only nested maps and
/// lists, but also color strings and numbers embedded in strings!
export 'src/d4_interpolate.dart';
