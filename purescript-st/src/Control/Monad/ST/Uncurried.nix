{
  mkSTFn1 = fn: x: f x null;
  mkSTFn2 = fn: { a, b }: fn a b null;
  mkSTFn3 = fn: { a, b, c }: fn a b c null;
  mkSTFn4 = fn: { a, b, c, d }: fn a b c d null;
  mkSTFn5 = fn: { a, b, c, d, e }: fn a b c d e null;
  mkSTFn6 = fn: { a, b, c, d, e, f }: fn a b c d e f null;
  mkSTFn7 = fn: { a, b, c, d, e, f, g }: fn a b c d e f g null;
  mkSTFn8 = fn: { a, b, c, d, e, f, g, h }: fn a b c d e f g h null;
  mkSTFn9 = fn: { a, b, c, d, e, f, g, h, i }: fn a b c d e f g h i null;
  mkSTFn10 = fn: { a, b, c, d, e, f, g, h, i, j }: fn a b c d e f g h i j null;
  runSTFn1 = fn: x: _: fn x;
  runSTFn2 = fn: a: b: _: fn { inherit a b; };
  runSTFn3 = fn: a: b: c: _: fn { inherit a b c; };
  runSTFn4 = fn: a: b: c: d: _: fn { inherit a b c d; };
  runSTFn5 = fn: a: b: c: d: e: _: fn { inherit a b c d e; };
  runSTFn6 = fn: a: b: c: d: e: f: _: fn { inherit a b c d e f; };
  runSTFn7 = fn: a: b: c: d: e: f: g: _: fn { inherit a b c d e f g; };
  runSTFn8 = fn: a: b: c: d: e: f: g: h: _: fn { inherit a b c d e f g h; };
  runSTFn9 = fn: a: b: c: d: e: f: g: h: i: _: fn { inherit a b c d e f g h i; };
  runSTFn10 = fn: a: b: c: d: e: f: g: h: i: j: _: fn { inherit a b c d e f g h i j; };
}
