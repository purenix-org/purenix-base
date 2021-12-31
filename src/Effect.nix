{
  pureE = a: _: a;
  bindE = x: f: _:
    let r = x null; in
    if r == null then f r null else f r null;
}
