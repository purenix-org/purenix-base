{
  pureE = a: _: a;

  bindE = x: f: _:
    let
      r = x null;
    in
    builtins.seq r (f r null);
}
