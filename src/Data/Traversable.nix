let
  # This is foldr from nixpkgs/lib/lists.nix
  foldr = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n == len
        then nul
        else op (builtins.elemAt list n) (fold' (n + 1));
    in fold' 0;
in
{
  # type:
  #    (m (a -> b) -> m a -> m b)  # apply
  # -> ((a -> b) -> m a -> m b)    # map
  # -> (a -> m a)                  # pure
  # -> (a -> m b)
  # -> Array a
  # -> m (Array b)
  #
  # Implementation is based on Haskell's Data.Traversable [] instance.
  traverseArrayImpl = apply: fmap: pure: f: arr:
    let
      cons = m: ms: [m] ++ ms;
      cons_f = x: ys: apply (fmap cons (f x)) ys;
    in
    foldr cons_f (pure []) arr;
}
