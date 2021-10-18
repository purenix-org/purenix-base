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
  #    forall m a b
  #  . (forall x y. m (x -> y) -> m x -> m y)  # apply
  # -> (forall x y. (x -> y) -> m x -> m y)    # fmap
  # -> (forall x. x -> m x)                    # pure
  # -> (a -> m b)                              # f
  # -> Array a
  # -> m (Array b)
  #
  # Implementation is based on Haskell's Data.Traversable [] instance.
  traverseArrayImpl = apply: fmap: pure: f: arr:
    let
      # :: forall x. x -> Array x -> Array x
      cons = m: ms: [m] ++ ms;
      # :: a -> m (Array b) -> m (Array b)
      cons_f = x: ys: apply (fmap cons (f x)) ys;
    in
    foldr cons_f (pure []) arr;
}
